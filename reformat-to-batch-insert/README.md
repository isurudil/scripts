# Readme

* grep the required table from the full script
* use cat {full-sql-dump-file} | grep {table-name} >> {table-name}.sql
* run the sh as ./reformat-to-batch.sh {table-name}.sql {table-name}
* This will create a file with batched sql statements for the specified table on the location of the script

## Note

* note the two spaces between INSERT and IGNORE in the variable stringToBeReplaced. This was how the original file had its insert statements. change this accordingly to match your file

~ Isuru D ~
