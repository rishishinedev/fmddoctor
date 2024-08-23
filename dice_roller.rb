class Die
  def initialize(sides)
    @sides = sides
  end

  def roll
    rand(@sides) + 1
  end
end

class RollResult
  attr_reader :description, :die_values, :total

  def initialize(description, die_values)
    @description = description
    @die_values = die_values
    @total = die_values.sum
  end
end

class DiceRoller
  def roll(dice_config)
    die_values = dice_config.map do |count, sides|
      count.times.map { Die.new(sides).roll }
    end.flatten

    description = dice_config.map do |count, sides|
      "#{count} #{sides}-sided die#{count > 1 ? 's' : ''}"
    end.join(' and ')

    RollResult.new(description, die_values)
  end

  def self.cli
    puts 'Enter the number of dice to roll, followed by the number of sides for each die, separated by spaces.'
    puts 'For example, "1 6 2 8" would roll one 6-sided die and two 8-sided dice.'

    input = gets.chomp
    numbers = input.split.map(&:to_i)
    dice_config = numbers.each_slice(2).to_a

    roller = DiceRoller.new
    result = roller.roll(dice_config)

    puts "Rolled #{result.description}:"
    result.die_values.each_with_index do |value, i|
      puts "  Die #{i+1}: #{value}"
    end
    puts "  Total: #{result.total}"
  end
end

DiceRoller.cli