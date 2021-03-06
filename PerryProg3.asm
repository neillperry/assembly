########## PerryProg3.asm ##########

#         Title:  Program 3 - Odd or Even              #
#         Author: Neill Perry                          #
#         Date: Feb 18, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for one integers   #
#                      (2) determine if odd or even    #
#         Initial Algorithm:  division                 #
#         Data Requirements:                           #
#             Input variables: user inputs integer     #
#             Output variables: string "Odd" or "Even" #
#             Addition Variables: integer 2            #
#                                                      #
#         Formulas:  user integer / 2                  #

####################################



        .text
        .globl main
main:
        #############################
        ##                         ##
        ##     Get User Inputs     ##
        ##                         ##
        #############################

        # A. Prompt User to Enter an Integer
        la $a0, prompt        # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Please enter first integer:"

        #Get the INTEGER from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # Store the result from $v0 to $t0
        move $t0, $v0

        # Now that we have our integer, let's move on to the arithmetic!

        #############################
        ##                         ##
        ##      Calculations       ##
        ##                         ##
        #############################

        # Initialize values
        li $t1, 2     # initialize the divisor

        # Divide the integer by TWO
        div $t0,$t1   # Lo = $t0 / $t1   (Lo will contain the integer quotient)
                      # Hi = $t0 mod $t1   (Hi will contain the remainder)

        mfhi $t3      # move quantity in special register Hi to $t3:   $t3 = Hi
                      # we don't care about the quotient (Lo) value

        # Our computations are complete. Next, we will load it to the console

        #############################
        ##                         ##
        ##     Display Output      ##
        ##                         ##
        #############################

        # STEP 1 - Compare remainder to ZERO
        beqz $t3, ELSE        # IF remainder == 0 then Branch to ELSE (integer is EVEN)
        la $a0, odd           # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Integer is ODD" message
        j ENDIF               # done with IF so jump over ELSE code to ENDIF label

        # STEP 2 - Print the EVEN STATEMENT
        ELSE:
        la $a0, even          # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Integer is EVEN" message
        j ENDIF               # done with IF so jump over ELSE code to ENDIF label

        # STEP 3 - terminate If / else statement by printing blank line
        ENDIF:
        la $a0, endl          # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "\n"

        # STEP 4 - Thank the audience
        la $a0, ted           # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "\n"

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt: .asciiz "Please enter the integer: "         # Prompt for test integer
         odd:    .asciiz "\nThe integer you entered is ODD!"    # Prompt for second integer
         even:   .asciiz "\nThe integer you entered is EVEN!"   # Prompt for third integer
         endl:   .asciiz "\n"                                 # insert new line
         ted:    .asciiz "\nThank you for coming to my TED talk"       # Thank the audience

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################

         # Please enter the integer: -13

         # The integer you entered is ODD!

         # Thank you for coming to my TED talk
