########## PerryProg5.asm ##########

#         Title:  Program 5 - Counting Revisited       #
#         Author: Neill Perry                          #
#         Date: Mar 10, 2020                           #
#         Course & Section: CSC 211 / 301W             #
#         Description: (1) ask user for a string       #
#                      (2) count total characters      #
#                      (3) count total vowels          #
#                      (4) print both counts           #
#         Initial Algorithm:  While Loop               #
#         Data Requirements:                           #
#             Input variables: user inputs a string    #
#             Output variables: two integers           #
#                                                      #
#         Formulas:  none                              #

####################################

.text
.globl main
main:

#############################
##                         ##
##   Get a String from     ##
##        the User         ##
##                         ##
#############################

# A. Prompt User to Enter a String
la $a0, prompt        # load address of prompt into a0
li $v0,4              # load instruction number to display a string into v0
syscall               # v0 = 4, indicates display a string

# B. Store Said String in a variable called "string"
li $a1, 81            # set 81 character limit on string variable
la $a0, string        # get address of string variable
li $v0, 8             # read string from keyboard (v0 = 8, indicates await user input)
syscall

# Now that we have our string, let's move on to the counting!

#############################
##                         ##
##     The Counting        ##
##                         ##
#############################

# per lab requirements, need to count both total characters and number of vowels
# do not count the Enter the user inputs after the string

# C. Initialize pointer and counter(total) and counter(vowels)
li $t1,0             # t1 = array index
li $t2,0             # t2 = total character counter
li $t3,0             # t3 = vowel counter

# D. The Ugliest Loop You Will Ever See - check each character against {A, E, I, O, U, a, e, i, o, u}
loop:   lb $t0,string($t1)   # fetch next character
        beqz $t0,endLoop     # if its a null character, exit loop

        lb $t4,char_a         # t4 = character to be searched for
        bne $t0,$t4,nxt_e    # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_e:  lb $t4,char_e         # t4 = character to be searched for
        bne $t0,$t4,nxt_i    # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_i:  lb $t4,char_i         # t4 = character to be searched for
        bne $t0,$t4,nxt_o      # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_o:  lb $t4,char_o         # t4 = character to be searched for
        bne $t0,$t4,nxt_u      # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_u:  lb $t4,char_u         # t4 = character to be searched for
        bne $t0,$t4,nxt_A    # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_A:  lb $t4,char_A         # t4 = character to be searched for
        bne $t0,$t4,nxt_E    # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_E:  lb $t4,char_E         # t4 = character to be searched for
        bne $t0,$t4,nxt_I    # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_I:  lb $t4,char_I         # t4 = character to be searched for
        bne $t0,$t4,nxt_O    # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_O:  lb $t4,char_O         # t4 = character to be searched for
        bne $t0,$t4,nxt_U    # if != search character goto next vowel
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

nxt_U:  lb $t4,char_U        # t4 = character to be searched for
        bne $t0,$t4,con      # if != search character goto con
        add $t3,$t3,1        # if yes - add 1 to vowel counter
        j con

con:    add $t1,$t1,1        # add one to array index
        add $t2,$t2,1        # add one to total character counter
        j loop               # goto loop

# E. Take Back One Kadam to Honor the Hebrew God Whose Ark This is
endLoop: add $t2, $t2, -1

#############################
##                         ##
##     Display Results     ##
##                         ##
#############################

# F. Display result string
la $a0, result           # load beginning address of display message into a0 register
li $v0,4                 # load call code to print a strin
syscall                  # system call to display "String length is: "

# G. Display total character count
move $a0, $t2          # move counter from t2 --> a0 register
li $v0,1               # load call code to print the integer
syscall                # system call to print the integer

# H. Add a blank line
la $a0, endl          # load beginning address of display message into a0 register
li $v0,4              # load call code to print a string
syscall               # system call to display "\n"

# I. Display vowel count string
la $a0, vowels           # load beginning address of display message into a0 register
li $v0,4                 # load call code to print a string
syscall                  # system call to display "Number of vowels: "

# J. Display vowel count integer
move $a0, $t3          # move counter from t3 --> a0 register
li $v0,1               # load call code to print the integer
syscall                # system call to print the integer

# K. Terminate Program
li $v0,10            # load call code to End Program
syscall              # system call to end program


#############################
##                         ##
##          DATA           ##
##                         ##
#############################

.data
 prompt:      .asciiz  "\nPlease enter the string to be counted: "      # Prompt for string
 result:      .asciiz  "\nString length: "                           # Display count length
 vowels:      .asciiz  "\nNumber of vowels: "                           # Display number of vowels counted
 endl:        .asciiz  "\n"                                             # new line

 char_a:       .asciiz  "a"                                              # test things
 char_e:       .asciiz  "e"                                              # test things
 char_i:       .asciiz  "i"                                              # test things
 char_o:       .asciiz  "o"                                              # test things
 char_u:       .asciiz  "u"                                              # test things

 char_A:       .asciiz  "A"                                              # test things
 char_E:       .asciiz  "E"                                              # test things
 char_I:       .asciiz  "I"                                              # test things
 char_O:       .asciiz  "O"                                              # test things
 char_U:       .asciiz  "U"                                              # test things

 string:      .space 82                                                 # User input

 #############################
 ##                         ##
 ##     Sample Output       ##
 ##                         ##
 #############################

 # Please enter the string to be counted: We meet again dr jones

 # String length: 22

 # Number of vowels: 8
