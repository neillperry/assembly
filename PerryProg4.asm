########## PerryProg4.asm ##########

#         Title:  Program 4 - Counting                 #
#         Author: Neill Perry                          #
#         Date: Feb 25, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for one integer    #
#                      (2) count up to that integer    #
#         Initial Algorithm:  While Loop               #
#         Data Requirements:                           #
#             Input variables: user inputs integer     #
#             Output variables: series of integers     #
#                                                      #
#         Formulas:  none                              #

####################################

        .text
        .globl main
main:
        #############################
        ##                         ##
        ##     Get User Input      ##
        ##                         ##
        #############################

        # 1. Prompt User to Enter an Integer
        la $a0, prompt        # load beginning address of string into $a0 register
        li $v0,4              # load instruction (li) to print the string loaded into register $v0
        syscall               # system call to display "Please enter first integer:"

        # 2. Get the INTEGER from User
        li $v0, 5             # load instruction to read an integer from keyboard
        syscall               # system call to read integer and store in $f0

        # 3. Store the result from $v0 to $t0
        move $t0, $v0

        # Now that we have our integer, let's move on to the counting!

        #############################
        ##                         ##
        ##      Calculations       ##
        ##                         ##
        #############################

        # 1. Initialize the constants
        li $t1, 1             # initialize the counter (t1)
        li $t2, 10            # initialize the divisor (t2)

        # 2. Create a huge While loop (the outer loop)
        WHILE:
              bgt $t1, $t0, ENDWHILE   # if integer (t0) is greater than counter (t1), execute a loop

              # A. Display current number
              move $a0, $t1            # move counter from t1 --> a0 register
              li $v0,1                 # load call code to print the integer
              syscall                  # system call to print the integer

              ## NEW LINE EVERY TEN COUNTS - nested inner loop

                  # STEP 1 - Divide the counter by TEN
                  div $t1,$t2   # Lo = $t1 / $t2     (Lo will contain the integer quotient)
                                # Hi = $t1 mod $t2   (Hi will contain the remainder)

                  mfhi $t3      # move the remainder in special register Hi to $t3:   $t3 = Hi
                                # we don't care about the quotient (Lo value)

                  # STEP 2 - If remainder does not equals ZERO, print a " "
                  beqz $t3, ELSE        # IF remainder != 0 then print a space after number
                  la $a0, space         # load beginning address of string into $a0 register
                  li $v0,4              # load instruction (li) to print the string loaded into register $v0
                  syscall               # system call to display " "
                  j ENDIF               # done with IF so jump over ELSE code to ENDIF label

                  # STEP 3 - if remainder does equal ZERO, start a new line
                  ELSE:                 # ELSE executes only when counter is divisible by 10
                  la $a0, endl          # load beginning address of string into $a0 register
                  li $v0,4              # load instruction (li) to print the string loaded into register $v0
                  syscall               # system call to start a new line
                  j ENDIF               # done with ELSE code now move to ENDIF label

                  # STEP 4 - terminate IF statement, augmenting the counter, restart WHILE loop
                  ENDIF:
                  add $t1, $t1, 1          # increment the counter
                  j WHILE                  # start the WHILE loop again

        # 3. Terminate the outer WHILE loop
        ENDWHILE: la $a0, endl        # load beginning address of display message into a0 register
              li $v0,4                # load call code to print a string
              syscall                 # system call to start a new line


        # We are done counting!!

        # Terminate Program
        li $v0,10            # load call code to End Program
        syscall              # system call to end program

        #DATA SECTION
.data
         prompt: .asciiz "Please enter an integer greater than 0: "         # Prompt for test integer
         endl:   .asciiz "\n"                                                # insert new line
         space:   .asciiz " "                                                # insert a space

         #############################
         ##                         ##
         ##     Sample Output       ##
         ##                         ##
         #############################

         # Please enter an integer greater than 0: 184
         # 1 2 3 4 5 6 7 8 9 10
         # 11 12 13 14 15 16 17 18 19 20
         # 21 22 23 24 25 26 27 28 29 30
         # 31 32 33 34 35 36 37 38 39 40
         # 41 42 43 44 45 46 47 48 49 50
         # 51 52 53 54 55 56 57 58 59 60
         # 61 62 63 64 65 66 67 68 69 70
         # 71 72 73 74 75 76 77 78 79 80
         # 81 82 83 84 85 86 87 88 89 90
         # 91 92 93 94 95 96 97 98 99 100
         # 101 102 103 104 105 106 107 108 109 110
         # 111 112 113 114 115 116 117 118 119 120
         # 121 122 123 124 125 126 127 128 129 130
         # 131 132 133 134 135 136 137 138 139 140
         # 141 142 143 144 145 146 147 148 149 150
         # 151 152 153 154 155 156 157 158 159 160
         # 161 162 163 164 165 166 167 168 169 170
         # 171 172 173 174 175 176 177 178 179 180
         # 181 182 183 184
