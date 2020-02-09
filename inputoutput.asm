

########## Inputoutput.asm ##########

#         Title:  Lab 2 Input / Output                 #
#         Author: Neill Perry                          #
#         Date: Feb 4, 2020                            #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for two integers   #
#                      (2) display integers as formula #
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
        # REQUEST FIRST INTEGER
        la $a0, prompt1  # Ask the user for first integer
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4, indicates display a string

        li $v0, 5   # v0 = 5, indicates await user input of integer
        syscall

        move $t0, $v0   # move first integer from v0 to t0

        # REQUEST SECOND INTEGER
        la $a0, prompt2  # Ask the user for second integer
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4, indicates display a string

        li $v0, 5   # v0 = 5, indicates await user input of integer
        syscall

        move $t1, $v0   # move second integer from v0 to t1


        # DISPLAY FIRST INTEGER
        li $v0, 1
        move $a0, $t0
        syscall

        # DISPLAY PLUS SIGN
        la $a0, str3   # Display the personalized greeting
        li $v0,4            # a0 = address of string
        syscall             # v0 = 4, indicates display a string

        # DISPLAY SECOND INTEGER
        li $v0, 1
        move $a0, $t1
        syscall

        # DISPLAY EQUALS SIGN AND QUESTION MARK
        la $a0, str4   # Display the personalized greeting
        li $v0,4            # a0 = address of string
        syscall             # v0 = 4, indicates display a string

        li $v0,10   # End Of Program
        syscall     # Call to system



        .data

prompt1:       .asciiz "Please provide the first integer:"
prompt2:       .asciiz "Please provide the second integer:"
str3:          .asciiz " + "
str4:          .asciiz " = ?"



######## Output #####################
#                                   #
#  <1st int> + <2nd int> = ?        #
#                                   #
#####################################
