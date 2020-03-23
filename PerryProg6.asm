################### PerryProg6.asm #####################
#                                                      #
#         Title:  Program 6 - Bubble Sort              #
#         Author: Neill Perry                          #
#         Date: March 31, 2020                         #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user # of integers      #
#                      (2) ask for integers for array  #
#                      (3) sort the array              #
#                      (4) display array               #
#         Initial Algorithm:  bubble sort              #
#         Data Requirements:                           #
#             Input variables: user's integer array    #
#             Output variables: sorted array           #
#                                                      #
########################################################

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

        # 2. Insert a new line for aesthetics
        la $a0, endl     # load beginning address of display message into a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to start a new line

        # 3. Prompt User to Enter an integer
        la $a0, prompt        # load address of prompt into a0
        li $v0,4              # load instruction number to display a string into v0
        syscall               # v0 = 4, indicates display a string

        # 4. Get the integer from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # 5. Store the result from $v0 to array and increment pointer and counter
        sw $v0, array($t2)
        add $t1, $t1, 1       # increment loop counter by 1
        add $t2, $t2, 4       # increment the array pointer by 4 (bytes)

        j WHILE             # start the loop again

      # G. Insert blank line for aesthetics
      ENDWHILE:
        la $a0, endl        # load beginning address of display message into a0 register
        li $v0,4            # load call code to print a string
        syscall             # system call to start a new line

      # Now that we have our integer array, let's sort these bubbles!!

      #############################
      ##                         ##
      ##       Bubble Sort       ##
      ##                         ##
      #############################

      # H. Reset array pointer and counter
      li $t1, 0            # initialize the OUTER counter (t1) to index of 0
      la $t2, array        # t2 = address of array[0]

      # I. OUTER LOOP - i
      WHILE2:                            # For i=0, i < Array Size (t0)
             bge, $t1, $t0, ENDWHILE2    # loop over array until OUTER counter is greater than array size

             # Initialize the inner loop values
             li $t3, 1             # initialize the INNER counter to index of 1
             add $t4, $t2, 4       # SET (or RESET) the j memory pointer to that of array[1]

             # INNER LOOP - start every inner loop at second array element
             WHILE3:
                bge, $t3, $t0, ENDWHILE3   # go until INNER gets to the end of the array
                                           # with each iteration, INNER goes over a smaller and smaller portion of array
                                           # but each iteration will always start at beginning of array

                # 1. Load array[j] and array[j-1] into temporary variables
                lw $t6, ($t4)               # store the actual value of array[j] at t6
                sub $t4, $t4, 4             # subtract 4 to the j array pointer to get memory address of j-1
                lw $t5, ($t4)               # store the actual value of array[j-1] at t5

                # 2. MAGIC HAPPENS HERE!!!
                bge, $t6, $t5, noSwap   # if array[j] > array[j-1] then no swap b/c those two are in ASC order already
                                        # OTHERWISE -->
                sw $t6, ($t4)           # WRITE array[j] temp value to array at location for j-1
                add $t4, $t4, 4         # INCREMENT memory pointer by 4 to get to j
                sw $t5, ($t4)           # WRITE array[j-1] temp value to array at location for j
                sub $t4, $t4, 4         # SUBTRACT memory by 4 to get back to where we were before this detour

                 # 6. Increment the INNER counter and the memory pointer
                 noSwap:
                 add $t3, $t3, 1             # increment the INNER counter by 1
                 add $t4, $t4, 8             # increment the INNER memory counter by 8 to get to j+1
                 j WHILE3

             ENDWHILE3:
              add $t1, $t1, 1        # increment OUTER loop counter by 1
              j WHILE2               # start the OUTER loop again

      # K. Insert blank line for aesthetics
      ENDWHILE2:
              la $a0, endl       # load beginning address of display message into a0 register
              li $v0,4               # load call code to print a string
              syscall                # system call to start a new line

      #############################
      ##                         ##
      ##     Display Array       ##
      ##                         ##
      #############################

      # H. Reset array pointer and counter
      li $t1, 0            # initialize the counter (t1) to 0
      la $t2, array        # t2 = address of array

      # I. Iterate over the array, printing as you go
      WHILE4:
             bge, $t1, $t0, ENDWHILE4    # loop over array until counter is greater than user set array size
             lw $t5, ($t2)               # get a byte from the array

             # 1. Print an Array Element
             move $a0, $t5          # move counter from t6 --> a0 register
             li $v0,1               # load call code to print the integer
             syscall                # system call to print the integer

             # 2. Print a Space
             la $a0, space          # load beginning address of display message into a0 register
             li $v0,4               # load call code to print a string
             syscall                # system call to insert a space

             add $t1, $t1, 1        # increment loop counter by 1
             add $t2, $t2, 4        # increment the array pointer by 4 (bytes)
             j WHILE4               # start the loop again

      # J. Terminate the Program
      ENDWHILE4:
            li $v0,10           # End Of Program
            syscall

.data
      arraysize:   .asciiz  "How big is your array? "      # Prompt user for array size
      prompt:      .asciiz  "Enter an integer: "          # Prompt for integers
      space:       .asciiz  "  "                          # Space to insert b/w numbers
      endl:        .asciiz  "\n"                          # Start new line

      array:       .word 60                               # every integer needs 4 bytes


      #############################
      ##                         ##
      ##     Sample Output       ##
      ##                         ##
      #############################

      # How big is your array? 14


      # Enter an integer: 46

      # Enter an integer: 23

      # Enter an integer: 0

      # Enter an integer: 17

      # Enter an integer: -12

      # Enter an integer: -13

      # Enter an integer: 35

      # Enter an integer: 13

      # Enter an integer: -5

      # Enter an integer: 8

      # Enter an integer: 29

      # Enter an integer: 11

      # Enter an integer: -11

      # Enter an integer: 26


      # -13  -12  -11  -5  0  8  11  13  17  23  26  29  35  46
