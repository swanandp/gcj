class T9Dictionary
  attr_accessor :outputter, :inputs, :input_file, :output_file
  
  def initialize(input_file, output_file)
    self.input_file = input_file
    self.output_file = output_file
    self.inputs = []
    @outputter ||= self
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
      lines.each_with_index do |line, i|
        # TODO - ALWAYS adjust here
        self.inputs << Input.new(line, i + 1)
      end
    rescue Errno::ENOENT => e
      outputter.puts "Oops! Wrong file!"
    end
  end

end


class Input < Struct.new(:letters, :case_number)
  attr_accessor :translated_letters

  def solve
    self.translated_letters = ''
    prev_letter = nil
    self.letters.each_char do |letter|
      digit = Input.digit_lookup_table[letter]
      if prev_letter && Input.digit_lookup_table[letter] == Input.digit_lookup_table[prev_letter]
        self.translated_letters << ' '
      end
      self.translated_letters << Input.digit_lookup_table[letter].to_s * Input.letter_lookup_table[Input.digit_lookup_table[letter]].index(letter)
      prev_letter = letter
    end
    self.translated_letters
  end
  
  def output
    "Case ##{case_number}: #{translated_letters}"
  end
  
  def self.digit_lookup_table
    @@digit_lookup_table ||= {
      " " => 0,
      "a" => 2, "b" => 2, "c" => 2, 
      "d" => 3, "e" => 3, "f" => 3, 
      "g" => 4, "h" => 4, "i" => 4, 
      "j" => 5, "k" => 5, "l" => 5, 
      "m" => 6, "n" => 6, "o" => 6, 
      "p" => 7, "q" => 7, "r" => 7, "s" => 7, 
      "t" => 8, "u" => 8, "v" => 8, 
      "w" => 9, "x" => 9, "y" => 9, "z" => 9
    }
  end
  
  def self.letter_lookup_table
    @@letter_lookup_table ||= [
      %w{- \ },
      '-',
      %w{- a b c},
      %w{- d e f},
      %w{- g h i},
      %w{- j k l},
      %w{- m n o},
      %w{- p q r s},
      %w{- t u v},
      %w{- w x y z}
    ]
  end
end
