require 'spec_helper'

module XCalendar
  describe Iteration do
    it 'raises an argument error if no start date is passed' do
      expect{Iteration.new}.to raise_error
    end
  end
end