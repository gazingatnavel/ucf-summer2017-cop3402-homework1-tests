#!/bin/bash

# This script is modeled on similar scripts provided by Dr. Sean Szumlanski 
# for COP 3503 Fall 2016 at UCF.

# Variable '$#' is the number of arguments to the script.
# Variable '$?' is the exit status of a command.
# Variable '$1' is the first argument to script.

# Make sure that there is an argument.
if [[ $# < 1 ]]; then
    echo "Usage: $0 <source code file>"
    exit 1
fi

# Attempt to find source input file (argument to script). If found, set
# variable 'executable', which will be the executable output file. The
# executable will have the same name as the source file, less the file 
# extension.
if [ -a $1 ]; then
    executable=${1%.c}
else
    echo "Unable to find source file '$1'"
    exit 1
fi

# Set output file name, if given as argument, default otherwise.
if [[ $# > 1 ]]; then
    output_file=$2
else
    output_file="vmoutput.txt"
fi

# Compile input source file into executable.
echo -n "Compiling $1... "
gcc $1 -o $executable 2> /dev/null

# Check that source file compiled.
if [[ $? != 0 ]]; then
    echo "fail (failed to compile)"
    exit 1
else
    echo "ok"
fi

# Temporarily rename file vminput.txt if it exists.
if [ -a "vminput.txt" ]; then
    mv vminput.txt vminput-temp.txt
fi

# Loop for input files...
for i in `seq 1 5`;
do
    # Provide some feedback.
    echo -n "Checking vminput-$i.txt... "
    
    # Rename the input file temporarily.
    mv vminput-$i.txt vminput.txt

    # vminput-5.txt reads from stdin. Input 7 to match output file.
    # Provide input for read instruction in vminput-5.txt and run executable.
    if [[ $i == 5 ]]; then
    	printf '7\n' | ./$executable > /dev/null 2> /dev/null
    else
        # Run the executable.
        ./$executable > /dev/null 2> /dev/null
    fi
    
    if [[ $? != 0 ]]; then
	echo "fail (program crashed)"
	
        # Rename file vminput-temp.txt if it exists.
        if [ -a "vminput-temp.txt" ]; then
            mv vminput-temp.txt vminput.txt
        fi
		
        # Rename the input file back to original name.
        mv vminput.txt vminput-$i.txt 2> /dev/null

        # Remove output file, if it exists.
        if [ -a $output_file ]; then
            rm $output_file 2> /dev/null
        fi

        exit 1
    fi
    
    # Compare the computed output file to the exepected output file,
    # ignoring blank lines.
    diff -iwB $output_file vmoutput-$i.txt > /dev/null 2> /dev/null

    # Print status, fail or pass.
    if [[ $? != 0 ]]; then
        echo "fail (output does not match)"
    else
        echo "PASS!"
    fi
    
    # Rename the input file back to original name.
    mv vminput.txt vminput-$i.txt 2> /dev/null

    # Remove output file.
    rm $output_file 2> /dev/null
    
done

# Rename file vminput-temp.txt if it exists.
if [ -a "vminput-temp.txt" ]; then
    mv vminput-temp.txt vminput.txt
fi

exit 0

