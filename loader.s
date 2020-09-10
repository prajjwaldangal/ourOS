KERNEL_STACK_SIZE equ 4096                  ; size of stack in bytes
    extern sum_of_three
    global loader                   ; the entry symbol for ELF

    MAGIC_NUMBER equ 0x1BADB002     ; define the magic number constant
    FLAGS        equ 0x0            ; multiboot flags
    CHECKSUM     equ -MAGIC_NUMBER  ; calculate the checksum
                                    ; (magic number + checksum + flags should equal 0)
    KERNEL_STACK_SIZE equ 4096      ; size of stack in bytes

    section .bss
    align 4                         ; align at 4 bytes
    kernel_stack:                   ; label points to beginning of memory
        resb KERNEL_STACK_SIZE      ; reserve stack for the kernel

    section .text:                  ; start of the text (code) section
    align 4                         ; the code must be 4 byte aligned
        dd MAGIC_NUMBER             ; write the magic number to the machine code,
        dd FLAGS                    ; the flags,
        dd CHECKSUM                 ; and the checksum

<<<<<<< HEAD
    loader:                         ; the loader label (defined as entry point in linker script)
        mov esp, kernel_stack + KERNEL_STACK_SIZE       ; point esp to the start of the
                                                                                        ;stack (end of memory area)
        ; The assembly code
        extern sum_of_three   ; the function sum_of_three is defined elsewhere
        push dword 3            ; arg3
        push dword 2            ; arg2
        push dword 1            ; arg1
        call sum_of_three       ; call the function, the result will be in eax

=======
    section .bss
    align 4                                     ; align at 4 bytes
    kernel_stack:                               ; label points to beginning of memory
        resb KERNEL_STACK_SIZE                  ; reserve stack for the kernel
    mov esp, kernel_stack + KERNEL_STACK_SIZE   ; point esp to the start of the
                                                ; stack (end of memory area)
    loader:
	mov esp, kernel_stack + KERNEL_STACK_SIZE       ; point esp to the start of the
 	mov eax, 0xCAFEBABE         ; place the number 0xCAFEBABE in the register eax
	push ebp ; Push stack
        mov     ebp, esp  ; initialize new call frame
	push dword 3		; arg3
	push dword 2            ; arg2
        push dword 1 
        ;mov eax,0
        call sum_of_three
        ;mov     esp, ebp
	;pop ebp
        ;mov eax, 0
	;mov [0x000B8000], word 0x4128
        ret
>>>>>>> 266c47a13ce752c32e1267b25ee9ed0ea07161d0
    .loop:
        jmp .loop                   ; loop forever
