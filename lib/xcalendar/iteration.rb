module XCalendar
  class Iteration
    attr_accessor :flight_dates, :last_date, :last_pilots

    def initialize( start_date: raise(ArgumentError, 'Start date is required'), end_date: raise(ArgumentError, 'End date is required'), last_pilots: [])

      @start_date = if start_date.is_a? Date
              start_date
            else
              Date.parse(start_date)
            end
      @end_date = if end_date.is_a? Date
              end_date
            else
              Date.parse(end_date)
            end
      @last_pilots = last_pilots
      create
    end

    def flight_dates
      @flight_dates ||= {}
    end

    private
      def create
        @pilots = XCalendar::PILOTS.dup
        first = true
        flyable_days.each do |day|
          if not(@pilots.empty?) and day <= @end_date
            flight_dates[day] = []
            if last_pilots && (day - @start_date < 2)
              @pilots = (@pilots - last_pilots).shuffle + last_pilots
              first = false
            else
              @pilots = @pilots.shuffle
            end
            2.times { flight_dates[day] << @pilots.slice!(0) }
          end
        end
        self.last_date = flight_dates.keys.last + 1
        self.last_pilots = flight_dates.values.last
        self
      end

      def flyable_days
        (@start_date..@end_date).select{ |date| date.saturday? or date.sunday? or date.holiday?}
      end
  end
end