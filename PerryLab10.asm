################### PerryLab10.asm #####################
#                                                      #
#         Title:  Lab 10 - Mask and Rotate             #
#         Author: Neill Perry                          #
#         Date: April 7, 2020                          #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) print last byte as ASCII    #
#                      (2) rotate and repeat           #
#                      (3) rotate & print 2 more bytes #
#         Initial Algorithm:  N/A                      #
#         Data Requirements:                           #
#             Input variables: none                    #
#             Output variables: 4 ASCII characters     #
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
syscall                # v0 = 11 which indicates display ASCII

#############################
##                         ##
##   Rotate & Print Last   ##
##        Byte             ##
##                         ##
#############################

ror $t2, $t2, 8        # rotate the word in the t2 register by 8 bits to the right

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 11 which indicates display the ASCII value

#############################
##                         ##
##    Repeat Two More      ##
##        Times            ##
##                         ##
#############################

ror $t2, $t2, 8        # rotate the word in the t2 register by 8 bits to the right

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 11 which indicates display the ASCII value

ror $t2, $t2, 8        # rotate the word in the t2 register by 8 bits to the right

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 11 which indicates display the ASCII value

li $v0,10           # End Of Program
syscall

#############################
##                         ##
##     Sample Output       ##
##                         ##
#############################

# ABCD
