.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error     
    li t1, 0             
    li t2, 0
loop_start:
    # TODO: Add your own implementation
    beq t2, a1, loop_end
    slli t3, t2, 2
    add t3, a0, t3 

    lw t4 0(t3)
    bgt t4, t1, bigger_zero
    sw t1 0(t3)
bigger_zero:
    addi t2, t2, 1
    j loop_start
loop_end:
    jr ra
error:
    li a0, 36          
    j exit          
