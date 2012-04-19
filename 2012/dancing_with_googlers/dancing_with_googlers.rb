class DancingWithGooglers
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
        n, s, p, *numbers = line.split(' ').map(&:to_i)
        self.inputs << Input.new(s, p, numbers, self.inputs.length + 1)
      end
    rescue Errno::ENOENT => e
      outputter.puts "Oops! Wrong file!"
    end
  end
end

class Input < Struct.new(:s, :p, :numbers, :case_number)
  attr_accessor :result, :selected_numbers, :dup_numbers
  def solve
    self.selected_numbers = []
    self.selected_numbers.concat(self.numbers.select {|num| num >= higher_threshold })
    ambiguous_numbers = self.numbers.select do |num|
      num >= lower_threshold && num < higher_threshold && num >= p
    end
    puts ambiguous_numbers.inspect
    self.result = self.selected_numbers.length + [ambiguous_numbers.length, s].min
  end
  
  def lower_threshold
    @lower_threshold ||= [(3 * p - 4), 0].max
  end
  
  def higher_threshold
    @higher_threshold ||= [(3 * p - 2), 0].max
  end
  
  def no_surprise_limit
    # Any sum above 28 cannot be a surprise
    28 # Based on the give conditions
  end
  
  def minimum_surprise_limit
    # Any sum below 2 cannot be a surprise
    2 # Based on the give conditions
  end
  
  def output
    "Case ##{case_number}: #{self.result}"
  end
end
