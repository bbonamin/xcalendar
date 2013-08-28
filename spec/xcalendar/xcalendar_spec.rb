require 'spec_helper'
require 'pry'

module XCalendar
  describe 'XCalendar' do
    let(:calendar) { XCalendar::Calendar.new(start_date: '2013-09-07', end_date: '2014-04-06') }
    it 'assigns two pilots per date' do
      flight_date = calendar.iterations.first.flight_dates.first
      expect(flight_date.last.count).to eq(2)
      expect(XCalendar::PILOTS).to include(flight_date.last.first)
      expect(XCalendar::PILOTS).to include(flight_date.last.last)
    end
    it 'never has a nil pilot in a flight_date' do
      nil_pilots_count = calendar.iterations.map(&:flight_dates).flatten.map(&:values).flatten.select{ |pilot| pilot.nil? }.count
      expect(nil_pilots_count).to be_zero  
    end
    it 'does not repeat a pilot in the same iteration'
    it 'does not repeat a pilot ending an iteration and starting the next one'
    it 'starts on the start date' do
      expect(calendar.iterations.first.flight_dates.keys.first).to eq(Date.parse('2013-09-07'))
    end
    it 'ends on the end date' do
      expect(calendar.iterations.last.flight_dates.keys.last).to eq(Date.parse('2014-04-06'))
    end
  end
end