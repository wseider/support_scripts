require 'optparse'

Options = Struct.new(:name)

class Parser
  def self.parse(options)
    args = Options.new("world")

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: <UPC/GTIN column>.txt [options]"

      opts.on("-dDryRun", "--dry run", "show check digit dry run") do |n|
        args.name = n
      end

      opts.on("-iInPlace", "--write in place", "writes the correct check digit") do |i|
        args.name = i
      end 

      opts.on("-h", "--help", "shows options") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end
options = Parser.parse %w[--help]
p options