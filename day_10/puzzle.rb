input = File.readlines('input.txt')

# Cycle Count
NOOP = 1
ADDX = 2

curr_cycle = 1
x_reg = 1

strength_check_at_cycle = 20

singal_strengths = []

addx_cycle_count = 1

pixels = []
screen = []
width = 40

input.each do |line|
  cycle_count = NOOP if line.include?('noop')
  cycle_count = ADDX if line.include?('addx')

  cycle_count.times do
    pixels << if [x_reg - 1, x_reg, x_reg + 1].include?((curr_cycle - 1) % width)
                '#'
              else
                '.'
              end

    if pixels.length == width
      screen << pixels
      pixels = []
    end

    if curr_cycle == strength_check_at_cycle
      strength_check_at_cycle += 40
      singal_strengths << x_reg * curr_cycle
    end

    if line.include?('addx')
      x_reg += Integer(line.strip.split[1]) if addx_cycle_count == 2
      addx_cycle_count += 1
    end

    curr_cycle += 1
    addx_cycle_count = 1 if addx_cycle_count == 3
  end
end

puts singal_strengths.sum

screen.each do |line|
  print line.join
  puts
end
