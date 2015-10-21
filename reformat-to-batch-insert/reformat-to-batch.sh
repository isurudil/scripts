#!/usr/bin/env bash

# grep the required table from the full script
# use cat {full-sql-dump-file} | grep {table-name} >> {table-name}.sql
# run the sh as ./reformat-to-batch.sh {table-name}.sql {table-name}
# This will create a file with batched sql statements for the specified table on the location of the script


sqlFile="$1"
tableName="$2"
index=0
# note the two spaces between INSERT and IGNORE. This was how the original file had its insert statements.
# change this accordingly to match your file
stringToBeReplaced="INSERT  IGNORE INTO \`$tableName\` VALUES"
batchSize=1000
while read -r line
do
    mod=$(($index%$batchSize))
    finalString=""
    if [ $mod -eq 0 ]; then
        finalString="${line/";"/,}"
    else
        resultString="${line/$stringToBeReplaced/ }"
        if [ $mod -ne $(($batchSize-1)) ]; then
            finalString="${resultString/";"/,}"
        else
            finalString=$resultString
        fi
    fi
    echo "$finalString" >> "$tableName.sql"
    let index=$(($index+1))
done < "$sqlFile"

sed -i '$s/,$/;/' "$tableName.sql"

# ~ Isuru D ~
