#!/usr/bin/env ruby
# minesweeper master

outfile = ARGV.first.gsub('.in', '.out')
file    = File.open(outfile, 'wb')
infile  = File.open(ARGV.first)
cases   = infile.readline.strip.to_i
cases.times do |i|
  r, c, m = infile.readline.strip.split(' ').map(&:to_i)
  min_neighbours =  if r == 1 || c == 1
                      if r == 1 && c == 1
                        0
                      else
                        1
                      end
                    else
                      3
                    end
  possible = m <= r * c - min_neighbours
  
  
  
  file.puts "Case ##{i + 1}:"
  file.puts string_answer
end
file.close
