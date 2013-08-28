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
    it 'does not repeat a pilot in the same iteration' do
      pilots_in_first_iteration = calendar.iterations.first.flight_dates.values.flatten
      pilots_in_last_iteration = calendar.iterations.last.flight_dates.values.flatten
      expect(pilots_in_first_iteration.count).to eq(pilots_in_first_iteration.uniq.count)
      expect(pilots_in_last_iteration.count).to eq(pilots_in_last_iteration.uniq.count)
    end
    it 'does not repeat a pilot ending an iteration and starting the next one' do
      calendar.iterations.each_with_index do |iteration, index|
        if not(iteration == calendar.iterations.last)
          next_iteration_first_pilots = calendar.iterations[index+1].flight_dates.values.first
          expect(iteration.last_pilots & next_iteration_first_pilots).to be_empty
        end
      end
    end

    it 'contains all pilots in each iteration except the last' do
      def except_last(array)
        array.reverse.drop(1).reverse
      end
      pilots_per_iteration = calendar.iterations.map(&:flight_dates).flatten.map(&:values).map(&:flatten)
      except_last(pilots_per_iteration).each do |pilots|
        expect(pilots.uniq.count).to eq(8)
      end
    end

    it 'starts on the start date' do
      expect(calendar.iterations.first.flight_dates.keys.first).to eq(Date.parse('2013-09-07'))
    end
    it 'ends on the end date' do
      expect(calendar.iterations.last.flight_dates.keys.last).to eq(Date.parse('2014-04-06'))
    end

    it 'exports the output to CSV' do
      expect(calendar.export_to_csv).to_not raise_error
    end
  end
end