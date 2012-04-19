require 'active_support/all'

class MilkshakeFactory
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
      count = 1
      while lines.present? do
        shop = Shop.new(lines.shift.to_i, self.inputs.length + 1)
        num_of_customers = lines.shift.to_i
        customers = lines.shift(num_of_customers)
        customers.each do |customer_string|
          customer = customer_string.split(" ").map {|c| c.to_i}
          num_of_flavours, *flavours = customer
          shop.customers << Customer.new(num_of_flavours, flavours.in_groups_of(2), shop)
        end
        self.inputs << shop
      end
    rescue Errno::ENOENT => e
      outputter.puts "Oops! Wrong file!"
    end
  end
end

class Shop
  attr_accessor :flavours, :customers, :number_of_flavours, :result, :case_number, :batch
  
  def initialize(number_of_flavours = 1, case_number = 0)
    self.number_of_flavours = number_of_flavours
    self.batch = (1..number_of_flavours).map {|f| Flavour.new(f, false)} # Setting up default values
    self.customers = []
    self.case_number = case_number
  end
  
  def solve
    if customers.all? {|c| c.satisfied?}
      self.result = self.batch.map{|f| f.output}.join(' ')
    else
      unsatisfied = self.customers.select {|c| !c.satisfied?}
      if unsatisfied.all?{|c| c.malted == -1 && self.batch}
        self.result = 'IMPOSSIBLE'
      else
        customer = unsatisfied.first
        if customer
          customer.satisfy!
          solve
        end
        if self.result != 'IMPOSSIBLE'
          self.result = self.batch.map{|f| f.output}.join(' ')
        end
      end
    end
  end
  
  def output
    "Case ##{case_number}: #{result}"
  end
end

class Flavour < Struct.new(:number, :malted)
  def malted?
    !!malted
  end
  
  def malt!
    self.malted = true
  end
  
  def output
    malted? ? '1' : '0'
  end
end

class Customer
  attr_accessor :num_flavours, :flavours, :malted, :batch, :shop
  def initialize(num_flavours, flavours, shop = nil)
    self.num_flavours = num_flavours
    self.flavours = []
    self.malted = -1
    flavours.each_with_index do |f, i|
      flavour = Flavour.new(f[0], f[1] == 1)
      self.malted = i if flavour.malted?
      self.flavours << flavour
    end
    self.shop = shop if shop
  end
  
  def satisfied?
    (self.shop.batch & flavours).length > 0
  end
  
  def satisfy!
    self.shop.batch[self.malted].malt! if self.malted > -1
  end
  
end
