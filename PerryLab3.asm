########## PerryLab3.asm ##########

#         Title:  Lab 3 Convert F to Celsius           #
#         Author: Neill Perry                          #
#         Date: Feb 11, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: Convert Fahrenheit to Celsius   #
#         Initial Algorithm:  none                     #
#         Data Requirements:                           #
#             Input variables: user inputs integer     #
#             Output variables: converted integer      #
#             Addition Variables:                      #
#                                                      #
#         Formulas:  C = (F - 32) * 5/9                #

####################################


        .text
        .globl main
main:
        #Print out prompt
        la $a0,prompt        # load beginning address of string into $a0 register
        li $v0,4             # load call code to print a string into register $v0
        syscall              # system call to display "Enter temperature (Celsius):"

        #Get the temperature from User
        li $v0,6             # load call code to read a float from keyboard
        syscall              # system call to read float and store in $f0

        #Initialize float values for conversion
        li.s $f6, 32.0
        li.s $f8 5.0
        li.s $f10, 9.0

        #Convert Fahrenheit to Celsius
        sub.s $f2,$f0,$f6   # temperature - 32 and store -> f2
        mul.s $f2,$f2,$f8    # 5*(temperature - 32)
        div.s $f2,$f2,$f10    # 5*(temperature - 32) / 9

        #Display temperature - Part 1
        mov.s $f12,$f0       # move initial Fahrenheit temperature from f0 -> f12 for display
        li  $v0,2            # load call code to print a float
        syscall              # system call to display temperature

        #Display output message - Part 2
        la $a0, ans1         # load beginning address of display message into $a0 register
        li $v0,4             # load call code to print a string
        syscall              # system call to display " in Fahrenheit is "

        #Display temperature - Part 3
        mov.s $f12,$f2       # move Celsius temperature from f2 -> f12 for display
        li  $v0,2            # load call code to print a float
        syscall              # system call to display temperature

        #Display output message - Part 4
        la $a0, ans2         # load beginning address of display message into $a0 register
        li $v0,4             # load call code to print a string
        syscall              # system call to display " in Celsius"

        #Move to next line
        la $a0,endl          # display cr/lf
        li $v0,4             # load call code to print a string (new line is a string)
        syscall              # system call to move to next line

        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #Data Section
         .data
         prompt: .asciiz "Enter temperature (Fahrenheit): "       #Prompt for Fahrenheit temperature
         ans1:   .asciiz " in Fahrenheit is "                     #Output message
         ans2:   .asciiz " in Celsius"                            #Output message
         endl:   .asciiz "\n"                                     #New line character
