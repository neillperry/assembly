########## PerryLab7.asm ##########

#         Title:  Lab 7 - Finding the Average          #
#         Author: Neill Perry                          #
#         Date: March 3, 2020                          #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for 10 integers    #
#                      (2) store integers in an array  #
#                      (3) display array contents      #
#                      (4) calculate array average     #
#         Initial Algorithm:                           #
#         Data Requirements:                           #
#             Input variables: user inputs 10 ints     #
#             Output variables: integer                #
#             Addition Variables:                      #
#                                                      #
#         Formulas: basic arithmetic                   #

####################################

        .text
        .globl main
main:
        #############################
        ##                         ##
        ##     Get User Inputs     ##
        ##                         ##
        #############################

        # A. Prompt User to Enter a String
        la $a0, prompt        # load address of prompt into a0
        li $v0,4              # load instruction number to display a string into v0
        syscall               # v0 = 4, indicates display a string

        li $a1, 81           # set 81 character limit on string variable
        la $a0, array        # get address of string variable
        li $v0, 8            # read string from keyboard (v0 = 8, indicates await user input)
        syscall

        # Now that we have our string, let's move on to the counting!


        li $a1, 40            # set 81 character limit on string variable
        la $a0, string        # get address of string variable
        li $v0, 8             # read string from keyboard (v0 = 8, indicates await user input)
        syscall

        # Now that we have our integers, let's move on to the averaging!

        #############################
        ##                         ##
        ##     The Averaging       ##
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


        ENDWHILE: la $a0, endl       # load beginning address of display message into a0 register
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
         prompt:      .asciiz  "Enter 10 integers (no commas): "        # Prompt for integers
         result:      .asciiz  "\nArray: "                         # Line showing result
         endl:        .asciiz  "\n"                        # new line
         comma:       .asciiz  ", "                        # comma

         array:       .space 40                            # 10 element integer array

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################
