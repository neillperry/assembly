################### PerryProg7.asm #####################
#                                                      #
#         Title:  Program 7                            #
#         Author: Neill Perry                          #
#         Date: April 7, 2020                          #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) print last byte as ASCII    #
#                      (3) rotate & print 3 more bytes #
#         Initial Algorithm:  rotation                 #
#         Data Requirements:                           #
#             Input variables: N/A                     #
#             Output variables: 4 string characters    #
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

li $t2, 0x65747942     # load the word into the t2 register

andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
li $v0,11              # print the string loaded in a0
syscall                # v0 = 11 which indicates display the ASCII value

#############################
##                         ##
##      Loop 3x Times      ##
##                         ##
#############################

li $t0, 0              # loop counter

WHILE:
  bgt $t0,2,END        # is t0 > 3, if so go to END
  ror $t2, $t2, 8        # rotate the word in the t2 register by 8 bits to the right

  andi $a0, $t2, 0xff    # grab the last eight bits of the word and place it in the a0 register
  li $v0,11              # print the string loaded in a0
  syscall                # v0 = 11 which indicates display ASCII equivalent

  add $t0, $t0, 1        # increment loop counter by 1
  j WHILE                # "With doubt the vicious circle turns and burns"

END:
    li $v0,10           # "Desire is hunger is the fire I breathe"
    syscall             # "Love is a banquet on which we feed"


#############################
##                         ##
##     Sample Output       ##
##                         ##
#############################

# Byte
