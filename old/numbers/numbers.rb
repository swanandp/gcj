class Numbers
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
    self.inputs = []
    begin
      input = File.read(self.input_file)
      lines = input.split("\n")
      # TODO - ALWAYS adjust from here
      lines.shift  # Number of testcases
      lines.each do |line|
        self.inputs << Input.new(line.to_i, self.inputs.length + 1)
      end
    rescue Errno::ENOENT => e
      outputter.puts "Oops! Wrong file!"
    end
  end
end


class Input < Struct.new(:number, :case_number)
  attr_accessor :result
  def solve
    self.result = (((3 + Math.sqrt(5)) ** number) % 1000).floor
  end
  
  def output
    "Case ##{case_number}: #{self.result.to_s.rjust(3, '0')}"
  end
end
