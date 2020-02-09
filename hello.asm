

########## Hello.asm ##########

#         Title:  Lab 1 Hello                                #
#         Author: Neill Perry                                #
#         Date: Feb 4, 2020                                  #
#         Course & Section: CSC 211 / 301W                   #
#         Description: (1) ask user their name,              #
#                      (2) deliver greeting                  #
#         Initial Algorithm:                                 #
#         Data Requirements:                                 #
#             Input variables:  user's name                  #
#             Output variables: personalized greeting        #
#             Addition Variables:                            #
#                                                            #
#         Formulas:                                          #

####################################



        .text

        .globl main

main:
        la $a0, str1  # Ask the initial question of user name
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4, indicates display a string


        li $v0, 8   # v0 = 8, indicates await user input
        la $a0, user_input
        li $a1, 20        # set 20 character limit on user input
        syscall


        la $a0, str2  # Display the personalized greeting
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4, indicates display a string

        la $a0, user_input   # Display the personalized greeting
        li $v0,4            # a0 = address of string
        syscall             # v0 = 4, indicates display a string

        la $a0, str3  # Display the personalized greeting
        li $v0,4    # a0 = address of string
        syscall     # v0 = 4, indicates display a string

        li $v0,10   # End Of Program
        syscall     # Call to system



        .data

str1:       .asciiz "What is your name?\n"
str2:       .asciiz "Hello "
str3:       .asciiz "Welcome to CSC 211!"
user_input:
   .word 4




######## Output #####################

#                                   #

# Hello <Name>                      #

# Welcome to CSC 211!               #

#                                   #

#####################################
