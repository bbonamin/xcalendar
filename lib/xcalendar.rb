require "xcalendar/version"
require "xcalendar/week"


module XCalendar
  PILOTS = ['Claudio Binimelis',
            'Andrés boretti',
            'Pablo Codoni',
            'Ezequiel Gauna',
            'David Luna',
            'Nico Verdura',
            'Bruno Bonamin',
            'Seba Nicola' ]

  HOLIDAYS = ['2013-10-14',
              '2013-11-25',
              '2013-12-08',
              '2013-12-25',
              '2014-01-01',
              '2014-03-03',
              '2014-03-04',
              '2014-03-24']

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
