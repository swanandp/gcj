require 'active_support/all'
class RecycledNumbers
  attr_accessor :outputter, :inputs, :input_file, :output_file
  
  def initialize(input_file, output_file)
    self.input_file = input_file
    self.output_file = output_file
    self.inputs = []
    @outputter ||= Kernel
  end

  def solve
    parse
    self.inputs.each {|i| i.solve }
    File.open(self.output_file, 'w+') do |f|
      self.outputter = f
      self.inputs.each do |input|
        outputter.puts input.output
      end
    end
  end
  
  def parse
    begin
      input = File.read(self.input_file)
      lines = input.split("\n")
      # TODO - ALWAYS adjust here
      lines.shift
      lines.each do |line|
        a, b = line.split(' ').map(&:to_i)
        inputs << Input.new(a, b, self.inputs.length + 1)
      end
    rescue Errno::ENOENT => e
      outputter.puts "Oops! Wrong file!"
    end
  end
end

class Input < Struct.new(:num1, :num2, :case_number)
  attr_accessor :result, :number_groups, :selected_numbers
  def solve
    self.number_groups = []
    self.selected_numbers = []
    (num1..num2).each do |num|
      next if selected_numbers.include?(num)
      num_group = get_number_group(num.to_s)
      self.number_groups << num_group if num_group.length > 1
      self.selected_numbers.concat(num_group).uniq!
    end
    self.result = self.number_groups.uniq.inject(0) do |sum, group|
      sum += combination(group.length, 2)
    end
  end
  
  def combination(n, r)
    numerator = r.times.inject(1){|_d, _r| _d *= (n - _r) }
    denominator = factorial(r)
    numerator / denominator
  end
  
  def factorial(r)
    r.times.inject(1){|f, i| f *= i + 1}
  end
  
  def get_number_group(s)
    m = "#{s}#{s[0..-2]}"
    s.length.times.map { |i| 
      num = m[i, s.length]
      num if m[i] != '0' && num.to_i <= self.num2 && num.to_i >= self.num1
    }.compact.uniq.sort
  end
  
  def output
    "Case ##{case_number}: #{self.result}"
  end
end
