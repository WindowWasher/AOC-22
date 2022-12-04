require 'set'
input = File.readlines('input.txt')

# Left contains right
# Right contains Left
# Left overlaps right
# Right overlaps left
# No overlap

def get_seq(range_val)
  start, stop = range_val.split('-')
  (Integer(start)..Integer(stop)).to_a
end

def overlap?(line)
  pair = line.split(',')
  seq1 = get_seq(pair[0])
  seq2 = get_seq(pair[1])

  total_len = seq1.length + seq2.length
  total_seq = Set.new(seq1 + seq2)

  return 'NO_OVERLAP' if total_seq.length == total_len
  return 'CONTAINS' if total_seq.length == [seq1.length, seq2.length].max

  'OVERLAP'
end

# Part 1
puts input.map { |line| 1 if overlap?(line) == 'CONTAINS' }.compact.sum

# Part 2
puts input.map { |line| 1 unless overlap?(line) == 'NO_OVERLAP' }.compact.sum
