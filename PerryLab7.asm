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

        # B. Initialize pointer and counter
        li $t1, 0             # initialize the counter (t1)
        li $t2, 10            # initialize divisor (t3) for average calculation
        li $t3, 0             # initialize the pointer (t3) to 0

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
          sw $v0, array($t3)

          add $t3, $t3, 4          # increment the counter
          add $t1, $t1, 1          # move pointer one character
          j WHILE                  # start the loop again

        ENDWHILE:
              la $a0, average       # load beginning address of display message into a0 register
              li $v0,4               # load call code to print a string
              syscall                # system call to start a new line

        # Now that we have our integer array, let's move on to the averaging!

        #############################
        ##                         ##
        ##     The Averaging       ##
        ##                         ##
        #############################

        # C. Iterate over the array, adding as you go
        # WHILE: lb, $t0, ($t2)          # get a byte from the string
        #       beqz $t0, ENDWHILE       # zero means end of string
        #      add $t1, $t1, $t2        # increment the counter
        #      add $t2, 1               # move pointer one character
        #      j WHILE                  # start the loop again


        # ENDWHILE: la $a0, average       # load beginning address of display message into a0 register
        #      li $v0,4               # load call code to print a string
        #      syscall                # system call to start a new line

        # D. Calculate the average by dividing sum by 10
        # div $t1,$t3   # Lo = $t0 / $t3     (Lo will contain the integer quotient)
                      # Hi = $t0 mod $t3   (Hi will contain the remainder)

        # mflo $t4      # move quantity in special register Lo to $t3
                      # we don't care about the remainder. It's dead to us.

        #############################
        ##                         ##
        ##     Display Results     ##
        ##                         ##
        #############################

        # D. Display Array Sum
        la $a0, thing          # load beginning address of display message into a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "\nArray Average: "

        # Display final count
        move $a0, $t1          # move counter from t1 --> a0 register
        li $v0,1               # load call code to print the integer
        syscall                # system call to print the integer

        # E. Display Array Average
        la $a0, array          # load beginning address of display message into a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "\nArray Sum: "

        # Display average
        move $a0, $t4          # move average from t3 --> a0 register
        li $v0,1               # load call code to print the integer
        syscall                # system call to print the integer

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt:      .asciiz  "Enter an integer: "        # Prompt for integers
         sum:         .asciiz  "\nArray Sum: "             # Line showing result
         average:     .asciiz  "\nArray Average"           # new line

         array:       .word 3, 0, 1, 2, 6, -2, 4, 7, 3, 7  # 10 element integer array
         thing:       .space 40                            # every integer needs 4 bytes

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################
