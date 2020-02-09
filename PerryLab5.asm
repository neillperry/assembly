########## PerryLab5.asm ##########

#         Title:  Lab 5 - Sales Tax                    #
#         Author: Neill Perry                          #
#         Date: Feb 11, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for price          #
#                      (2) display tax & total cost    #
#         Initial Algorithm:  none                     #
#         Data Requirements:                           #
#             Input variables: user inputs integer     #
#             Output variables: integers               #
#             Addition Variables:                      #
#                                                      #
#         Formulas:    Item Cost * 0.08 = tax          #
                      Item Cost * 1.08 = total cost    #

####################################



        .text
        .globl main
main:
        #Prompt User to Enter Cost of the Item
        la $a0, prompt1       # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Please enter the cost of the item: "

        #Get the cost from User
        li $v0,6             # load call code to read a float from keyboard
        syscall              # system call to read float and store in $f0

        #Initialize float values for tax calculation
        li.s $f6, 0.08
        li.s $f8 1.08

        # Multiplication - this is where the magic happens
        mul.s $f2,$f0,$f6    # user_input * 0.08

        #Display sales tax string
        la $a0, salestax       # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "The sales tax for this item will be: "

        #Display calculated tax
        mov.s $f12,$f2       # move calculated tax from f2 -> f12 for display
        li  $v0,2            # load call code to print a float
        syscall              # system call to display temperature

        #Start new line in terminal
        la $a0, endl           # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "\n"

        # Multiplication - this is where the magic happens THE SEQUEL!
        mul.s $f2,$f0,$f8    # user_input * 1.08

        #Display Total Cost string
        la $a0, cost           # load beginning address of display message into $a0 register
        li $v0,4               # load call code to print a string
        syscall                # system call to display "The total cost of this item will be:   "

        #Display calculated tax
        mov.s $f12,$f2       # move calculated cost from f2 -> f12 for display
        li  $v0,2            # load call code to print a float
        syscall              # system call to display temperature

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt1: .asciiz "Please enter the cost of the item: "               #Prompt for item cost
         salestax: .asciiz "The sales tax for this item will be: "            #Prompt for second integer
         cost:    .asciiz "The total cost of this item will be:   "           #Display total cost
         endl:   .asciiz "\n"                                                 #New line character
