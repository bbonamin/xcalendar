require "xcalendar/version"
require "xcalendar/week"
require "xcalendar/iteration"


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
  class Calendar
    attr_accessor :iterations
    attr_accessor :start_date, :end_date

    def initialize( start_date: raise(ArgumentError, 'Start date is required'), 
                    end_date: raise(ArgumentError, 'End date is required'))
      self.iterations ||= []
      self.start_date = Date.parse(start_date)
      self.end_date = Date.parse(end_date)

      create
    end

    def create
      last_date = start_date
      while last_date < end_date do
        iteration = XCalendar::Iteration.new(start_date: last_date, end_date: end_date) 
        last_date = iteration.last_date
        self.iterations << iteration
      end
    end
  end
end
