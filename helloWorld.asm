

########## HelloWorld.asm ##########

#          Pamela McCarthy         #

####################################

 

        .text

        .globl main

main:

        la $a0,str  # Display the message below

        li $v0,4    # a0 = address of string

        syscall     # v0 = 4, indicates display a string

 

        li $v0,10   # End Of Program  

        syscall     # Call to system

 

        .data

str:    .asciiz "Hello World!\nI am finally learning SOMETHING!\nAnd it does WORK!\n"

 

######## Output #####################

#                                   #

# Hello World                       #

# I am finally learning SOMETHING!  #

# And it does WORK!                 #

#                                   #

#####################################

