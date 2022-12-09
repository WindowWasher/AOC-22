input = File.readlines('input.txt')

grid = Array.new(1000) { Array.new(1000, 0) }

s = 500 # Start

# Part 1
# pos = [[s, s], [s, s]]

# Part 2
pos = [[s, s], [s, s], [s, s], [s, s], [s, s], [s, s], [s, s], [s, s], [s, s],
       [s, s]]

grid[s][s] = 1 # Start pos is covered

def in_range(h_y, h_x, t_y, t_x)
  y_diff = (h_y - t_y).abs
  x_diff = (h_x - t_x).abs

  return true if [0, 1].include?(y_diff) && [0, 1].include?(x_diff)

  false
end

def move_tail(h_y, h_x, t_y, t_x)
  t_x += 1 if t_x < h_x
  t_x -= 1 if t_x > h_x
  t_y += 1 if t_y < h_y
  t_y -= 1 if t_y > h_y

  [t_y, t_x]
end

input.each do |line|
  dir, steps = line.strip.split

  Integer(steps).times do
    pos[0][1] -= 1 if dir == 'L'
    pos[0][1] += 1 if dir == 'R'
    pos[0][0] -= 1 if dir == 'U'
    pos[0][0] += 1 if dir == 'D'

    (pos.length - 1).times do |i|
      h_y, h_x = pos[i]
      t_y, t_x = pos[i + 1]

      next if in_range(h_y, h_x, t_y, t_x)

      t_y, t_x = move_tail(h_y, h_x, t_y, t_x)

      pos[i + 1][0] = t_y
      pos[i + 1][1] = t_x
      grid[t_y][t_x] = 1 if i == pos.length - 2
    end
  end
end

print grid.flatten.sum
