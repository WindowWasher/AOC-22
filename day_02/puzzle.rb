WINNING_MOVES = { A: :Y,
                  B: :Z,
                  C: :X }.freeze

DRAW_MOVES = { A: :X, B: :Y, C: :Z }.freeze

LOSS_MOVES = { A: :Z, B: :X, C: :Y }.freeze

MOVE_VALUE = { X: 1, Y: 2, Z: 3 }.freeze

OUTCOME_VALUE = { LOSS: 0, DRAW: 3, WIN: 6 }.freeze

def move_value(op, player)
  total_score = MOVE_VALUE[player]
  total_score += OUTCOME_VALUE[:DRAW] if DRAW_MOVES[op] == player
  total_score += OUTCOME_VALUE[:WIN] if player == WINNING_MOVES[op]

  total_score
end

def moves(line)
  moves = line.split
  op = moves[0].strip.to_sym
  player = moves[1].strip.to_sym

  return op, player
end

lines = File.readlines('input.txt')

# PART 1
total_score = 0

lines.map do |line|
  op, player = moves(line)
  total_score += move_value(op, player)
end

puts total_score

# PART 2
total_score = 0

lines.map do |line|
  op, player = moves(line)

  case player
  when :X
    move = LOSS_MOVES[op]
  when :Y
    move = DRAW_MOVES[op]
  when :Z
    move = WINNING_MOVES[op]
  end

  total_score += move_value(op, move)
end

puts total_score
