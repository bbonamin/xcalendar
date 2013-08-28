module XCalendar
  class Iteration
    attr_accessor :flight_dates

    def initialize(start_date: raise(ArgumentError, 'Start date is required'), end_date: raise(ArgumentError, 'End date is required'))
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      create
    end

    def flight_dates
      @flight_dates ||= {}
    end

    private
      def create
        iteration_pilots = XCalendar::PILOTS.dup
        current_date = @start_date
        week = Week.new(covering: current_date)
        while week.within?(@start_date, @end_date) do
          build_flight_dates_for_pilots(pilots: iteration_pilots, week: week)
          week.advance!
          iteration_pilots = XCalendar::PILOTS.dup
        end
      end

      def build_flight_dates_for_pilots(pilots: raise(ArgumentError), week: raise(ArgumentError))
        week.flyable_days.each do |day|
          if (@start_date..@end_date).cover? day
            flight_dates[day] = []
            pilots = pilots.shuffle
            2.times { flight_dates[day] << pilots.slice!(0) }
          end
        end
      end
  end
end