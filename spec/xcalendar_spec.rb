require 'rubygems'
require 'bundler'
Bundler.require(:default)

module XCalendar
  describe 'XCalendar' do
    it 'assigns two pilots per date' do
      iteration = Iteration.new(start_date: '2013-09-07')
      flight_date = iteration.flight_dates.first
      expect(flight_date.pilots.count).to eq(2)
      expect(XCalendar::PILOTS).to include(flight_date.pilots.first)
      expect(XCalendar::PILOTS).to include(flight_date.pilots.last)
    end
    it 'assigns pilots to weekend dates'
    it 'assigns pilots to holiday dates'
    it 'does not repeat a pilot in the same interation'
    it 'does not repeat a pilot ending an iteration and starting the next one'
    it 'starts on september 7, 2013'
    it 'ends on 31 march, 2014'
  end
end