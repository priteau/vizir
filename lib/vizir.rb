module Vizir
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

  class Job
    attr_reader :id, :end_time, :site_name

    def initialize(id, end_time, site_name)
      @id = id
      @end_time = end_time
      @site_name = site_name
    end
  end
end
