require 'pry'

module XCalendar
  class Week
    attr_accessor :beginning, :ending
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
      self.ending = current_date
    end

    def includes?(date)
      date= if date.is_a? Date
              date
            else
              Date.parse(date)
            end
      (beginning..ending).cover? date      
    end

    def flyable_days
      (beginning..ending).select{ |date| date.saturday? or date.sunday? or date.holiday?}
    end

    def advance!
      self.beginning = beginning + 7
      self.ending = ending + 7
    end
  end
end

Date.class_eval do
  def holiday?
    XCalendar::HOLIDAYS.include? self.to_s 
  end
end