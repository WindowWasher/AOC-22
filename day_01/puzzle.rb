cal_count = Hash.new(0)
inc = 0

File.open('input.txt', 'r') do |f|
  f.each_line do |line|
    if Integer(line, exception: false)
      cal_count[inc] += Integer(line)
    else
      inc += 1
    end
  end
end

# Part 1
puts cal_count.values.max

# Part 2
puts cal_count.values.sort.slice(-3, 3).inject(0) { |result, val| result + val }
