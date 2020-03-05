########## PerryProg5.asm ##########

#         Title:  Program 5 - Counting Revisited       #
#         Author: Neill Perry                          #
#         Date: Mar 10, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for one integer    #
#                      (2) print up to that integer    #
#         Initial Algorithm:  While Loop               #
#         Data Requirements:                           #
#             Input variables: user inputs integer     #
#             Output variables: series of integers     #
#                                                      #
#         Formulas:  none                              #

####################################

.text
.globl main
main:
#############################
##                         ##
##     Get User Input      ##
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
##     The Counting        ##
##                         ##
#############################

# Initialize pointer and counter
la $t2, string        # initalize the pointer (t2)
li $t1, 0             # initialize the counter (t1)

WHILE: lb, $t0, ($t2)          # get a byte from the string
      beqz $t0, ENDWHILE       # zero means end of string
      add $t1, $t1, 1          # increment the counter
      add $t2, 1               # move pointer one character
      j WHILE                  # start the loop again


ENDWHILE: la $a0, endl        # load beginning address of display message into a0 register
      li $v0,4               # load call code to print a string
      syscall                # system call to start a new line

#############################
##                         ##
##     Display Result      ##
##                         ##
#############################

# Display result string
la $a0, result           # load beginning address of display message into a0 register
li $v0,4               # load call code to print a string
syscall                # system call to display "String length is: "

# Display final count
move $a0, $t1          # move counter from t1 --> a0 register
li $v0,1               # load call code to print the integer
syscall                # system call to print the integer

# Terminate Program
li $v0,10            # load call code to End Program
syscall              # system call to end program

#DATA SECTION
.data
 prompt:      .asciiz  "Please enter the string to be counted: "        # Prompt for string
 result:      .asciiz  "String length is: "                             # Display count length
 endl:        .asciiz  "\n"                                             # Test variable
 string:      .space 82                                                 # User input

 #############################
 ##                         ##
 ##     Sample Output       ##
 ##                         ##
 #############################

 # Please enter the string to be counted: Hello

 #

 # String length is: 7
