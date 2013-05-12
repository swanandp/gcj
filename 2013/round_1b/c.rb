#!/usr/bin/env ruby
# c
# https://code.google.com/codejam/contest/2434486/dashboard 
$:.unshift File.dirname(__FILE__)


words = File.read('/Users/swanand/projects/open-source/gcj/2013/round_1b/garbled_email_dictionary.txt').split("\n")

@words_by_lengths = words.inject({}) do |acc, word|
  acc[word.length] ||= []
  acc[word.length] << word
  acc
end

puts @words_by_lengths.keys

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |c|
  s = infile.readline.strip
  jumbled = []
  s.length.times do |i|
    jumbled << [s[0..i], s[(i + 1)..-1]]
  end
  possible_alternatives = 0
  jumbled.each do |combo|
    combo.each do |w|
      next if w.length == 0
      next if @words_by_lengths[w.length].include?(w)
      @words_by_lengths[w.length].minimum do |word|
        distance(word, w)
      end
    end
  end
  result = 0
  f.puts "Case ##{c + 1}: #{result}"
end
f.close
