require 'test_helper'

class VizirTest < Test::Unit::TestCase
  TIMES = [
    [-119,  "now"],
    [-1,    "now"],
    [0,     "now"],
    [1,     "in 1 second"],
    [30,    "in 30 seconds"],
    [59,    "in 59 seconds"],
    [60,    "in 1 minute"],
    [61,    "in 1 minute and 1 second"],
    [119,   "in 1 minute and 59 seconds"],
    [120,   "in 2 minutes"]
  ]
  def test_humanize_time
    TIMES.each do |seconds, result|
      assert_equal(result, Vizir.humanize_time(seconds))
    end
  end

  def test_learn_sites
    FakeWeb.allow_net_connect = false
    o = [
      {
        "site" => "nancy",
        "uri" => "/sites/nancy"
      },
      {
        "site" => "rennes",
        "uri" => "/sites/rennes"
      },
      {
        "site" => "luxembourg",
        "uri" => "/sites/luxembourg"
      }]
    json = JSON.generate(o)
    FakeWeb.register_uri(:get, "#{Vizir::APIURL}/sites?structure=simple", :string => json)
    api = Vizir.get_api(Vizir::APIURL)
    sites = o.delete_if { |hash| hash["site"] == "luxembourg" }
    ignored_sites = ["luxembourg", "portoalegre"]
    assert_equal(sites, Vizir.learn_sites(api, ignored_sites))
  end

  context "A Job instance" do
    setup do
      @job_endtime = Time.at(123456789)
      @job = Vizir::Job.new('1234', @job_endtime, 'Rennes')
    end

    context 'ending in FIRST_ALERT_TIME seconds' do
      setup do
        @now = Time.at(Integer(@job_endtime) - Integer(Vizir::FIRST_ALERT_TIME))
      end

      should 'be considered as ending soon' do
        assert_equal true, @job.should_be_ending?(@now)
      end
    end

    context 'ending in more than FIRST_ALERT_TIME seconds' do
      setup do
        @now = Time.at(Integer(@job_endtime) - Integer(Vizir::FIRST_ALERT_TIME + 1))
      end

      should 'not be considered as ending soon' do
        assert_equal false, @job.should_be_ending?(@now)
      end
    end
  end

  context 'A site-specific query' do
    setup do
      @uri = "#{Vizir::APIURL}/sites/rennes/jobs?structure=simple"
    end

    context 'which timeouts' do
      setup do
        FakeWeb.register_uri(:get, @uri, :exception => Timeout::Error)
        @api = Vizir.get_api(Vizir::APIURL)
      end

      should 'remove the site from the sites list' do
        $sites = [
          {
            "site" => "nancy",
            "uri" => "/sites/nancy"
          },
          {
            "site" => "rennes",
            "uri" => "/sites/rennes"
          }
        ]
        Vizir.learn_new_jobs_on_site(@api, $sites[1])
        assert_equal [{ "site" => "nancy", "uri" => "/sites/nancy" }], $sites
      end
    end
  end

end
