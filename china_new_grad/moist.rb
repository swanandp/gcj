#!/usr/bin/env ruby
# moist

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |i|
  n = infile.readline.strip.to_i
  cards = n.times.map { infile.readline.strip }
  prev = cards.shift
  count = 0
  
  cards.each { |current|
    if prev > current
      count += 1
    else
      prev = current
    end
  }
  
  f.puts "Case ##{i + 1}: #{count}"
end
f.close
