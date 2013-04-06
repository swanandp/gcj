def boy?(gender)
  gender.match /b/i
end

def girl?(gender)
  gender.match /g/i
end

def str_to_inches(str)
  ft, inc = str.split(/'|"/).map(&:to_i)
  ft * 12 + inc
end

def inches_to_str(inches)
  inches = inches.round
  ft = inches / 12
  inc = inches % 12
  %{#{ft}'#{inc}"}
end

# baby-height
count = -1
f = File.open('baby-height.txt', 'wb')
ARGF.each do |line|
  count += 1
  next if count < 1
  gender, mother, father = line.split(' ')
  additive = boy?(gender) ? 5 : -5
  mid = (str_to_inches(mother) + str_to_inches(father) + additive) / 2.0
  low = (mid - 4).ceil
  high = (mid + 4).floor
  f.puts "Case ##{count}: #{inches_to_str(low)} to #{inches_to_str(high)}"
end
f.close
