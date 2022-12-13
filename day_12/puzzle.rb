input = File.readlines('input.txt')

class Cell
  attr_accessor :value, :dist

  def initialize(value)
    @value = value
    @dist = (1 << 32)
  end
end

def get_adjacent(i, j, grid)
  adj_moves = []
  adj_moves << [grid[i - 1][j], i - 1, j] if i.positive?
  adj_moves << [grid[i + 1][j], i + 1, j] if i < (grid.length - 1)
  adj_moves << [grid[i][j - 1], i, j - 1] if j.positive?
  adj_moves << [grid[i][j + 1], i, j + 1] if j < (grid.first.length - 1)

  adj_moves
end

def get_valid_moves_p1(i, j, curr_val, grid)
  adj_moves = get_adjacent(i, j, grid)

  adj_moves.map do |target|
    target_ord = target[0].value.ord
    curr_val_ord = curr_val.value.ord

    target_ord = 'z'.ord if target[0].value == 'E'

    curr_val_ord = 'a'.ord if curr_val.value == 'S'

    target if curr_val_ord >= target_ord || target_ord - curr_val_ord == 1
  end.compact
end

def get_valid_moves_p2(i, j, curr_val, grid)
  adj_moves = get_adjacent(i, j, grid)

  adj_moves.map do |target|
    target_ord = target[0].value.ord
    curr_val_ord = curr_val.value.ord

    target_ord = 'a'.ord if target[0].value == 'S'

    curr_val_ord = 'z'.ord if curr_val.value == 'E'

    target if curr_val_ord <= target_ord || curr_val_ord - target_ord == 1
  end.compact
end

def build_grid(input)
  input.map do |line|
    line.strip.each_char.map { |char| Cell.new(char) }
  end
end

def find_cell(grid, char)
  grid.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      return [i, j] if cell.value == char
    end
  end
end

def shortest_path(grid, start_i, start_j)
  path_stack = [[grid[start_i][start_j], start_i, start_j]]
  grid[start_i][start_j].dist = 0

  until path_stack.empty?
    cell, i, j = path_stack.pop

    # get_valid_moves_p1(i, j, cell, grid).each do |move_set| # Part 1
    get_valid_moves_p2(i, j, cell, grid).each do |move_set| # Part 2
      next if move_set[0].dist <= cell.dist + 1

      move_set[0].dist = cell.dist + 1
      path_stack << move_set
    end
  end
end

grid = build_grid(input)

# Part 1
# i, j = find_cell(grid, 'S')
# shortest_path(grid, i, j)
# grid.each do |row|
#   row.each do |cell|
#     puts cell.dist if cell.value == 'E'
#   end
# end

# Part 2
i, j = find_cell(grid, 'E')
shortest_path(grid, i, j)

distances = []

grid.each do |row|
  row.each do |cell|
    distances << cell.dist if cell.value == 'a'
  end
end

puts distances.min
