input = File.readlines('input.txt')

class Item
  attr_accessor :worry_level

  def initialize(item)
    @worry_level = item
  end
end

class Monkey
  attr_accessor :items, :operation, :test, :item_inspection_count

  def initialize(items, operation, test)
    @items = items
    @operation = operation
    @test = test
    @item_inspection_count = 0
  end

  def decrease_worry_level_part1(amount)
    worry_level = @items.first.worry_level
    @items.first.worry_level = (worry_level / amount).floor
  end

  def decrease_worry_level_part2(mod_factor)
    @items.first.worry_level %= mod_factor
  end

  def inspect
    @item_inspection_count += 1

    rhs = operation.split.last.strip
    if rhs.include?('old')
      @items.first.worry_level *= @items.first.worry_level
    elsif operation.include?('old +')
      @items.first.worry_level += Integer(rhs)
    else
      @items.first.worry_level *= Integer(rhs)
    end
  end

  def perform_test
    val = Integer(test[0])

    if (@items.first.worry_level % val).zero?
      test[1][true]
    else
      test[1][false]
    end
  end

  def describe
    "#{@item_inspect_count} #{@items}"
  end
end

mod_factor = 1
input.each { |line| mod_factor *= Integer(line.split.last.strip) if line.include?('Test:') }

def build_monkeys(input)
  monkeys_raw = []
  monkey_raw = []

  input.each do |line|
    if line.strip == ''
      monkeys_raw << monkey_raw
      monkey_raw = []
      next
    end

    monkey_raw << line.strip
  end
  monkeys_raw << monkey_raw

  monkeys = []
  monkeys_raw.each do |mon|
    monk_items = mon[1].split('Starting items: ').last.strip.split(', ').map { |item| Item.new(Integer(item)) }
    operation = mon[2].split('Operation: ').last.strip
    test = [Integer(mon[3].split.last.strip),
            { true => Integer(mon[4].split.last.strip), false => Integer(mon[5].split.last.strip) }]
    monkeys << Monkey.new(monk_items, operation, test)
  end
  monkeys
end

monkeys = build_monkeys(input)

rounds = 10_000 # Part 2
# rounds = 20 # Part 1

rounds.times do
  monkeys.each do |monkey|
    until monkey.items.empty?
      monkey.inspect
      # monkey.decrease_worry_level_part1(3)
      monkey.decrease_worry_level_part2(mod_factor)
      throw_to = monkey.perform_test
      monkeys[throw_to].items << monkey.items.shift
    end
  end
end

puts monkeys.map(&:item_inspection_count).max(2).inject(1) { |res, item| res * item }
