input = File.readlines('input.txt').map { |line| line.strip.split(' -> ') }

def fill_horizontal(grid, y, x_path)
  x_path[0].upto(x_path[1]) do |x|
    grid[y][x] = '#'
  end
end

def fill_vertical(grid, x, y_path)
  y_path[0].upto(y_path[1]) do |y|
    grid[y][x] = '#'
  end
end

def fill(grid, s_path, e_path)
  if s_path[0] == e_path[0]
    fill_vertical(grid, s_path[0], [s_path[1], e_path[1]].sort)
  else
    fill_horizontal(grid, s_path[1], [s_path[0], e_path[0]].sort)
  end
end

def build_grid(input, y, x)
  grid = Array.new(y) { Array.new(x, '*') }
  grid[0][500] = 'x' # Sand start

  input.each do |path|
    1.upto(path.length - 1) do |i|
      s_path = path[i - 1].split(',').map { |digit| Integer(digit) }
      e_path = path[i].split(',').map { |digit| Integer(digit) }
      fill(grid, s_path, e_path)
    end
  end
  grid
end

def x_bounds(grid)
  left_most = 1 << 32
  right_most = 0

  grid.each do |line|
    left_idx = line.index('0')
    next if left_idx.nil?

    right_idx = line.rindex('0')

    left_most = left_idx if left_idx < left_most
    right_most = right_idx if right_idx > right_most
  end

  [left_most, right_most]
end

def y_bounds(grid)
  top = nil
  bottom = 0

  grid.each_with_index do |line, idx|
    next if line.all?('*')

    bottom = idx
    top = idx if top.nil?
  end

  [top, bottom]
end

def grid_to_file(grid)
  left_most, right_most = x_bounds(grid)
  top_most, bottom_most = y_bounds(grid)

  grid.each_with_index do |line, idx|
    next unless idx >= top_most && idx <= bottom_most

    File.write('screen.txt', line.slice((left_most - 1)..right_most).join, mode: 'a')
    File.write('screen.txt', "\n", mode: 'a')
  end
end

def simulate(grid, y_bottom)
  stable_sand_count = 0
  loop do
    sand_stable = false

    # Start location of the sand
    y = 0
    x = 500

    until sand_stable
      return stable_sand_count if y == y_bottom

      unless ['#', '0'].include?(grid[y + 1][x])
        y += 1
        next
      end

      unless ['#', '0'].include?(grid[y + 1][x - 1])
        y += 1
        x -= 1
        next
      end

      unless ['#', '0'].include?(grid[y + 1][x + 1])
        y += 1
        x += 1
        next
      end

      sand_stable = true
      stable_sand_count += 1
      return stable_sand_count if grid[y][x] == 'x'

      grid[y][x] = '0'
    end
  end
end

grid = build_grid(input, 200, 5000)

_, y_bottom = y_bounds(grid)

# Part 1
# puts simulate(grid, y_bottom)

# Part 2
fill_horizontal(grid, y_bottom + 2, [1, 25_400])
puts simulate(grid, y_bottom + 2)


# grid_to_file(grid)
