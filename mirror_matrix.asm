.data
MAT:    .word   1 2 3 4 5       6 7 8 9 10      11 12 13 14 15
ROW:    .word   3
COL:    .word   5



.text



.globl main

mirror_matrix:
        addi    $sp, $sp, -16           # allocate the stack (16 byte)
        sw      $s0, 0($sp)             # push $s0 in 0($sp)
        sw      $s1, 4($sp)             # push $s1 in 4($sp)
        sw      $s2, 8($sp)             # push $s1 in 8($sp)
        sw      $s3, 12($sp)            # push $s1 in 12($sp)
      
        
        add     $s0, $zero, $zero       # int i=0       (i=$s0)
        sll	$t0, $a2, 2		# $t0 = COL*4   (offset of one line)

loop1:  
        slt	$t1, $s0, $a1		# $t1 = (i < ROW) ? 1 : 0     (i=$s0) (ROW=$a1)
        beq	$t1, $zero, exit1	# if $t1 == $zero go to exit1


        add     $s1, $zero, $zero       # int j=0 (j=$s1)
        srl	$t1, $a2, 1		# $t1 = COL/2
        
loop2:        
        slt	$t2, $s1, $t1		# $t2 = (j < COL/2) ? 1 : 0       (j=$s1) (COL/2=$t1)
        beq	$t2, $zero, exit2	# if $t2 == $zero go to exit2        

        # temp = MAT[i][j]
        sll	$t2, $s1, 2		# $t2 = j*4
        add	$t2, $a0, $t2		# $t2 = &MAT[i][j]
        lw      $s2, 0($t2)             # temp = MAT[i][j]       ($s2 = temp)

        # MAT[i][j] = MAT[i][COL-j-1]
        sub     $t3, $a2, $s1		# $t3 = COL-j
        addi	$t3, $t3, -1		# $t3 = COL-j-1
        sll     $t3, $t3, 2             # $t3 = (COL-j-1)*4
        add	$t3, $a0, $t3		# $t3 = &MAT[i][COL-j-1]
        lw      $s3, 0($t3)             # $s3 = MAT[i][COL-j-1]
        sw      $s3, 0($t2)             # MAT[i][j] = MAT[i][COL-j-1]

        # MAT[i][COL-j-1] = temp
        sw      $s2, 0($t3)             # MAT[i][COL-j-1] = temp   ($s2 = temp)
        

        addi    $s1, $s1, 1             # j++
        j	loop2			# jump to loop2
        

exit2:
        add     $a0, $a0, $t0           # $a0 = &MAT[i+1][0]    ($t0 = COL*4   (offset of one line) )
        addi    $s0, $s0, 1             # i++
        j	loop1			# jump to loop1


exit1:   
        lw      $s0, 0($sp)             # pop $s0 from 0($sp)
        lw      $s1, 4($sp)             # pop $s1 from 4($sp)
        lw      $s2, 8($sp)             # pop $s2 from 8($sp)
        lw      $s3, 12($sp)            # pop $s3 from 12($sp)
        addi    $sp, $sp, 16            # deallocate the stack (16 byte)
        
        jr      $ra                     # return to the caller    
        

        
main:
        addi	$sp, $sp, -4            # allocate the stack (4 byte)
        sw	$ra, 0($sp)             # push $ra in 0($sp)
        

        la      $a0, MAT                # load matrix base address
        la      $t0, ROW                # load in $t0 ROW address
        lw      $a1, 0($t0)             # $a1 = ROW
        la      $t0, COL                # load in $t0 COL address
        lw      $a2, 0($t0)             # $a2 = COL


        jal     mirror_matrix           # call mirror(&A[0], ROW=3, COL=4)


        lw      $ra, 0($sp)             # pop $ra from 0($sp)
        addi    $sp, $sp, 4             # deallocate the stack (4 byte)
        jr      $ra                     # return to the main caller
