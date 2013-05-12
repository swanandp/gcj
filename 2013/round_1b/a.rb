#!/usr/bin/env ruby
# a
# https://code.google.com/codejam/contest/2434486/dashboard 
$:.unshift File.dirname(__FILE__)

require 'shortest_path'

def solvable?(arr, start)
  solvable = true
  sum = start
  (arr + [0]).each do |a|
    solvable = sum > a
    break unless solvable
    sum += a
  end
  solvable
end

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |c|
  # solve here
  a, n = infile.readline.strip.split(' ').map(&:to_i)
  motes = infile.readline.strip.split(' ').map(&:to_i).sort

  if solvable?(motes, a)
    f.puts "Case ##{c + 1}: 0"
  elsif a == 1
    f.puts "Case ##{c + 1}: #{n}"
  else
    sum = a
    operations = 0
    best_answer = n
    motes.each_with_index do |mote, i|
      if sum > mote
        sum += mote
        next
      end
      
      best_answer = [n, operations + motes.length - i].min
      
      while sum <= mote
        sum += sum - 1
        operations += 1
      end
      
      sum += mote
      
    end
    f.puts "Case ##{c + 1}: #{[operations, best_answer].min}"
  end
end
f.close
