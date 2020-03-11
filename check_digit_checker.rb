class 

def check_digit_checker(input)
    input_array = input.split("").map {|i| i.to_i}
    check_digit = input_array.slice(-1)
    working_array = input_array.reverse.drop(1).reverse
    odd_output = working_array.values_at(* working_array.each_index.select {|i| i.even?}).reduce{|sum, i| sum + i} * 3
    total_output = working_array.values_at(* working_array.each_index.select {|i| i.odd?}).reduce{|sum, i| sum + i} + odd_output
    output_check_digit = if total_output % 10 == 0 then 0 else 10 - (total_output % 10) end 
    
    if output_check_digit == check_digit
        puts "good check digit, the check digit is #{output_check_digit}"
    else puts "Bad check digit, check digit is #{output_check_digit}"
    end 
end

check_digit_checker("044600325122")