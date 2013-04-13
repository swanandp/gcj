#!/usr/bin/env ruby
# tic_tac_toe_tomek.rb

def x_won?(line)
  !!line.match(/(T|X){4}/i)
end

def o_won?(line)
  !!line.match(/(T|O){4}/i)
end

def all_lines(board)
  lines = []
  lines += board
  lines += (0..3).map { |i| board.map{ |r| r[i] }.join }
  lines << [board[0][0], board[1][1], board[2][2], board[3][3]].join
  lines << [board[0][3], board[1][2], board[2][1], board[3][0]].join
  lines
end

def run_board(board, f)
  @case_no += 1
  dots = 0
  result = 0
  all_lines(board).each do |b_row|
    if x_won?(b_row)
      f.puts "Case ##{@case_no}: X won"
      result = 1
      break
    elsif o_won?(b_row)
      f.puts "Case ##{@case_no}: O won"
      result = 1
      break
    end
    dots += 1 if b_row.include?('.')
  end
  if result == 0
    if dots == 0
      f.puts "Case ##{@case_no}: Draw"
    else
      f.puts "Case ##{@case_no}: Game has not completed"
    end
  end
end

count = 0
@case_no = 0
current_count = nil
board = []
outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
ARGF.each do |line|
  count += 1
  next if count == 1
  row = line.strip
  if row.length <= 1
    run_board(board, f)
    board = []
    next
  else
    board << row
  end
end
# run_board(board, f)
f.close
