#!/usr/bin/env ruby
# d
# https://code.google.com/codejam/contest/2434486/dashboard 
$:.unshift File.dirname(__FILE__)

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |c|
  # solve here
  
  result = 0
  f.puts "Case ##{c + 1}: #{result}"
end
f.close
