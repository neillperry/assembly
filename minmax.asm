main:

        la $t0,array        # t0 = address of array

        lw $t1,count        # t1 = count, exit loop when it goes to 0

        lw $t2,($t0)        # t2 = min = a[0] (initialization)

        lw $t3,($t0)        # t3 = max = a[0] (initialization)

        add $t0,$t0,4       # move pointer ahead to next array element a[1]

        add $t1,$t1,-1      # decrement counter to keep in step with array

 loop:  lw $t4,($t0)       # t4 = next element in array

        bge $t4,$t2,notMin  # if array element is >= min goto notMin

        move $t2,$t4        # min = a[i]

        j notMax

notMin: ble $t4,$t3,notMax # if array element is <= max goto notMax

        move $t3,$t4        # max = a[i]

notMax: add $t1,$t1,-1      # t1 -- -> counter --

        add $t0,$t0,4       # increment counter to point to next word

        bnez $t1,loop

        la $a0,p1           # Display "The minimum number is "

        li $v0,4            # a0 = address of message

        syscall             # v0 = 4 which indicates display a string

        move $a0,$t2        # Display the minimum number

        li $v0,1

        syscall

        la $a0,p2           # Display "The maximum number is "

        li $v0,4            # a0 = address of message

        syscall             # v0 = 4 which indicates display a string

        move $a0,$t3        # Display the maximum number

        li $v0,1

        syscall

        la $a0,crlf         # Display "cr/lf"

        li $v0,4            # a0 = address of message

        syscall             # v0 = 4 which indicates display a string

        li $v0,10           # End Of Program

        syscall


.data


p1:     .asciiz "The minimum number is "

p2:     .asciiz "\nThe maximum number is "

crlf:   .asciiz "\n"
array: .word 3, 4, 2, 6, 12, 7, 18, 26, 2, 14, 19, 7, 8, 12, 13

count: .word 15
