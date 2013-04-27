#!/usr/bin/env ruby
# bullseye

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |i|
  r, t = infile.readline.strip.split(' ').map(&:to_i)
  
  f.puts "Case ##{i + 1}: #{[n.floor, 1].max}"
end
f.close
