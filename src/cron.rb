require 'date'

class Cron
  $schedule = [
      { mday: 1, mday_max: 8, wday: 3, description: "B" },
      { mday: 15, description: "a" }
  ]

  def next_event(start_date, schedule)
      upcoming_dates = schedule.map do |schedule_entry|
          date = start_date
          loop do
              if (! matches_scheduled_mday(date, schedule_entry))
                  date = next_scheduled_mday(date, schedule_entry)
                  next
              end

              if (! matches_scheduled_wday(date, schedule_entry))
                  date = next_scheduled_wday(date, schedule_entry)
                  next
              end
              break
          end
          [date, schedule_entry]
      end

      upcoming_dates.min_by{|a| a[0]}
  end

  def matches_scheduled_mday(date, schedule_entry)
      min_day = schedule_entry[:mday] ? schedule_entry[:mday] : 1
      max_day = schedule_entry[:mday_max] ? schedule_entry[:mday_max] : min_day + 1

      (date.mday >= min_day) && (date.mday < max_day)
  end

  def matches_scheduled_wday(date, schedule_entry)
      if schedule_entry[:wday]
          date.wday == schedule_entry[:wday]
      else
          true
      end
  end

  def next_scheduled_mday(start_date, schedule_entry)
      if (! schedule_entry[:mday])
          start_date
      else
          if (start_date.mday > schedule_entry[:mday])
              next_month = start_date.next_month
              Date.new(next_month.year, next_month.mon, schedule_entry[:mday])
          else
              Date.new(start_date.year, start_date.mon, schedule_entry[:mday])
          end
      end
  end

  def next_scheduled_wday(start_date, schedule_entry)
      if (! schedule_entry[:wday])
          start_date
      else
          if (start_date.wday > schedule_entry[:wday])
              start_date + (7 - start_date.wday) + schedule_entry[:wday]
          else
              start_date + (schedule_entry[:wday] - start_date.wday)
          end
      end
  end
end
# ---------- testing code follows -------------

#def expectation(e, a)
#    if e != a[0]
#        throw "mismatch: " + e.to_s + " != " + a[0].to_s
#    else
#        puts "success"
#    end
#    a
#end
#
#def tests
#    expectation(Date.new(2016, 3, 2), next_event(Date.new(2016, 3, 1), $schedule))
#    expectation(Date.new(2016, 3, 2), next_event(Date.new(2016, 3, 2), $schedule))
#    expectation(Date.new(2016, 3, 15), next_event(Date.new(2016, 3, 3), $schedule))
#    expectation(Date.new(2016, 3, 15), next_event(Date.new(2016, 3, 14), $schedule))
#    expectation(Date.new(2016, 3, 15), next_event(Date.new(2016, 3, 15), $schedule))
#    expectation(Date.new(2016, 4, 6), next_event(Date.new(2016, 3, 16), $schedule))
#end
#
#tests
