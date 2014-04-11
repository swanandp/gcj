#!/usr/bin/env ruby
# problem b

outfile = ARGV.first.gsub('.in', '.out')
f = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |c|
  # targets
  tx, ty = infile.readline.strip.split(' ').map(&:to_i)
  x, y = 0, 0
  steps = ''
  
  if tx > 0
    x_dir = 'E'
    x_step = 'WE'
    x_inc = 1
  else
    x_dir = 'W'
    x_step = 'EW'
    x_inc = -1
  end
  
  if ty > 0
    y_dir = 'N'
    y_step = 'SN'
    y_inc = 1
  else
    y_dir = 'S'
    y_step = 'NS'
    y_inc = -1
  end
  
  if tx != 0
    steps << x_dir
    x += x_inc
  elsif ty != 0
    steps << y_dir
    y += y_inc
  end
  
  steps << x_step * (tx - x).abs
  steps << y_step * (ty - y).abs

  f.puts "Case ##{c + 1}: #{steps}"
end
f.close
