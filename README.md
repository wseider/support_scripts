Repo for various scripts to be used or tested by support team members

CONTENTS:
<<<<<<< HEAD

1. CHECK DIGIT SCRIPT
    POSSIBLE UPGRADES/IN PROGRESS WORK:
    -adding optparse and refactoring reader/writer (IN PROGRESS)
=======
    
    -Check digit validator/creator: check_digit_checker.rb
    -adding optparse and refactoring reader/writer
>>>>>>> 0fdb5273700811a42d768d6dce55aa7fb88ceaed
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
<<<<<<< HEAD

2. BULK DELETE VIEWS SCRIPT 
    -POSSIBLE UPGRADES/IN PROGRESS WORK:
        -add DBI capability so use of redash is unnecessary

    -Bulk Delete Views Script Usage:
        -clone this repo
        -run redash query in redash_queries doc with your desired inputs to generate the script's input file (.csv)
        -if your views have apostrophes in them, you will need to escape them, but redash arrays don't seem to like double quotes.  open the file in a text editor and use the regex search with this: (?<!^)'(?!,) 
        -put another single quote in front of the unescaped single quote (though you will find the single quote at the end of the final item on the list, just go back and fix that)
        -for method at the bottom: 
        `DeleteViews.new('{user's salsify api key}', '{customer external org id}', '{csv filepath generated from redash query}')`
        -save script file and run in terminal, example:
        willseider-JGH5:support_scripts willseider$ ruby /Users/willseider/support_scripts/bulk_delete_views/delete_views.rb
        -if your information above is correct (org id and api key), you will return a series of 204s
=======
    
>>>>>>> 0fdb5273700811a42d768d6dce55aa7fb88ceaed
