Repo for various scripts to be used or tested by support team members

CONTENTS:

1. CHECK DIGIT SCRIPT
    POSSIBLE UPGRADES/IN PROGRESS WORK:
    -adding optparse and refactoring reader/writer (IN PROGRESS)
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

        -https://labs.salsify.com/internal/bulk-update-ids can be used if this is a product ID property

2. BULK DELETE VIEWS SCRIPT 
    -POSSIBLE UPGRADES/IN PROGRESS WORK:
        -add DBI capability so use of redash is unnecessary

    -Bulk Delete Views Script Usage:
        -clone this repo
        -run redash query in redash_queries doc with your desired inputs to generate the script's input file (.csv)
        -if your views have apostrophes in them, you will need to escape them, but redash arrays don't seem to like double quotes.  open the file in a text editor and use the regex search with this: (?<!^)'(?!,) 
        -put another single quote in front of the unescaped single quote (though you will find the single quote at the end of the final item on the list, just go back and fix that)
        -Run the script in CLI like so: $ ruby [script file path] [api key] [external org id] [load file path] [OPTIONAL superuser id if running as superuser]

3. BULK DELETE LISTS SCRIPT:
    -POSSIBLE UPDATES/WIP:
        -better error handling for the 422's, including list name and an investigation of how to pre (or post) vet references of the entities
        -add DBI capability to cut out redash
        -make housecleaning script one (with cli option parsing to differentiate)
        

    -Bulk Delete Lists Script Usage:
        -clone this repo
        -run redash query in redash_queries doc with your desired inputs to generate the script's input file (.csv)
        -if your lists have apostrophes in them, you will need to escape them, but redash arrays don't seem to like double quotes.  open the file in a text editor and use the regex search with this: (?<!^)'(?!,) 
        -put another single quote in front of the unescaped single quote (though you will find the single quote at the end of the final item on the list, just go back and fix that)
        -Run the script in CLI like so: $ ruby [script file path] [api key] [external org id] [load file path] [OPTIONAL superuser id if running as superuser]
        -if your information above is correct (org id and api key, valid list id), you will return a series of 204s.  one caveat to this is if lists are referenced in other entities (likely workflows, filters, etc) you will return a: 
            `422 {"errors":["This list is referenced by other entities and cannot be deleted at this time."]}`
        -if you hit this error, the script will still run as this is not an exception that you might hit with the formatting of the script input, which would be rescued, but part of the response

4. BULK DELETE VIEWS SCRIPT 
    -POSSIBLE UPGRADES/IN PROGRESS WORK:
        -add DBI capability so use of redash is unnecessary

    -Bulk Delete Views Script Usage:
        -clone this repo
        -run redash query in redash_queries doc with your desired inputs to generate the script's input file (.csv)
        -if your catalogs have apostrophes in them, you will need to escape them, but redash arrays don't seem to like double quotes.  open the file in a text editor and use the regex search with this: (?<!^)'(?!,) 
        -put another single quote in front of the unescaped single quote (though you will find the single quote at the end of the final item on the list, just go back and fix that)
        -Run the script in CLI like so: $ ruby [script file path] [api key] [external org id] [load file path] [OPTIONAL superuser id if running as superuser]
        -if your information above is correct (org id and api key, valid catalog id), you will return a series of 204s 
        
