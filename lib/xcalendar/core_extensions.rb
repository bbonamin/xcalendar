Date.class_eval do
  def holiday?
    XCalendar::HOLIDAYS.include? self.to_s 
  end
end