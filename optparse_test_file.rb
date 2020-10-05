# in parser.rb
require 'optparse'
require 'csv'

class OptParse
    Version = '1.0.0'

class Options
    attr_accessor = :dryrun, :write

    def initialize
        self.dryrun = nil
        self.write =nil
    end 

def define_options(parser)
 parser.banner = "Usage: check_digit_script.rb [load file] [options]"   
 
dryrun(parser)
write(parser)
 
parser.on('-h', '--help', 'options help') do 
   puts parser
   exit
 end


parser.on("-v", "--version", "Show version") do
    puts Version
    exit
end
end 

def dryrun(parser)

  parser.on('-d', '--dryrun', 'outputs evaluation to terminal') do 
        self.dryrun = true 
  end 
end 

def write(parser)

  parser.on('-w', '--w', 'writes correct gtins to new csv') do
        self.write = true
        end 
    end 
end 

def parse(args)
    @options = Options.new
    @args = OptionParser.new do |parser| 
        @options.define_options(parser)
        begin 
            parser.parse!(args)
        rescue OptionParser::InvalidOption => e 
            puts e.message
            exit 
        end 
        
        attr_reader :parser, :options
    end 




class Checker_script
    attr_accessor :options, :input_file

    def initialize(options)
        @input = ARGV[0]
        @dryrun = options.dryrun
        @write = options.write
    end 

  def check_digit_checker(input)
    line = input.to_s
    input_array = line.split('').map { |i| i.to_i }
    check_digit = input_array.slice(-1).to_i
    working_array = input_array.reverse.drop(1).reverse
    odd_output = working_array.values_at(* working_array.each_index.select { |i| i.even? }).reduce { |sum, i| i * 3 + sum }
    total_output = working_array.values_at(* working_array.each_index.select { |i| i.odd? }).reduce { |sum, i| sum + i } + odd_output
    output_check_digit = total_output % 10 == 0 ? 0 : 10 - (total_output % 10)

    if output_check_digit == check_digit
      puts "good check digit, the check digit for #{input} is #{output_check_digit}"
    else puts "Bad check digit, check digit for #{input} is #{output_check_digit}"
    end
  end

  def check_digit_writer(input)
    input_array = input.split('').map { |i| i.to_i }
    check_digit = input_array.slice(-1)
    working_array = input_array.reverse.drop(1).reverse
    odd_output = working_array.values_at(* working_array.each_index.select { |i| i.even? }).reduce { |sum, i| sum + i } * 3
    total_output = working_array.values_at(* working_array.each_index.select { |i| i.odd? }).reduce { |sum, i| sum + i } + odd_output
    output_check_digit = total_output % 10 == 0 ? 0 : 10 - (total_output % 10)
    input.gsub!(/.{1}$/, output_check_digit.to_s)
  end

  def dry_run(input_file)
    CSV.foreach(@input_file).map do |line|
      check_digit_checker(line[0])
    end
  end

  def write_newfile(input_file)
    output = []
    CSV.foreach(@input_file).map do |line|
      output << check_digit_writer(line[0]).gsub(/\n/, '')
      CSV.open('correct_checks.csv', 'w', converters: :numeric, headers: false) do |f|
        output.each do |x|
          f << [x]
        end
      end
    end
  end
end

op = OptParse.new 
options = op.parse(ARGV)
run = Checker_script.new(options)

if !(options.dryrun || options.write)
    m = "You must include one of the options, dryrun (-d) or write new file (-w)"
elsif [options.dryrun, options.write].compact.length > 1
    m =  "Choose only one option please"
end 

if m 
    begin 
        raise OptionParser::InvalidOption
    rescue OptionParser::InvalidOption => e 
        puts e.message + m
        exit 
    end 
end 

if options.dryrun
    run.dry_run
elsif options.write
    run.write_newfile
end 

