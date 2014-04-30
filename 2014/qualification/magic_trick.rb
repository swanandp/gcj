#!/usr/bin/env ruby
# magic trick

def answer(common)
  return common.first if common.length == 1
  return 'Bad magician!' if common.length > 1
  return 'Volunteer cheated!' if common.length == 0
end

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |i|
  answer1 = infile.readline.strip.to_i
  arrangement1 = 4.times.map { infile.readline.strip.split(' ').map(&:to_i) }
  answer2 = infile.readline.strip.to_i
  arrangement2 = 4.times.map { infile.readline.strip.split(' ').map(&:to_i) }
  
  row1 = arrangement1[answer1 - 1]
  row2 = arrangement2[answer2 - 1]
  
  f.puts "Case ##{i + 1}: #{answer(row1 & row2)}"
end
f.close
