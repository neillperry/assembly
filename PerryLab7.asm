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
        ##   Get 10 User Inputs    ##
        ##                         ##
        #############################

        # B. Initialize pointer and counter
        li $t1, 0             # initialize the counter (t1) to 0
        li $t2, 0             # initialize the pointer (t2) to 0

        WHILE:
          bgt, $t1, 9, ENDWHILE
          # A. Prompt User to Enter an integer
          la $a0, prompt        # load address of prompt into a0
          li $v0,4              # load instruction number to display a string into v0
          syscall               # v0 = 4, indicates display a string

          #Get the FIRST integer from User
          li $v0, 5             # load instruction to read an integer from keyboard
          syscall               # system call to read integer and store in $f0

          # Store the result from $v0 to array
          sw $v0, array($t2)

          add $t1, $t1, 1          # increment loop counter by 1
          add $t2, $t2, 4          # increment the array pointer by 4 (bytes)

          j WHILE                  # start the loop again

        ENDWHILE: la $a0, endl       # load beginning address of display message into a0 register
            li $v0,4               # load call code to print a string
            syscall                # system call to start a new line

        # Now that we have our integer array, let's move on to the averaging!

        #############################
        ##                         ##
        ##     The Averaging       ##
        ##                         ##
        #############################

        # Initialize pointer and counter and running total
        li $t1, 0             # initialize the counter (t1)
        la $t2, array         # initialize the pointer (t2)
        li $t3, 0             # initialize running sum (t3) to 0

        # C. Iterate over the array, adding as you go
        WHILE2:
               bgt, $t1, 9, ENDWHILE2  # loop over array until counter is greater than 9
               lb $t0, ($t2)           # get a byte from the string

               move $a0, $t0          # move counter from t3 --> a0 register
               li $v0,1               # load call code to print the integer
               syscall                # system call to print the integer

               la $a0, space          # load beginning address of display message into a0 register
               li $v0,4               # load call code to print a string
               syscall                # system call to start a new line

               add $t3, $t0, $t3        # add byte to running total

               add $t1, $t1, 1          # increment loop counter by 1
               add $t2, $t2, 4          # increment the array pointer by 4 (bytes)

               j WHILE2                  # start the loop again


        ENDWHILE2: la $a0, endl       # load beginning address of display message into a0 register
                   li $v0,4               # load call code to print a string
                   syscall                # system call to start a new line


        #############################
        ##                         ##
        ##     Display Results     ##
        ##                         ##
        #############################

        # E. Display Array Average
        la $a0, average        # load beginning address of display message into a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "\nArray Average: "

        # D. Calculate the average by dividing sum by 10
        div $t3, $t3, 10       # divide running total by ten and store that average in t3

        # Display average
        move $a0, $t3          # move average from t3 --> a0 register
        li $v0,1               # load call code to print the integer
        syscall                # system call to print the integer

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt:      .asciiz  "Enter an integer: "        # Prompt for integers
         average:     .asciiz  "\nArray Average: "         # Line showing average
         space:       .asciiz  "  "                        # Space to insert b/w numbers
         endl:        .asciiz  "\n"                        # Start new line


        array:       .word 40                            # every integer needs 4 bytes

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################

        #  Enter an integer: 12
        #  Enter an integer: 14
        #  Enter an integer: 16
        #  Enter an integer: 18
        #  Enter an integer: 20
        #  Enter an integer: 22
        #  Enter an integer: 24
        #  Enter an integer: 26
        #  Enter an integer: 28
        #  Enter an integer: 30

        #  12  14  16  18  20  22  24  26  28  30

        #  Array Average: 21
