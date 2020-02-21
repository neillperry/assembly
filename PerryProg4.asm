########## PerryProg4.asm ##########

#         Title:  Program 4 - Counting                 #
#         Author: Neill Perry                          #
#         Date: Feb 25, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for one integer    #
#                      (2) count up to that integer    #
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

        # A. Prompt User to Enter an Integer
        la $a0, prompt        # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Please enter first integer:"

        #Get the INTEGER from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # Store the result from $v0 to $t0
        move $t0, $v0

        # Now that we have our integer, let's move on to the counting!

        #############################
        ##                         ##
        ##      Calculations       ##
        ##                         ##
        #############################

        # Initialize the constants
        li $t1, 1             # initialize the counter (t1)
        li $t2, 10            # initialize the divisor (t2)

        WHILE:
              bgt $t1, $t0, ENDWHILE   # if integer (t0) is greater than counter (t1), execute a loop

              # Display current number
              move $a0, $t1            # move counter from t1 --> a0 register
              li $v0,1                 # load call code to print the integer
              syscall                  # system call to print the integer

              ## NEW LINE EVERY TEN COUNTS

                  # STEP 1 - Divide the counter by TEN
                  div $t1,$t2   # Lo = $t1 / $t2     (Lo will contain the integer quotient)
                                # Hi = $t1 mod $t2   (Hi will contain the remainder)

                  mfhi $t3      # move the remainder in special register Hi to $t3:   $t3 = Hi
                                # we don't care about the quotient (Lo value)

                  # STEP 2 - If remainder does not equals ZERO, print a " "
                  beqz $t3, ELSE        # IF remainder != 0 then print a space after number
                  la $a0, space         # load beginning address of string into $a0 register
                  li $v0,4              # load instruction (li) to print the string loaded into register $v0
                  syscall               # system call to display " "
                  j ENDIF               # done with IF so jump over ELSE code to ENDIF label

                  ELSE:                 # ELSE executes only when counter is divisible by 10
                  la $a0, endl          # load beginning address of string into $a0 register
                  li $v0,4              # load instruction (li) to print the string loaded into register $v0
                  syscall               # system call to start a new line
                  j ENDIF               # done with ELSE code now move to ENDIF label

                  # STEP 3 - terminate IF statement, augmenting the counter, restart WHILE loop
                  ENDIF:
                  add $t1, $t1, 1          # increment the counter
                  j WHILE                  # start the WHILE loop again


        ENDWHILE: la $a0, endl        # load beginning address of display message into a0 register
              li $v0,4                # load call code to print a string
              syscall                 # system call to start a new line


        # We are done counting!!

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt: .asciiz "Please enter an integer greater than 0: "         # Prompt for test integer
         endl:   .asciiz "\n"                                                # insert new line
         space:   .asciiz " "                                                # insert a space

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################

         # Please enter the integer: -13

         # The integer you entered is ODD!

         # Thank you for coming to my TED talk
