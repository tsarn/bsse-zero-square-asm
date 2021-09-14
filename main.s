.intel_syntax noprefix

.global main

.bss
.align 4

array:      .zero 8     /* u8*    */
nelem:      .zero 8     /* size_t */
psumx:      .zero 8     /* int*   */
psumy:      .zero 8     /* int*   */
dp:         .zero 8     /* int*   */
i:          .zero 8     /* size_t */
j:          .zero 8     /* size_t */
k:          .zero 8     /* size_t */
width:      .zero 4     /* int    */
height:     .zero 4     /* int    */
H:          .zero 4     /* int    */
tmp:        .zero 4     /* int    */

.text

main:
    sub rsp, 8

/* read width and height */
    lea rdi, [rip + L0]
    lea rsi, [rip + width]
    lea rdx, [rip + height]
    xor eax, eax
    call scanf
    mov eax, [rip + height]
    inc eax
    mov [rip + H], eax

/* calculate nelem */
    mov eax, dword ptr [rip + width]
    inc eax
    mov edx, dword ptr [rip + H]
    mul edx
    mov [rip + nelem], rax

/* allocate memory for the array */
    mov edi, [rip + nelem]
    mov rsi, 1
    call calloc
    mov [rip + array], rax

/* allocate memory for the partial sum array */
    mov edi, [rip + nelem]
    mov rsi, 4
    call calloc
    mov [rip + psumx], rax

    mov edi, [rip + nelem]
    mov rsi, 4
    call calloc
    mov [rip + psumy], rax

/* allocate memory for the dp array */
    mov edi, [rip + nelem]
    mov rsi, 4
    call calloc
    mov [rip + dp], rax

/* read the array */
    mov qword ptr [rip + i], 0

/* main loop */
    mov qword ptr [rip + k], 0
    mov qword ptr [rip + i], 0

find_squares_loop_i:
    mov edx, [rip + width]
    mov rcx, [rip + i]
    cmp ecx, edx
    jz find_squares_loop_i_end

    mov qword ptr [rip + j], 0

find_squares_loop_j:
    mov edx, [rip + height]
    mov rcx, [rip + j]
    cmp ecx, edx
    jz find_squares_loop_j_end

    lea rdi, [rip + L1]
    lea rsi, [rip + tmp]
    xor eax, eax
    call scanf

    mov rdi, [rip + array]
    mov rsi, [rip + k]
    mov eax, [rip + tmp]
    mov [rdi + rsi], al

    mov rdi, [rip + psumx]
    mov eax, [rdi + rsi * 4]
    add eax, [rip + tmp]
    add esi, [rip + H]
    mov [rdi + rsi * 4], eax

    mov rsi, [rip + k]
    mov rdi, [rip + psumy]
    mov eax, [rdi + rsi * 4]
    add eax, [rip + tmp]
    inc rsi
    mov [rdi + rsi * 4], eax

    mov eax, [rip + tmp]
    cmp eax, 0
    jnz if_end

    xor eax, eax
    mov eax, dword ptr [rip + tmp]
find_squares_loop_tmp:
    mov rdi, [rip + dp]
    mov rsi, [rip + k]
    mov edx, [rdi + rsi * 4]
    inc rdx
    mov rcx, [rip + tmp]
    cmp rcx, rdx
    jz if_end

    mov eax, [rip + tmp]
    mov edx, [rip + H]
    mul edx
    mov rsi, [rip + k]
    sub esi, eax
    mov rdi, [rip + psumx]
    mov eax, [rdi + rsi * 4]
    mov rsi, [rip + k]
    mov edx, [rdi + rsi * 4]
    cmp eax, edx
    jnz if_end

    mov rdi, [rip + psumy]
    mov rsi, [rip + k]
    sub esi, [rip + tmp]
    mov eax, [rdi + rsi * 4]
    mov rsi, [rip + k]
    mov edx, [rdi + rsi * 4]
    cmp eax, edx
    jnz if_end

    mov rdi, [rip + dp]
    mov rsi, [rip + k]
    add esi, [rip + H]
    inc rsi
    mov eax, [rip + tmp]
    inc eax
    mov [rdi + rsi * 4], eax

    inc dword ptr [rip + tmp]
    jmp find_squares_loop_tmp

if_end:

    inc qword ptr [rip + j]
    inc qword ptr [rip + k]
    jmp find_squares_loop_j
find_squares_loop_j_end:

    inc qword ptr [rip + i]
    inc qword ptr [rip + k]
    jmp find_squares_loop_i
find_squares_loop_i_end:

/* output results */

    xor rax, rax
    mov eax, [rip + H]
    inc eax
    mov qword ptr [rip + k], rax
    mov qword ptr [rip + i], 0

output_loop_i:
    mov edx, [rip + width]
    mov rcx, [rip + i]
    cmp ecx, edx
    jz output_loop_i_end

    mov qword ptr [rip + j], 0

output_loop_j:
    mov edx, [rip + height]
    mov rcx, [rip + j]
    cmp ecx, edx
    jz output_loop_j_end

    mov rdi, [rip + dp]
    mov rsi, [rip + k]
    mov esi, [rdi + rsi * 4]
    lea rdi, [rip + L2]
    xor eax, eax
    call printf

    inc qword ptr [rip + j]
    inc qword ptr [rip + k]
    jmp output_loop_j
output_loop_j_end:

    inc qword ptr [rip + i]
    inc qword ptr [rip + k]
    lea rdi, [rip + L3]
    call puts
    jmp output_loop_i
output_loop_i_end:

    add rsp, 8
    mov rax, 0
    ret

L0: .asciz "%d%d"
L1: .asciz "%d"
L2: .asciz "%d "
L3: .asciz ""

/* vim: ft=gas : 
*/ 
