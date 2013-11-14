# ocean_view
# TODO Use longest common subsequence
count = 0
case_no = 1
current_count = nil
f = File.open('ocean_view.large.txt', 'wb')
ARGF.each do |line|
  count += 1
  next if count == 1 || count % 2 == 0
  heights = line.strip.split(' ').map(&:to_i)
  differences = []
  heights.each_with_index do |h, i|
    next if i == heights.length - 1
    differences << heights[i + 1] - h
  end
  destroyed = 0
  differences.each_with_index do |d, i|
    if d <= 0
      destroyed += 1
      differences[i + 1] += d if differences[i + 1]
    end
  end
  f.puts "Case ##{case_no}: #{destroyed}"
  case_no += 1
end
f.close
