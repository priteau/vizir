require 'test_helper'

class VizirTest < Test::Unit::TestCase
  TIMES = [
    [0,   [0,   "second"]],
    [1,   [1,   "second"]],
    [30,  [30,  "seconds"]],
    [59,  [59,  "seconds"]],
    [60,  [1,   "minute"]],
    [119, [1,   "minute"]],
    [120, [2,   "minutes"]]
  ]
  def test_humanize_time
    TIMES.each do |seconds, result|
      assert_equal(result, Vizir.humanize_time(seconds))
    end
    e = assert_raise(RuntimeError) { Vizir.humanize_time(-1) }
    assert_equal("Can't humanize negative period", e.message)
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

end
