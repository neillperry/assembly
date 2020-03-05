########## PerryProg5.asm ##########

#         Title:  Program 5 - Counting Revisited       #
#         Author: Neill Perry                          #
#         Date: Mar 10, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for a string       #
#                      (2) count total characters      #
#                      (3) count total vowels          #
#                      (4) print both counts           #
#         Initial Algorithm:  While Loop               #
#         Data Requirements:                           #
#             Input variables: user inputs a string    #
#             Output variables: two integers           #
#                                                      #
#         Formulas:  none                              #

####################################

.text
.globl main
main:
#############################
##                         ##
##   Get a String from     ##
##        the User         ##
##                         ##
#############################

# A. Prompt User to Enter a String
la $a0, prompt        # load address of prompt into a0
li $v0,4              # load instruction number to display a string into v0
syscall               # v0 = 4, indicates display a string

li $a1, 81            # set 81 character limit on string variable
la $a0, string        # get address of string variable
li $v0, 8             # read string from keyboard (v0 = 8, indicates await user input)
syscall

# Now that we have our string, let's move on to the counting!

#############################
##                         ##
##     The Counting x2     ##
##                         ##
#############################

# per lab requirements, need to count both total characters and number of vowels
# do not count the Enter the user inputs after the string

# Initialize pointer and counter(total) and counter(vowels)
li $t1, 0             # initialize the total counter (t1)
la $t2, string        # initialize the pointer (t2)
li $t3, 0             # vowel counter

WHILE: lb, $t0, ($t2)          # get a byte from the string
      beqz $t0, ENDWHILE       # zero means end of string

      # Display result string
      la $a0, space           # load beginning address of display message into a0 register
      li $v0,4                # load call code to print a string
      syscall                 # system call to display " "

      # Display final count
      lbu $a0, ($t2)          # move string from t2 --> a0 register
      li $v0,11               # load call code to print the character
      syscall                # system call to print the integer

      add $t1, $t1, 1          # increment the counter
      add $t2, 1               # move pointer one character
      j WHILE                  # start the loop again


ENDWHILE: la $a0, endl       # load beginning address of display message into a0 register
      li $v0,4               # load call code to print a string
      syscall                # system call to start a new line

add $t1, $t1, -1             # "take back one kadam to honor the Hebrew God whose Ark this is"

#############################
##                         ##
##  The Counting: Part II  ##
##                         ##
#############################




#############################
##                         ##
##     Display Result      ##
##                         ##
#############################

# Display result string
la $a0, result           # load beginning address of display message into a0 register
li $v0,4                 # load call code to print a string
syscall                  # system call to display "String length is: "

# Display final count
move $a0, $t1          # move counter from t1 --> a0 register
li $v0,1               # load call code to print the integer
syscall                # system call to print the integer

# Display results of vowel count
la $a0, vowels           # load beginning address of display message into a0 register
li $v0,4                 # load call code to print a string
syscall                  # system call to display "String length is: "

# Display final count
move $a0, $t3          # move counter from t1 --> a0 register
li $v0,1               # load call code to print the integer
syscall                # system call to print the integer

# Terminate Program
li $v0,10            # load call code to End Program
syscall              # system call to end program

#DATA SECTION
.data
 prompt:      .asciiz  "\nPlease enter the string to be counted: "      # Prompt for string
 result:      .asciiz  "\nString length is: "                           # Display count length
 vowels:      .asciiz  "\nNumber of vowels in string is: "              # Display number of vowels counted
 endl:        .asciiz  "\n"                                             # new line
 test:        .asciiz  "a"                                              # test things
 space:       .asciiz  "  "                                             # space to insert b/w numbers
 string:      .space 82                                                 # User input

 #############################
 ##                         ##
 ##     Sample Output       ##
 ##                         ##
 #############################

 # Please enter the string to be counted: Hello

 #

 # String length is: 7
