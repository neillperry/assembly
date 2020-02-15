########## PerryProg3.asm ##########

#         Title:  Program 3 - Odd or Even              #
#         Author: Neill Perry                          #
#         Date: Feb 18, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for one integers   #
#                      (2) determine if odd or even    #
#         Initial Algorithm:  division                 #
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
        div $t0,$t1   # Lo = $t5 / $t6   (Lo will contain the integer quotient)
                      # Hi = $t5 mod $t6   (Hi will contain the remainder)

        mfhi $t3      # move quantity in special register Hi to $t3:   $t3 = Hi
                      # we don't care about the quotient (Lo) value

        # Our computations are complete. Next, we will load it to the console

        #############################
        ##                         ##
        ##     Display Output      ##
        ##                         ##
        #############################

        # STEP 1 - Compare remained to ZERO
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
         odd:    .asciiz "The integer you entered is ODD!"    # Prompt for second integer
         even:   .asciiz "The integer you entered is EVEN!"   # Prompt for third integer
         endl:   .asciiz "\n"                                 # insert new line
         ted:    .asciiz "Thank you for coming to my TED talk"       # Thank the audience

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################

         # Please enter first integer: 45
         # Please enter second integer: 67
         # Please enter first integer: 9
         # Please enter second integer: 2
         # Please enter second integer: 7
         # (45 + 67) - (9 + 2) * 7 = 35
