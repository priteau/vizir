class Vizir
  def Vizir.humanize_time(time)
    if time < 0 then
      fail "Can't humanize negative period"
    end

    if time >= 60 then
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
end
