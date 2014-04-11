#!/usr/bin/env ruby
# problem a-large

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
consonents_regex = "[bcdfghjklmnpqrstvwxyz]"
cases.times do |c|
  word, n = infile.readline.strip.split(' ')
  n = n.to_i
  (n..(word.length)).each do |sub|
    
  end
  result = split_word(word, n).count { |a| a.match Regexp.new("[bcdfghjklmnpqrstvwxyz]{#{n},}") }
  f.puts "Case ##{c + 1}: #{result}"
end
f.close
