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
      move $t0, $v0         # t0 will be the counter for the while loop below

      # Per lab instructions, no need to error check user input (assume it is between 1-15)

      #############################
      ##                         ##
      ##   Get n User Integers   ##
      ##                         ##
      #############################

      # B. Initialize array pointer
      li $t1, 0             # initialize the counter (t1) to 0
      li $t2, 0             # initialize the pointer (t2) to 0

      WHILE:

        # 1. WHILE pointer is less than array size n
        bgt, $t1, $t0, ENDWHILE

        # A. Prompt User to Enter an integer
        la $a0, prompt        # load address of prompt into a0
        li $v0,4              # load instruction number to display a string into v0
        syscall               # v0 = 4, indicates display a string

        # B. Get the integer from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # C. Store the result from $v0 to array and increment pointer and counter
        sw $v0, array($t2)
        add $t1, $t1, 1          # increment loop counter by 1
        add $t2, $t2, 4          # increment the array pointer by 4 (bytes)

        j WHILE                  # start the loop again

      ENDWHILE: la $a0, endl     # load beginning address of display message into a0 register
          li $v0,4               # load call code to print a string
          syscall                # system call to start a new line

      # Now that we have our integer array, let's find min and max!!

      #############################
      ##                         ##
      ##     Find Min / Max      ##
      ##                         ##
      #############################

      # Reset array pointer and counter
      li $t1, 0             # initialize the counter (t1) to 0
      li $t2, 0             # initialize the pointer (t2) to 0

      la $t0, array        # t0 = address of array
      lw $t1, $t0          # t1 = user-inputed array size, exit loop when it goes to 0

      # set initial values a[0] = min = max
      # lw means load word, loading a word from array (via t0) to t2 and t3
      lw $t2, ($t0)        # t2 = min = a[0] (initialization)
      lw $t3, ($t0)        # t3 = max = a[0] (initialization)

      # increment the pointer and counter to next element
      add $t0, $t0, 4       # move pointer ahead to next array element a[1]
      add $t1, $t1, -1      # decrement counter to keep in step with array

loop:  lw $t4,($t0)       # t4 = next element in array

      # Display Array Element (t4)
      move $a0, $t4          # move counter from t3 --> a0 register
      li $v0,1               # load call code to print the integer
      syscall                # system call to print the integer

      # Add a space after each Array Element
      la $a0, space          # load beginning address of display message into a0 register
      li $v0,4               # load call code to print a string
      syscall                # system call to start a new line

      # IF statement
      bge $t4,$t2,notMin      # if array element is >= min goto notMin
          move $t2, $t4       # otherwise set a new min value = a[i]
          j notMax

          notMin: ble $t4,$t3,notMax  # if array element is <= max goto notMax
            move $t3,$t4               # otherwise set a new max value = a[i]

          notMax: add $t1,$t1,-1      # t1 -- -> counter --
            add $t0,$t0,4         # increment counter to point to next word
            bnez $t1,loop         # if $t1 (counter) != 0, then restart another loop

      #############################
      ##                         ##
      ##     Display Results     ##
      ##                         ##
      #############################

      la $a0,min          # Display "The minimum number is "
      li $v0,4            # a0 = address of message
      syscall             # v0 = 4 which indicates display a string

      move $a0,$t2        # Display the minimum number
      li $v0,1
      syscall

      la $a0,max          # Display "The maximum number is "
      li $v0,4            # a0 = address of message
      syscall             # v0 = 4 which indicates display a string

      move $a0,$t3        # Display the maximum number
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


      array:       .word 80                               # every integer needs 4 bytes


################ Output #################

#                                       #

# The minum number is 2                 #

# The maximum is 26                     #

#                                       #

#########################################
