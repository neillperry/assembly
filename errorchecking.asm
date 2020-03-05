########## PerryLab8.asm ##########
#
#         Title:  Lab 8 - Extend minmax                #
#         Author: Neill Perry                          #
#         Date: March 3, 2020                          #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user # of integers      #
#                      (2) ask for integers for array  #
#                      (3) display array               #
#                      (4) calculate min / max         #
#                      (5) display min / max           #
#         Initial Algorithm:  looping structure        #
#         Data Requirements:                           #
#             Input variables: user inputs integers    #
#             Output variables: integers               #
#             Addition Variables:                      #
#                                                      #
#         Formulas:                                    #
#
####################################

       .text
      .globl main

main:
      #############################
      ##                         ##
      ##  Ask User to Set Array  ##
      ##        Size n           ##
      ##                         ##
      #############################

      # A. Get integer n from User
      la $a0, arraysize     # load address of string output into a0
      li $v0,4              # load instruction number to display a string into v0
      syscall               # v0 = 4, indicates display a string

      # B. Get the integer from User
      li $v0, 5             # load instruction to read an integer from keyboard
      syscall               # system call to read integer and store in $f0

      # C. Store the result from $v0 to $t0
      move $t0, $v0         # t1 will be the counter for the while loop below

      # D. Set upper and lower limits on array size
      li $t1, 15
      li $t2, 1

      # E. Check upper and lower bounds
      # STEP 1 - check to see if user input is less than 15
      blt $t0, $t1, ELSE     # IF input < 15 then check lower limit
        move $t0, $t1        # IF input > 15, reset it to 15
        j ELSE               # done with IF so move to ELSE label

      # STEP 2 - check to see if user input is greater than 0
      ELSE:
      ble $t2, $t0, ENDIF     # IF 1 <= input then move to ENDIF
        move $t0, $t2         # If input <0 , reset it to 1
        j ENDIF               # done with IF so move to ENDIF label

      # STEP 2 - terminate IF statement, augmenting the counter, restart WHILE loop
      ENDIF:
        # Insert next line
        la $a0, endl          # load address of new line into a0
        li $v0,4              # load instruction number to display a string into v0
        syscall               # v0 = 4, indicates display a string


      la $a0,max          # Display "The maximum number is "
      li $v0,4            # a0 = address of message
      syscall             # v0 = 4 which indicates display a string

      move $a0,$t0        # Display the maximum number
      li $v0,1
      syscall

      li $v0,10           # End Of Program
      syscall


  .data
          arraysize:   .asciiz  "Enter array size: "    # Prompt user for array size
          prompt:      .asciiz  "Enter an integer: "        # Prompt for integers
          max:         .asciiz  "\nThe maximum number is "    # line showing max number
          min:         .asciiz  "\nThe minimum number is "    # line showing min number
          space:       .asciiz  "  "                        # Space to insert b/w numbers
          endl:        .asciiz  "\n"                        # Start new line


          array:       .word 80                            # every integer needs 4 bytes


          add $t3, $t1, 0     # total string length
          la $t2, string      # initialize the pointer (t2)
          li $t4, 0           # vowel counter

          WHILE2: lb, $t0, ($t2)          # get a byte from the string
                beqz $t3, exit       # zero means end of string

                # Display result string
                la $a0, space           # load beginning address of display message into a0 register
                li $v0,4                # load call code to print a string
                syscall                 # system call to display " "

                # Display final count
                lbu $a0, ($t2)          # move string from t2 --> a0 register
                li $v0,11               # load call code to print the character
                syscall                # system call to print the integer

                add $t3, $t3, -1          # increment the counter
                add $t2, 1               # move pointer one character
                j WHILE2                  # start the loop again


            la $a0, endl       # load beginning address of display message into a0 register
            li $v0,4               # load call code to print a string
            syscall                # system call to start a new line
