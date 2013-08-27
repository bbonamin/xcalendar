module XCalendar
  class Iteration
    attr_accessor :flight_dates

    def initialize(start_date: raise(ArgumentError, 'Start date is required'))
      @start_date = start_date
      create
    end

    def flight_dates
      @flight_dates ||= []
    end

    private
      def create
        iteration_pilots = XCalendar::PILOTS.dup
        current_date = @start_date
        week = Week.new(covering: current_date)
        build_flight_dates_for_pilots(pilots: iteration_pilots, week: week)
      end

      def build_flight_dates_for_pilots(pilots: raise(ArgumentError), week: raise(ArgumentError))
        week.each_flyable_day do
          flight_dates << pilots.shift(rand(0,pilots.length))
        end
      end
  end
end