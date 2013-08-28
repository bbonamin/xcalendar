module XCalendar
  class Iteration
    attr_accessor :flight_dates, :last_date

    def initialize(start_date: raise(ArgumentError, 'Start date is required'))
      @start_date = if start_date.is_a? Date
              start_date
            else
              Date.parse(start_date)
            end
      create
    end

    def flight_dates
      @flight_dates ||= {}
    end

    private
      def create
        @iteration_pilots = XCalendar::PILOTS.dup
        week = Week.new(covering: @start_date)
        while not(@iteration_pilots.empty?) do
          build_flight_dates_for_pilots(week: week)
          week.advance!
        end
        self.last_date = flight_dates.keys.last
        self
      end

      def build_flight_dates_for_pilots(week: raise(ArgumentError))
        week.flyable_days.each do |day|
          flight_dates[day] = []
          @iteration_pilots = @iteration_pilots.shuffle
          2.times { flight_dates[day] << @iteration_pilots.slice!(0) }
        end
      end
  end
end