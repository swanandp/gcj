#!/usr/bin/env ruby
# problem c

def extract_numbers(infile)
  infile.readline.strip.split(' ').map(&:to_i)
end

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |c|
  n = infile.readline.strip.to_i
  tribes = []
  n.times do
    tribes << 
  end
  
  f.puts "Case ##{c + 1}: #{}"
end
f.close
