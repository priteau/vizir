require 'json'
require 'restclient'

module Vizir
  APIURL = "https://localhost:8080/oargridapi"
  IGNORED_SITES = ['grenoble-exp', 'grenoble-ext', 'grenoble-obs', 'luxembourg', 'portoalegre']
  
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

  def Vizir.get(api, uri)
    begin
      return JSON.parse(api[uri + '?structure=simple'].get(:accept => 'application/json'))
    rescue RestClient::RequestTimeout => e
      # This should really be elsewhere, but will do for now
      # Were we querying a specific site? If yes, remove it from $sites
      if uri =~ /\/sites\/(\w+)/
        $sites.delete_if { |site| site['site'] == "#{$1}" }
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

  end
end
