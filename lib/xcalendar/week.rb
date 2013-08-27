require 'pry'

module XCalendar
  class Week
    attr_accessor :beginning, :end
    def initialize(covering: raise(ArgumentError, 'Date to create week is required'))
      date= if covering.is_a? Date
              covering
            else
              Date.parse(covering)
            end

      # Get Monday
      current_date = date
      (current_date.wday-1).times do
        current_date = current_date.prev_day
      end
      self.beginning = current_date

      # Get Sunday
      current_date = date
      (7-current_date.wday).times do
        current_date = current_date.next_day
      end
      self.end = current_date
    end
  end
end