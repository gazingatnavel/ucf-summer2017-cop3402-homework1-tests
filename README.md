# ucf-summer2017-cop3402-homework1-tests
bash shell script and test files to automate testing of homework 1

This is a bash shell script that will perform automated testing for the UCF Summer 2017 COP 3402 Homework 1.

The shell script (`run-test-cases.sh`) will run homework 1 executable with five test machine code files (`vminput-1.txt to vminput-5.txt`), and compare the output to files that contain the expected output (`vmoutput-1.txt to vmoutput-5.txt`).

Here's what it does:
1. Compiles <source_file_name>.c file into an executable named <source_file_name>.
2. Runs the resulting executable with the test machine code files.
3. Compares the output to the expected output, and prints a pass or fail message.

To use the shell script:
1. Copy the shell script, machine code input files, and output files to the directory in Eustis where your source code file exists.
2. Make the shell script executable by running the command `chmod 744 run-test-cases.sh`.
3. Run the script by typing the command `./run-spim-tests.sh <source_file_name>.c`.

For example, if your source code file name is `my-source.c`, your would run the script with the command `./run-test-cases.sh my-source.c`.

The script assumes that default output file name is `vmoutput.txt`. If your program generates a different output file name, you can use that file name by entering it as the second argument to the script. For example, if your source code file is named `my-source.c` and your output file is named `my-output.txt`, then to run the script, you would enter the command `./run-test-cases.sh my-source.c my-output.txt`.

When you run the script, you should see something like:
```
Compiling <source_file_name>.c... ok
Checking vminput-1.txt...PASS!
Checking vminput-2.txt...PASS!
Checking vminput-3.txt...PASS!
Checking vminput-4.txt...PASS!
Checking vminput-5.txt...PASS!
```
If you see a fail message (`fail (output does not match)`):
1. run your executable with the test machine code input file, 
2. compare the output to the contents of the test output files to determine differences.

The shell script uses the `diff` command to compare the executable output to the expected output in the test files. If you are familiar with the `diff` command, you can use it to help find differences between your output and the expected output.

I believe that the test files produce the correct expected output, but there's always a chance that I've made an error. Please let me know if you believe there is an error in the files, or if you would like to add some tests of your own. You can post a comment in the course discussions, or if you have a GitHub account, you can submit a pull request.
