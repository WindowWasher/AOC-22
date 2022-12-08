input = File.readlines('input.txt')

MAX_SIZE = 100_000

file_system = Hash.new(0)
dir_stack = []

input.map do |line|
  if line.include?('$ cd ') && line.strip != '$ cd ..'
    dir_stack << line.split('$ cd ')[1].strip
  elsif line.strip == '$ cd ..'
    dir_size = file_system[dir_stack.join(',')]
    dir_stack.pop
    file_system[dir_stack.join(',')] += dir_size
  elsif line.strip != '$ ls'
    file_system[dir_stack.join(',')] += Integer(line.split.first) unless line.include?('dir ')
  end
end

# Unwind the rest of the stack
until dir_stack.empty?
  dir_size = file_system[dir_stack.join(',')]
  dir_stack.pop
  file_system[dir_stack.join(',')] += dir_size
end

# Part 1
size = 0

file_system.sort.to_h.each do |_key, value|
  next if value > MAX_SIZE

  size += value
end

puts size

# Part 2
FILE_SYS_SIZE = 70_000_000
UPDATE_SIZE = 30_000_000

FREE_SPACE_AVAILABLE = FILE_SYS_SIZE - file_system['/']
FREE_SPACE_NEEDED = UPDATE_SIZE - FREE_SPACE_AVAILABLE

size = FILE_SYS_SIZE

file_system.sort.to_h.each do |_key, value|
  size = value if value >= FREE_SPACE_NEEDED && value < size
end

puts size
