require 'test_helper'

class VizirTest < Test::Unit::TestCase
  TIMES = [
    [1,   [1,   "second"]],
    [30,  [30,  "seconds"]],
    [59,  [59,  "seconds"]],
    [60,  [1,   "minute"]],
    [120, [2,   "minutes"]]
  ]
  def test_humanize_time
    TIMES.each do |seconds, result|
      assert_equal(result, Vizir.humanize_time(seconds))
    end
    assert_raise(RuntimeError) { Vizir.humanize_time(-1) }
  end
end
