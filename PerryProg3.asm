########## PerryProg3.asm ##########

#         Title:  Program 3 - Odd or Even              #
#         Author: Neill Perry                          #
#         Date: Feb 18, 2020                            #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for five integers   #
#                      (2) display integers as formula #
#         Initial Algorithm:  none                     #
#         Data Requirements:                           #
#             Input variables: user inputs integers    #
#             Output variables: series of strings      #
#             Addition Variables:                      #
#                                                      #
#         Formulas: (a + b) - (c + d) * e              #

####################################



        .text
        .globl main
main:
        #############################
        ##                         ##
        ##     Get User Inputs     ##
        ##                         ##
        #############################

        # A. Prompt User to Enter FIRST Integer
        la $a0, prompt1       # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Please enter first integer:"

        #Get the FIRST integer from User - a
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # Store the result from $v0 to $t0
        move $t0, $v0

        # B. Prompt User to Enter SECOND Integer - b
        la $a0, prompt2        # load beginning address of string into $a0 register
        li $v0,4               # load instruction (li) to print the string loaded into register $v0
        syscall                # system call to display "Please enter first integer:"

        #Get the SECOND integer from User
        li $v0, 5              # load instruction to read an integer from keyboard
        syscall                # system call to read integer and store in $f0

        # Store the result from $v0 to $t1
        move $t1, $v0

        # C. Prompt User to Enter THIRD Integer - c
        la $a0, prompt1       # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Please enter third integer:"

        #Get the THIRD integer from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # Store the result from $v0 to $t2
        move $t2, $v0

        # D. Prompt User to Enter FOURTH Integer - d
        la $a0, prompt2        # load beginning address of string into $a0 register
        li $v0,4               # load instruction (li) to print the string loaded into register $v0
        syscall                # system call to display "Please enter fourth integer:"

        #Get the FOURTH integer from User
        li $v0, 5              # load instruction to read an integer from keyboard
        syscall                # system call to read integer and store in $f0

        # Store the result from $v0 to $t3
        move $t3, $v0

        # E. Prompt User to Enter FIFTH Integer - e
        la $a0, prompt2        # load beginning address of string into $a0 register
        li $v0,4               # load instruction (li) to print the string loaded into register $v0
        syscall                # system call to display "Please enter fifth integer:"

        #Get the FIFTH integer from User
        li $v0, 5              # load instruction to read an integer from keyboard
        syscall                # system call to read integer and store in $f0

        # Store the result from $v0 to $t4
        move $t4, $v0

        # Now that we have our five integers, let's move on to the arithmetic

        #############################
        ##                         ##
        ##      Calculations       ##
        ##                         ##
        #############################

        # Add first and second integers (a + b)
        add $t5, $t0, $t1       # let's add these integers!!

        # Add third and fourth integers (c + d)
        add $t6, $t2, $t3       # let's add more integers!!

        # multiply the sum above times e
        mul $t6, $t6, $t4       # (c + d) * e

        # subtract the above result from the sum of (a + b)
        sub $t5, $t5, $t6       # this is the result of the entire equation

        # Our computations are complete. Next, we will load it to the console

        #############################
        ##                         ##
        ##     Display Output      ##
        ##                         ##
        #############################

        #Display output message - Part 1
        la $a0, open           # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "("

        #Display output message - Part 2
        move $a0, $t0           # load address of first integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display first integer

        #Display output message - Part 3
        la $a0, plus           # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display " + "

        #Display output message - Part 4
        move $a0, $t1           # load address of second integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display second integer

        #Display output message - Part 5
        la $a0, close          # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display ")"

        #Display output message - Part 5
        la $a0, minus          # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display " - "

        #Display output message - Part 6
        la $a0, open           # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "("

        #Display output message - Part 7
        move $a0, $t2           # load address of third integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display third integer

        #Display output message - Part 8
        la $a0, plus           # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display " + "

        #Display output message - Part 9
        move $a0, $t3           # load address of fourth integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display fourth integer

        #Display output message - Part 10
        la $a0, close          # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display ")"

        #Display output message - Part 11
        la $a0, multi          # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display " * "

        #Display output message - Part 12
        move $a0, $t4           # load address of fifth integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display fifth integer

        #Display output message - Part 13
        la $a0, equal          # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display " = "

        #Display output message - Part 14
        move $a0, $t5           # load address of calculated sum integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display the results of the equation

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt1: .asciiz "Please enter first integer: "       # Prompt for first integer
         prompt2: .asciiz "Please enter second integer: "      # Prompt for second integer
         prompt3: .asciiz "Please enter third integer: "       # Prompt for third integer
         prompt4: .asciiz "Please enter fourth integer: "      # Prompt for fourth integer
         prompt5: .asciiz "Please enter fifth integer: "       # Prompt for fifth integer
         open:    .asciiz "("                                  # open parenthesis sign
         close:   .asciiz ")"                                  # close parenthesis sign
         multi:   .asciiz " * "                                # multiplication sign
         plus:    .asciiz " + "                                # plus sign
         minus:   .asciiz " - "                                # minus sign
         equal:   .asciiz " = "                                # equal sign

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################

         # Please enter first integer: 45
         # Please enter second integer: 67
         # Please enter first integer: 9
         # Please enter second integer: 2
         # Please enter second integer: 7
         # (45 + 67) - (9 + 2) * 7 = 35
