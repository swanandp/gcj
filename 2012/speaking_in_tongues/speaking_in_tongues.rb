require 'active_support/all'
class SpeakingInTongues
  attr_accessor :outputter, :inputs, :input_file, :output_file, :dictionary
  
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
  
  def self.build_dictionary
    googlerese = File.read('mini.in').split("\n")[1..-1].join(" ")
    english = File.read('mini.out').split("\n")[1..-1].join(" ")
    googlerese.length.times do |i|
      Dictionary.letters[googlerese[i]] = english[i]
    end
  end
  
  def parse
    self.class.build_dictionary
    begin
      input = File.read(self.input_file)
      lines = input.split("\n")
      # TODO - ALWAYS adjust here
      lines.shift
      lines.each do |line|
        self.inputs << Input.new(line, self.inputs.length + 1)
      end
    rescue Errno::ENOENT => e
      outputter.puts "Oops! Wrong file!"
    end
  end
end

class Dictionary
  cattr_accessor :letters
  self.letters = {}
end

class Input < Struct.new(:line, :case_number)
  attr_accessor :result
  def solve
    self.result = ''
    line.each_char do |char|
      self.result << Dictionary.letters[char]
    end
  end
  
  def output
    "Case ##{case_number}: #{self.result}"
  end
end
