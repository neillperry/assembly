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

      # A. Ask User for an integer
      la $a0, arraysize     # load address of string output into a0
      li $v0,4              # load instruction number to display a string into v0
      syscall               # v0 = 4, indicates display a string

      # B. Get the integer from User
      li $v0, 5             # load instruction to read an integer from keyboard
      syscall               # system call to read integer and store in $f0

      # C. Store the result from $v0 to $t0
      move $t0, $v0         # t0 will be the counter for the while loop below

      # D. Insert blank line for aesthetics
      la $a0, endl          # load beginning address of display message into a0 register
      li $v0,4              # load call code to print a string
      syscall               # system call to start a new line

      # Per lab instructions, no need to error check user input (assume 1<=input<=15)

      #############################
      ##                         ##
      ##   Get n User Integers   ##
      ##                         ##
      #############################

      # E. Initialize counter and array pointer
      li $t1, 0             # initialize the counter (t1) to 0
      li $t2, 0             # initialize the pointer (t2) to 0

      # F. Loop n times to get all the integers for the array
      WHILE:

        # 1. WHILE pointer is less than array size n
        bge, $t1, $t0, ENDWHILE

        la $a0, endl     # load beginning address of display message into a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to start a new line

        # 2. Prompt User to Enter an integer
        la $a0, prompt        # load address of prompt into a0
        li $v0,4              # load instruction number to display a string into v0
        syscall               # v0 = 4, indicates display a string

        # 3. Get the integer from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # 4. Store the result from $v0 to array and increment pointer and counter
        sw $v0, array($t2)
        add $t1, $t1, 1       # increment loop counter by 1
        add $t2, $t2, 4       # increment the array pointer by 4 (bytes)

        j WHILE             # start the loop again

      # G. Insert blank line for aesthetics
      ENDWHILE:
        la $a0, endl        # load beginning address of display message into a0 register
        li $v0,4            # load call code to print a string
        syscall             # system call to start a new line

      # Now that we have our integer array, let's find min and max!!

      #############################
      ##                         ##
      ##     Find Min / Max      ##
      ##                         ##
      #############################

      # H. Reset array pointer and counter
      li $t1, 0            # initialize the counter (t1) to 0
      la $t2, array        # t2 = address of array

      # I. Initialize values
      # set initial values min = max = array[0]
      # lw means load word, loading a word from array (via t0) to t2 and t3
      # lb means load byte, loading a byte from array
      lw $t3, ($t2)        # t3 = min = a[0] (initialization)
      lw $t4, ($t2)        # t4 = max = a[0] (initialization)

      # J. Iterate over the array, adding as you go
      WHILE2:
             bge, $t1, $t0, ENDWHILE2    # loop over array until counter is greater than user set array size
             lw $t5, ($t2)              # get a byte from the array

             # 1. PRINT ARRAY ELEMENT
             move $a0, $t5          # move counter from t6 --> a0 register
             li $v0,1               # load call code to print the integer
             syscall                # system call to print the integer

             la $a0, space          # load beginning address of display message into a0 register
             li $v0,4               # load call code to print a string
             syscall                # system call to start a new line

             # 2. CHECK MIN / MAX VALUES
             bge $t5, $t3, notMin   # if array element >= current Min (t3) goto notMin
                 move $t3, $t5      # otherwise set a new min value = a[i]
                 j notMax

               notMin: ble $t5,$t4,notMax  # if array element <= current Max (t4) goto notMax
                 move $t4, $t5               # otherwise set a new min value = a[i]

               notMax:
                 add $t1, $t1, 1          # increment loop counter by 1
                 add $t2, $t2, 4          # increment the array pointer by 4 (bytes)
                 j WHILE2                  # start the loop again

      # K. Insert blank line for aesthetics
      ENDWHILE2:
              la $a0, endl       # load beginning address of display message into a0 register
              li $v0,4               # load call code to print a string
              syscall                # system call to start a new line

      #############################
      ##                         ##
      ##     Display Results     ##
      ##                         ##
      #############################

      # L. Display minimum number
      la $a0, min         # Display "The minimum number is "
      li $v0,4            # a0 = address of message
      syscall             # v0 = 4 which indicates display a string

      move $a0,$t3        # Display the minimum number
      li $v0,1
      syscall

      # M. Empty line for you know why
      la $a0, endl        # hint: aesthetics
      li $v0,4            # load call code to print a string
      syscall             # system call to start a new line

      la $a0, max         # Display "The maximum number is "
      li $v0,4            # a0 = address of message
      syscall             # v0 = 4 which indicates display a string

      # N. The REAL program is the friends we made along the way
      move $a0,$t4        # Display the maximum number
      li $v0,1
      syscall

      li $v0,10           # End Of Program
      syscall

.data
      arraysize:   .asciiz  "How big is your array? "      # Prompt user for array size
      prompt:      .asciiz  "Enter an integer: "          # Prompt for integers
      max:         .asciiz  "\nThe maximum number is "    # line showing max number
      min:         .asciiz  "\nThe minimum number is "    # line showing min number
      space:       .asciiz  "  "                          # Space to insert b/w numbers
      endl:        .asciiz  "\n"                          # Start new line


      array:       .word 60                               # every integer needs 4 bytes


      #############################
      ##                         ##
      ##     Sample Output       ##
      ##                         ##
      #############################

      # How big is your array? 7

      # Enter an integer: 3

      # Enter an integer: 2

      # Enter an integer: 6

      # Enter an integer: 4

      # Enter an integer: 5

      # Enter an integer: 7

      # Enter an integer: 1

      # 3  2  6  4  5  7  1

      # The minimum number is 1

      # The maximum number is 7
