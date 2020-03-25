require 'optparse'
require 'csv'
class OptParse
  Version = '0.2.6'

class Options 
  attr_accessor :dryrun, :overwrite

  def initialize
    self.dryrun = nil
    self.overwrite = nil
  end 

  def create_options(parser)
    parser.banner = "Usage: <UPC/GTIN column>.csv [input file] [options]"
    dryrun_mode(parser)
    overwrite_mode(parser)

    parser.on("-h", "--help", "Show menu") do
      puts parser
      exit
    end
  end 

  def dryrun_mode(parser)
    parser.on("-d", "--dryrun", 'Shows which gtins are correct and incorrect and shows suggested change based on GS1 standard for calculation') do
      self.dryrun = true
    end 
  end 

  def overwrite_mode(parser)
    parser.on("-o", "--overwrite", 'Overwrites incorrect GTIN check digits and outputs CSV file to replace in your GTIN import column') do
      self.overwrite = true
    end 
  end 
end 

def parse(args)
  @options = Options.new
  @args = OptionParser.new do |parser|
    @options.create_options(parser)
    begin 
      parser.parse!(args)
    rescue OptionParser::InvalidOption => e
      puts e.message
      exit
    end 
end 
@options
rescue OptionParser::MissingArgument => e 
  puts e.message
  exit
end

attr_reader :parser, :options
end 

class Checker_script
    attr_accessor :options
  
    def initialize
      @input = ARGV[0]
      @dryrun = options.dryrun
      @overwrite = options.overwrite
    end 
 
    
  def check_digit_checker(input)
      input_array = input.split("").map {|i| i.to_i}
      check_digit = input_array.slice(-1)
      working_array = input_array.reverse.drop(1).reverse
      odd_output = working_array.values_at(* working_array.each_index.select {|i| i.even?}).reduce{|sum, i| sum + i} * 3
      total_output = working_array.values_at(* working_array.each_index.select {|i| i.odd?}).reduce{|sum, i| sum + i} + odd_output
      output_check_digit = if total_output % 10 == 0 then 0 else 10 - (total_output % 10) end 
      
      if output_check_digit == check_digit
          puts "good check digit, the check digit is #{output_check_digit}"
      else puts "Bad check digit, check digit for #{input} is #{output_check_digit}"
      end 
  end

  def check_digit_writer(input)
          input_array = input.split("").map {|i| i.to_i}
          check_digit = input_array.slice(-1)
          working_array = input_array.reverse.drop(1).reverse
          odd_output = working_array.values_at(* working_array.each_index.select {|i| i.even?}).reduce{|sum, i| sum + i} * 3
          total_output = working_array.values_at(* working_array.each_index.select {|i| i.odd?}).reduce{|sum, i| sum + i} + odd_output
          output_check_digit = if total_output % 10 == 0 then 0 else 10 - (total_output % 10) end 
          input.gsub!(/.{1}$/, "#{output_check_digit}")
  end 
  
  
  def dry_run(input_file)
      File.foreach(input_file) do |line|
      check_digit_checker(line)
      end 
  end 

  def write_newfile(input_file)
      output = []
      File.foreach(input_file) do |line|
      output << check_digit_writer(line).gsub(/\n/, "")
      CSV.open('output_files/correct_checks.csv', 'w', converters: :numeric) {|f|  
              f << output
              }
      end 
  end 
end


run = Checker_script.new
run.write_newfile('input_files/test.csv')