################### PerryProg7.asm #####################
#                                                      #
#         Title:  Program 7                            #
#         Author: Neill Perry                          #
#         Date: April 7, 2020                          #
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
##  Print ASCII value of   ##
##       last byte         ##
##                         ##
#############################

li $t2, 0x44434241     # load the word into the t2 register

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 4 which indicates display a string

#############################
##                         ##
##   Rotate & Print Last   ##
##        Byte             ##
##                         ##
#############################

ror $t2, $t2, 8        # rotate the word in the t2 register by 8 bits to the right

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 4 which indicates display a string

#############################
##                         ##
##    Repeat Two More      ##
##        Times            ##
##                         ##
#############################

ror $t2, $t2, 8        # rotate the word in the t2 register by 8 bits to the right

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 4 which indicates display a string

ror $t2, $t2, 8        # rotate the word in the t2 register by 8 bits to the right

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 4 which indicates display a string

li $v0,10           # End Of Program
syscall

#############################
##                         ##
##     Sample Output       ##
##                         ##
#############################

# ABCD
