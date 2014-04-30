#!/usr/bin/env ruby
# deceitful war

def play_deceit(naomi, ken, current_score)
  naomi_next = naomi.find { |b| b > ken.min }
  if naomi_next
    current_score += 1
    naomi.delete naomi_next
    ken.delete ken.min
    play_deceit(naomi, ken, current_score)
  else
    return current_score
  end
end

def play_fair(naomi, ken)
  naomi_next = naomi.min
  ken_next = ken.find { |b| b > naomi_next }
  if ken_next
    ken.delete ken_next
    naomi.delete naomi_next
    play_fair(naomi, ken)
  else
    ken.length
  end
end

outfile = ARGV.first.gsub('.in', '.out')
file = File.open(outfile, 'wb')
infile = File.open(ARGV.first)
cases = infile.readline.strip.to_i
cases.times do |i|
  n          = infile.readline.strip.to_i
  naomi      = infile.readline.strip.split(' ').map(&:to_f).sort
  ken        = infile.readline.strip.split(' ').map(&:to_f).sort
  naomi_fair = naomi.clone
  ken_fair   = ken.clone
  file.puts "Case ##{i + 1}: #{play_deceit(naomi, ken, 0)} #{play_fair(naomi_fair, ken_fair)}"
end
file.close
