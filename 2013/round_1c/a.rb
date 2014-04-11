#!/usr/bin/env ruby
# problem a

def extract_numbers(infile)
  infile.readline.strip.split(' ').map(&:to_i)
end

def split_word s, n
  indices = (0..(s.length - 1)).to_a
  indices.product(indices).reject{|i,j| i > j }.reject {|i| i[1] - i[0] + 1 < n }.map{|i,j| s[i..j]}
end

def valid_name?(name, n)
  name =~ Regexp.new("[bcdfghjklmnpqrstvvwxyz]{#{n}}", 7)
end

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |c|
  result = 0
  word, n = infile.readline.strip.split(' ')
  n = n.to_i
  l = word.length
  (n..l).each do |i|
    (l - i + 1).times do |j|
      name = word[j..(j + i - 1)]
      if valid_name?(name, n)
        result += 1
      end
    end
  end
  
  f.puts "Case ##{c + 1}: #{result}"
end
f.close
