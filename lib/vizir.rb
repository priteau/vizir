class Vizir
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
end
