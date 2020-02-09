########## PerryLab4.asm ##########

#         Title:  Lab 4 Adding Integers                #
#         Author: Neill Perry                          #
#         Date: Feb 11, 2020                            #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for two integers   #
#                      (2) add the two integers        #
#         Initial Algorithm:  none                     #
#         Data Requirements:                           #
#             Input variables: user inputs integers    #
#             Output variables: the sum of the integers     #
#             Addition Variables:                      #
#                                                      #
#         Formulas:  basic addition                    #

####################################



        .text
        .globl main
main:
        #Prompt User to Enter FIRST Integer
        la $a0, prompt1       # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Please enter first integer:"

        #Get the FIRST integer from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # Store the result from $v0 to $t0
        move $t0, $v0

        #Prompt User to Enter SECOND Integer
        la $a0, prompt2        # load beginning address of string into $a0 register
        li $v0,4               # load instruction (li) to print the string loaded into register $v0
        syscall                # system call to display "Please enter first integer:"

        #Get the SECOND integer from User
        li $v0, 5              # load instruction to read an integer from keyboard
        syscall                # system call to read integer and store in $f0

        # Store the result from $v0 to $t1
        move $t1, $v0

        # ADDITION - this is where the magic happens
        add $t2, $t0, $t1       # let's add these integers!!

        #Display output message - Part 1
        move $a0, $t0           # load address of first integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display first integer

        #Display output message - Part 2
        la $a0, plus           # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display " + "

        #Display output message - Part 3
        move $a0, $t1          # load address of second integer into $a0 register
        li $v0, 1              # load instruction to print an integer (code 1 = integer)
        syscall                # system call to display second integer

        #Display output message - Part 4
        la $a0, equal          # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display " = "

        #Display output message - Part 5
        move $a0, $t2          # load address of calculated sum into $a0 register
        li $v0, 1              # load instruction to print an integer (code 1 = integer)
        syscall                # system call to display second integer

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt1: .asciiz "Please enter first integer: "       #Prompt for first integer
         prompt2: .asciiz "Please enter second integer: "       #Prompt for second integer
         plus:    .asciiz " + "                                # plus sign
         equal:   .asciiz " = "                                # equal sign
