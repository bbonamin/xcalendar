require 'date'

require "xcalendar/version"
require "xcalendar/iteration"
require "xcalendar/core_extensions"
require 'csv'

module XCalendar
    PILOTS = [
      'Manso',
      'Osella',
      'Lage',
      'Terre',
      'Nicola',
      'Alvarez'
    ]

    HOLIDAYS = [
      '2019-10-18',
      '2019-12-08',
      '2019-12-25',
      '2020-01-01',
      '2018-03-24'
    ]

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
      last_pilots = []
      while last_date < end_date do
        iteration = XCalendar::Iteration.new(start_date: last_date, end_date: end_date, last_pilots: last_pilots)
        last_date = iteration.last_date
        self.iterations << iteration
        last_pilots = iteration.last_pilots
      end
    end

    def export_to_csv(file:'iteraciones.csv')
      CSV.open(file, 'w') do |csv|
        csv << %w( Número Fecha Pilotos)

        self.iterations.each_with_index do |iteration, index|
          iteration.flight_dates.each do |date, pilots|
            csv << [index+1, date.strftime("%d/%m/%Y"), pilots.join(', ')]
          end
        end
      end
    end
  end
end
