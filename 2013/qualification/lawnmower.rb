#!/usr/bin/env ruby
# lawnmower.rb

def columns(matrix)
  (0..(matrix[0].length - 1)).map { |i| matrix.map{ |r| r[i] } }
end

def row_possible?(row)
  row.count { |c| c == row[0] } == row.length
end

def run_matrix(matrix, f)
  @case_no += 1
  if matrix.all?{ |r| row_possible?(r) } || columns(matrix).all?{ |r| row_possible?(r) }
    f.puts "Case ##{@case_no}: YES"
  else
    impossible = false
    begin
      (0..(matrix.length - 1)).each do |i|
        (0..(matrix[0].length - 1)).each do |j|
          el = matrix[i][j]
          if matrix[i].max != el && columns(matrix)[j].max != el
            raise
          end
        end
      end
      impossible = false
    rescue Exception => e
      impossible = true
    end
    if impossible
      f.puts "Case ##{@case_no}: NO"
    else
      f.puts "Case ##{@case_no}: YES"
    end
  end
end

count = 0
@case_no = 0
@n = 0
matrix = []
outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
ARGF.each do |line|
  count += 1
  next if count == 1
  if @n == 0
    @n = line.strip.split(' ').map(&:to_i).first
    run_matrix(matrix, f) if matrix.length > 0
    matrix = []
  else
    matrix << line.strip.split(' ').map(&:to_i)
    @n -= 1
  end
end
run_matrix(matrix, f) if matrix.length > 0
f.close
