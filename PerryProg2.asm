########## PerryProg2.asm ##########

#         Title:  Program 2                 #
#         Author: Neill Perry                          #
#         Date: Feb 18, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for three integers #
#                      (2) display largest integers    #
#         Initial Algorithm:  none                     #
#         Data Requirements:                           #
#             Input variables: user inputs integers    #
#             Output variables: series of strings      #
#             Addition Variables:                      #
#                                                      #
#         Formulas:                                    #

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


        #############################
        ##                         ##
        ##      Calculations       ##
        ##                         ##
        #############################

        blt $t0, $t1, ELSE       # IF t0 < t1 then Branch to ELSE
        move $a0,$t0             # IF t0 > t1 move t0 -> a0 for display as largest
        li $v0,1                 # load call code number to display integer into v0
        syscall                  # system call to print t0 as largest   
        j ENDIF                  # done with IF so jump over ELSE code to ENDIF label

        ELSE:
        blt $t1, $t2,
        move $a0,$t1      # ELSE t1 is largest so move t1 -> a0 for display
        li $v0,1                 # load call code number to display integer into v0
        syscall                  # system call to print t1 as largest


        #############################
        ##                         ##
        ##     Display Output      ##
        ##                         ##
        #############################

        #Display output message - Part 1
        la $a0, result         # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "And the largest of the three is: "

        #Display output message - Part 2
        move $a0, $t0           # load address of first integer into $a0 register
        li $v0, 1               # load instruction to print an integer (code 1 = integer)
        syscall                 # system call to display first integer


        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt1: .asciiz "Please enter first integer: "       # Prompt for first integer
         prompt2: .asciiz "Please enter second integer: "      # Prompt for second integer
         prompt3: .asciiz "Please enter third integer: "       # Prompt for third integer
         result:  .asciiz "And the largest of the three is: "   # Display largest integer

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################

         # Please enter first integer: 45
         # Please enter second integer: 67
         # Please enter first integer: 9
