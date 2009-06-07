require 'json'
require 'restclient'

module Vizir
  APIURL = "https://localhost:8080/oargridapi"
  IGNORED_SITES = ['grenoble-exp', 'grenoble-ext', 'grenoble-obs', 'luxembourg', 'portoalegre']
  FIRST_ALERT_TIME = 600

  def Vizir.humanize_time(time)
    fail "Can't humanize negative period" if time < 0

    if time >= 60
      remaining_time = time / 60
      remaining_time_unit = "minute"
    else
      remaining_time = time
      remaining_time_unit = "second"
    end

    if remaining_time > 1
      remaining_time_unit += "s"
    end

    return remaining_time, remaining_time_unit
  end

  def Vizir.get_remaining_time(end_time, now)
    return  (end_time - now).round
  end

  def Vizir.get(api, uri)
    begin
      return JSON.parse(api[uri + '?structure=simple'].get(:accept => 'application/json'))
    rescue RestClient::RequestTimeout => e
      # This should really be elsewhere, but will do for now
      # Were we querying a specific site? If yes, remove it from $sites
      if uri =~ /\/sites\/(\w+)/
        $sites.delete_if { |site| site['site'] == "#{$1}" }
        return nil
      else
        raise e
      end
    rescue => e
      if e.respond_to?('http_code')
        puts "Error: #{e.http_code}:\n #{e.response.body}"
        return nil
      else
        puts e.inspect
        exit 1
      end
    end
  end

  def Vizir.learn_sites(api, ignored_sites)
    return get(api, '/sites').delete_if { |hash| ignored_sites.include?(hash["site"]) }
  end

  def Vizir.get_api(uri)
    return RestClient::Resource.new(uri, :timeout => 15)
  end

  def Vizir.learn_new_jobs_on_site(api, site)
    site_name = site['site']
    jobs = Vizir.get(api, "#{site['uri']}/jobs")
    return if jobs.nil?
    jobs.each do |job|
      if job['owner'] == $login
        job_details = Vizir.get(api, "#{job['uri']}")
        break if job_details == nil
        if job_details['jobType'] == 'INTERACTIVE'
          jobid = job_details['Job_Id']
          # If we don't yet know the job, record it in $jobs
          if $jobs[jobid].nil?
            $jobs[jobid] = Vizir::Job.new(jobid, Time.at(Integer(job_details['startTime']) + Integer(job_details['walltime'])), site_name.capitalize)
          end
        end
      end
    end
  end

  def Vizir.learn_new_jobs(api)
    $sites.each do |site|
      Vizir.learn_new_jobs_on_site(api, site)
    end
  end

  def Vizir.first_ending_job
    $jobs.sort{|a,b| a[1].end_time <=> b[1].end_time}.first
  end

  def Vizir.alert_jobs(api)
    $jobs.each do |jobid, job|
      if job.should_be_ending?
        # Check if the job still exists before sending a notification
        if job.is_ended?(api)
          # Job is not running anymore, remove it from the hash
          $jobs.delete(jobid)
          next
        end
        remaining_sec = Vizir.get_remaining_time(job.end_time, Time.now)
        if remaining_sec < 0
          $stderr.puts "Error: negative time"
          next
        end
        remaining_time, remaining_time_unit = Vizir.humanize_time(remaining_sec)
        notify_via_growl(jobid, job.site_name, remaining_time, remaining_time_unit)
      end
    end
  end

  class Job
    attr_reader :id, :end_time, :site_name

    def initialize(id, end_time, site_name)
      @id = id
      @end_time = end_time
      @site_name = site_name
    end

    def Job.create_from_json(json, site_name)
      return Job.new(json['Job_Id'], Time.at(Integer(json['startTime']) + Integer(json['walltime'])), site_name.capitalize)
    end

    def fetch_details(api)
      return Vizir.get(api, "/sites/#{@site_name.downcase}/jobs/#{@id}")
    end

    def should_be_ending?(now)
      return Vizir.get_remaining_time(self.end_time, now) <= Vizir::FIRST_ALERT_TIME
    end

    def is_ended?(api)
      updatedjob = self.fetch_details(api)
      return updatedjob['state'] != 'Running'
    end

  end
end
