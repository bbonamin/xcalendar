require 'spec_helper'

module XCalendar
  describe Week do
    let!(:cover_date) { '2013-08-28' }
    let(:week) { Week.new(covering: cover_date) }

    it 'begins on a monday within the same week' do
      expect(week.beginning.monday?).to eq(true)
      expect(1..7).to include((week.beginning - Date.parse(cover_date)).to_i.abs) 
    end

    it 'ends on a sunday within the same week' do
      expect(week.ending.sunday?).to eq(true)
      expect(1..7).to include((week.ending - Date.parse(cover_date)).to_i.abs) 
    end

    it 'accepts a Date object as parameter' do
      expect { Week.new(covering: Date.today) }.to_not raise_error
    end

    it 'accepts a string as parameter' do
      expect { Week.new(covering: cover_date) }.to_not raise_error
    end

    describe '#includes?' do
      it 'returns true if a date is included within the beginning and end' do
        expect(week.includes? cover_date).to eq(true)
      end
      it 'returns false if a date is not included within the beginning and ending' do
        expect(week.includes? '2013-01-01').to eq(false)
      end
    end

    it 'returns saturday and sunday as flyable_days' do
      week.flyable_days.each do |day|
        weekend_day = day.saturday? || day.sunday?
        expect(weekend_day).to be_true
      end
    end

    it 'returns any national holiday in flyable_days' do
      stub_const("XCalendar::HOLIDAYS", ['2013-08-28'])
      holiday = Date.parse(XCalendar::HOLIDAYS.first)
      expect(week.flyable_days).to include(holiday)
    end
  end
end