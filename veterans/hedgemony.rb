# hedgemony
count = 0
case_no = 1
current_count = nil
f = File.open('hedgemony.large.txt', 'wb')
ARGF.each do |line|
  count += 1
  next if count == 1 || count % 2 == 0
  heights = line.strip.split(' ').map(&:to_i)
  puts heights.inspect
  heights.each_with_index do |h, i|
    next if i == 0 || i == heights.length - 1
    new_height = (heights[i - 1] + heights[i + 1]) / 2.0
    heights[i] = new_height if heights[i] > new_height
  end
  f.puts "Case ##{case_no}: #{heights[-2]}"
  case_no += 1
end
f.close
