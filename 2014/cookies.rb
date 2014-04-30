#!/usr/bin/env ruby
# cookie clicker

outfile = ARGV.first.gsub('.in', '.out')
file = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |i|
  c, f, x = infile.readline.strip.split(' ').map(&:to_f)
  if x <= c
    answer = x / 2.0
    file.puts "Case ##{i + 1}: #{answer}"
  else
    time    = 0
    farms   = 0
    loop do
      current_speed = 2.0 + f * farms
      next_speed = 2.0 + f * ( farms + 1 )
      time_with_purchase    = c / current_speed
      time_without_purchase = x / current_speed
      if time_without_purchase <= ( time_with_purchase + x / next_speed )
        answer = time + time_without_purchase
        break
      else
        farms += 1
        time += time_with_purchase
      end
    end

    file.puts "Case ##{i + 1}: #{answer.round(7)}"
  end
end
file.close
