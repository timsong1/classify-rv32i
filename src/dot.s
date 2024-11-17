.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            #sum
    li t1, 0         

    addi sp, sp, -8
    sw s1, 0(sp) # s1 for arr0[i*stride0]
    sw s2, 4(sp) # s2 for arr1[i*stride1]

loop_start:
    bge t1, a2, loop_end
    
    li t3, 0
    li t4, 0
mul_loop_start1:    # calculate i * stride0
    beq t3, a3, mul_loop_end1
    add t4, t4, t1

    addi t3, t3, 1
    j mul_loop_start1
mul_loop_end1:
    slli t4, t4, 2
    add t4, t4, a0
    lw s1, 0(t4)    # s1 = arr0[i * stride0]

    li t3, 0
    li t4, 0
mul_loop_start2:    #calculate i * stride1
    beq t3, a4, mul_loop_end2
    add t4, t4, t1
    addi t3, t3, 1
    j mul_loop_start2
mul_loop_end2:
    slli t4, t4, 2
    add t4, t4, a1
    lw s2, 0(t4)    # s2 = arr1[i * stride1]

    li t3, 0
    li t4, 0
mul_loop_start3:    # s1 * s2
    beq t3, s2, mul_loop_end3
    add t4, t4, s1
    addi t3, t3, 1
    j mul_loop_start3
mul_loop_end3:      # t4 = s1 * s2
 
    add t0, t0, t4

    addi t1, t1, 1
    j loop_start
loop_end:
    mv a0, t0
    addi sp, sp, 8
    lw s1, 0(sp) 
    lw s2, 4(sp) 
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
