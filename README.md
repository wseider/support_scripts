Repo for various scripts to be used or tested by support team members

CONTENTS:
    -Check digit validator/creator: check_digit_checker.rb
    -adding optparse and refactoring reader/writer
    -add api client usability?
    
    -Check Digit Script usage:
        -clone this repo
        -pull GTINs (or UPCs) from export file into a single column, no header CSV or .txt file delimited by \n
            -I will add header reading functionality if people are really up in arms about it but doesn't seem terribly important
        -Navigate to check_digit_checker/check_digit_script.rb line 55 which will read: 
        `run.write_newfile('input_files/test.csv')`
        -to read the outputs locally in your terminal without creating a new file change line 55 to this and save:
        `run.dry_run('<your_input_filepath>')` 
        -to run it to create a newfile once you are confident in the outputs change line 55 to this and save:
        `run.write_newfile('<your_input_filepath>')`

        -Once you have saved your desired method on 55, copy the path of the script file, open up your terminal and run it as ruby.  If you have decided to create an output file, that will populate in the output_files section of the repo
        -`willseider-JGH5:support_scripts willseider$ ruby /Users/willseider/support_scripts/check_digit_checker/check_digit_script.rb`

        -If you generate an output file, simply overwrite the GTIN or UPC column in your import file with the output column
    
