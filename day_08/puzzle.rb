input = File.readlines('input.txt')

tree_grid = []

input.each do |line|
  tree_grid << line.strip.chars.map { |char| Integer(char) }
end

def trees_in_path(i, j, tree_grid)
  left = tree_grid[i].slice(0, j).reverse
  right = tree_grid[i].slice(j + 1, tree_grid.length)
  top = tree_grid.slice(0, i).map { |col| col[j] }.reverse
  bottom = tree_grid.slice(i + 1, tree_grid.length).map { |col| col[j] }

  [left, right, top, bottom]
end

# Part 1
visible_trees = 0

def can_see(i, j, tree_grid)
  return true if [0, tree_grid.length - 1].include?(i)
  return true if [0, tree_grid.length - 1].include?(j)

  tree = tree_grid[i][j]

  left, right, top, bottom = trees_in_path(i, j, tree_grid)

  return true if tree > left.max
  return true if tree > right.max
  return true if tree > top.max
  return true if tree > bottom.max

  false
end

tree_grid.each_index do |i|
  tree_grid[i].each_index do |j|
    visible_trees += 1 if can_see(i, j, tree_grid)
  end
end

puts visible_trees

# Part 2
def view_score_of_direction(tree, direction)
  tree_score = 0
  direction.each do |c_tree|
    tree_score += 1
    break if tree <= c_tree
  end

  tree_score
end

def view_score(i, j, tree_grid)
  tree = tree_grid[i][j]

  left, right, top, bottom = trees_in_path(i, j, tree_grid)

  score = view_score_of_direction(tree, top)
  score *= view_score_of_direction(tree, bottom)
  score *= view_score_of_direction(tree, left)
  score *= view_score_of_direction(tree, right)

  score
end

scores = []

tree_grid.each_index do |i|
  tree_grid[i].each_index do |j|
    scores << view_score(i, j, tree_grid)
  end
end

puts scores.max
