########## PerryMinMaxIndex.asm ##########
#
#         Title:  Lab 9 - Index Addressed Arrays       #
#         Author: Neill Perry                          #
#         Date: March 10, 2020                         #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) create 10 word array        #
#                      (2) user enters 10 integers     #
#                      (3) traverse array              #
#                      (4) display array elements      #
#                      (5) calculate min / max         #
#                      (6) display min / max           #
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
##   Get 10 User Integers  ##
##                         ##
#############################

# A. Initialize array values
li $t0, 0        # initialize array index value to 0
li $t1, 10        # size of array is 10 (0 - 9)
li $t3, 0        # initialize counter to zero

# B. Populate the array with 10 integers from user
while:
    la $a0, prompt          #prompt for integer
    li $v0,4                #a0 = address of string
    syscall                 #v0 = 4, indicates display a String

    li $v0,5                # enter input -> v0
    syscall                 # 5 is sys call for read int

    move $t2, $v0           # store word int to a[i]
    sw $t2, array($t0)

    add $t0,$t0,4           # move pointer ahead to next array element
    add $t3,$t3,1           # increment counter

    blt $t3,$t1,while       # branch to while if counter < size of array

    # End While to populate the array

# C. This is a new one for me. Had to look up what wend was.
 wend:
   la $a0, endl        # load beginning address of display message into a0 register
   li $v0,4            # load call code to print a string
   syscall             # system call to start a new line

# Now that we have our integer array, let's find min and max!!

#############################
##                         ##
##     Print Array &       ##
##     Find Min / Max      ##
##                         ##
#############################

# D. Print title card for array elements
la $a0,title      # Display "Array: "
li $v0,4          # a0 = address of message
syscall

# E. Reset array values for another while loop
li $t0, 0         # initialize array index value back to 0
li $t3, 0         # initial size counter back to zero

# F. Initialize min / max values
lw $t5, array($t0)        # t3 = min = a[0] (initialization)
lw $t4, array($t0)        # t4 = max = a[0] (initialization)

# G. Second WHILE Loop - print each element and check against min / max
   startPrint:
      # 1. Print the integer element
       lw $t2,array($t0)          # load word a[i] into temp (t2)
       move $a0, $t2              # move a[i] to a0 for display
       li $v0,1                   # display a[i]
       syscall

       # 2. Add a space for the feeble humans
       la $a0,space               # Display " "
       li $v0,4                   # a0 = address of message
       syscall                    # v0 = 4 which indicates display a string

       # 3. CHECK MIN / MAX VALUES
       bge $t2, $t5, notMin   # if array element >= current Min (t3) goto notMin
           move $t5, $t2      # otherwise set a new min value = a[i]
           j notMax

         notMin: ble $t2,$t4,notMax  # if array element <= current Max (t4) goto notMax
           move $t4, $t2               # otherwise set a new min value = a[i]

         notMax:
           add $t0,$t0,4              # move pointer ahead to next array element
           add $t3, $t3, 1            #increment counter

       # 4. start loop again. maybe. lemme check something first.
       blt $t3,$t1,startPrint     # branch to startPrint if counter < size of array

endPrint:     # if you delete this, the program breaks. 

# H. Insert blank line for aesthetics
la $a0, endl       # load beginning address of display message into a0 register
li $v0,4               # load call code to print a string
syscall                # system call to start a new line

#############################
##                         ##
##     Display Results     ##
##                         ##
#############################

# I. Display minimum number
la $a0, min         # Display "The minimum number is "
li $v0,4            # a0 = address of message
syscall             # v0 = 4 which indicates display a string

move $a0,$t5        # Display the minimum number
li $v0,1
syscall

# J. Empty line for you know why
la $a0, endl        # hint: aesthetics
li $v0,4            # load call code to print a string
syscall             # system call to start a new line

la $a0, max         # Display "The maximum number is "
li $v0,4            # a0 = address of message
syscall             # v0 = 4 which indicates display a string

# K. The REAL program is the friends we made along the way
move $a0,$t4        # Display the maximum number
li $v0,1
syscall

li $v0,10           # End Of Program
syscall

.data
prompt:      .asciiz  "Enter an integer: "          # Prompt for integers
title:       .asciiz  "Array: "                     # Array title
max:         .asciiz  "\nThe maximum number is "    # line showing max number
min:         .asciiz  "\nThe minimum number is "    # line showing min number
space:       .asciiz  "  "                          # Space to insert b/w numbers
endl:        .asciiz  "\n"                          # Start new line

array:       .word 40                               # every integer needs 4 bytes


#############################
##                         ##
##     Sample Output       ##
##                         ##
#############################

# Enter an integer: 23
# Enter an integer: 7
# Enter an integer: 2
# Enter an integer: -1
# Enter an integer: 9
# Enter an integer: 3
# Enter an integer: -8
# Enter an integer: 23
# Enter an integer: 17
# Enter an integer: 33

# Array: 23  7  2  -1  9  3  -8  23  17  33

# The minimum number is -8

# The maximum number is 33
