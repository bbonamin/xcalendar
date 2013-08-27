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
      expect(week.end.sunday?).to eq(true)
      expect(1..7).to include((week.end - Date.parse(cover_date)).to_i.abs) 
    end

    it 'accepts a Date object as parameter' do
      expect { Week.new(covering: Date.today) }.to_not raise_error
    end
  end
end