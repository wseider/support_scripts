require 'csv'

class Checker_script
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
    CSV.foreach(input_file).map do |line|
      check_digit_checker(line[0])
    end
  end

  def write_newfile(input_file)
    output = []
    CSV.foreach(input_file).map do |line|
      output << check_digit_writer(line[0]).gsub(/\n/, '')
      CSV.open('correct_checks.csv', 'w', converters: :numeric, headers: false) do |f|
        output.each do |x|
          f << [x]
        end
      end
    end
  end
end

run = Checker_script.new
run.dry_run('input_files/GTINS.csv')
