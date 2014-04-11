#!/usr/bin/env ruby
# bullseye

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |i|
  r, t = infile.readline.strip.split(' ').map(&:to_i)
  result, low, high = 0, 1, t
  while low <= high
    mid = (low + high) / 2
    if (2 * r + 2 * mid - 1) * mid > t
      high = mid - 1
    else
      low, result = mid + 1, mid
    end
  end
  f.puts "Case ##{i + 1}: #{result}"
end
f.close
