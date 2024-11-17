.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)

    li t1, 0           
    mv t6, t1
loop_start:
    beq t1, a1, loop_end 
    slli t3, t1, 2
    add t3, a0, t3
    lw t5 0(t3)

    bgt t0, t5, not_change
    mv t0, t5
    mv t6, t1
not_change:
    addi t1, t1, 1
    j loop_start
loop_end:
    mv a0, t6
    jr ra
handle_error:
    li a0, 36
    j exit
