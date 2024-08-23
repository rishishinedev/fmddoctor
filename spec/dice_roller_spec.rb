# spec/dice_roller_spec.rb
require 'spec_helper'
require './dice_roller'

describe DiceRoller do
  let(:roller) { DiceRoller.new }

  describe '#roll' do
    it 'returns a RollResult object' do
      expect(roller.roll([[1, 6]])).to be_a(RollResult)
    end

    it 'rolls the correct number of dice' do
      result = roller.roll([[2, 6]])
      expect(result.die_values.size).to eq(2)
    end

    it 'rolls dice with the correct number of sides' do
      result = roller.roll([[1, 8]])
      expect(result.die_values.first).to be_between(1, 8)
    end

    it 'calculates the total correctly' do
      result = roller.roll([[2, 6]])
      expect(result.total).to eq(result.die_values.sum)
    end
  end

  describe '#cli' do
    it 'displays the result correctly' do
      allow(STDIN).to receive(:gets) { "1 6 2 8\n" }
      expect { DiceRoller.cli }.to output(/  Total: \d+/).to_stdout
    end
  end
end