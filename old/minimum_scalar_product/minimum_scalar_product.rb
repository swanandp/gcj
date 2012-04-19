require 'active_support/all'

class MinimumScalarProduct
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
      lines.shift
      # TODO - ALWAYS adjust here
      lines.in_groups_of(3) do |group|
        num_elem, vector1, vector2 = group
        self.inputs << Input.new(vector1.split(" ").map{|i| i.to_i}, vector2.split(" ").map{|i| i.to_i}, self.inputs.length + 1)
      end
    rescue Errno::ENOENT => e
      outputter.puts "Oops! Wrong file!"
    end
  end
end

class Input < Struct.new(:vector1, :vector2, :case_number)
  attr_accessor :product
  def solve
    self.product = vector_product(vector1.sort, vector2.sort.reverse)
  end
  
  def output
    "Case ##{case_number}: #{self.product}"
  end
  
  def vector_product(v1, v2)
    i = -1
    v1.inject(0) do |sum, x|
      i += 1
      sum += x * v2[i]
    end
  end
end
