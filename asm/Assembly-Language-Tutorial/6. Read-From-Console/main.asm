SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4

STDIN       equ 0
STDOUT      equ 1

%macro write_string 2
    mov eax, SYS_WRITE                      ;sys_write(
    mov ebx, STDOUT                         ;   1,          // int fd           = 1          - Standard output (stdout)
    mov ecx, %1                             ;   userMsg,    // const void *buf  = userMsg    - second param userMsg
    mov edx, %2                             ;   5           // size_t count     = lenUserMsg - string length
    int 80h                                 ;);             // make sys call
%endmacro

section .data                               ;Data segment
    userMsg db 'Please enter a number: '    ;Ask the user to enter a number
    lenUserMsg equ $-userMsg                ;The length of the message
    dispMsg db 'You have entered: '
    lenDispMsg equ $-dispMsg
section .bss                                ;Uninitialized data
    num resb 5                              ;Allocates the specified amount of memory in the data section of the executable
section .text                               ;Code Segment
    global main
main:
                                            ;User prompt
                                            ;ssize_t write(int fd, const void *buf, size_t count);
    mov eax, SYS_WRITE                      ;sys_write(
    mov ebx, STDOUT                         ;   1,          // int fd           = 1          - Standard output (stdout)
    mov ecx, userMsg                        ;   userMsg,    // const void *buf  = userMsg    - second param userMsg
    mov edx, lenUserMsg                     ;   5           // size_t count     = lenUserMsg - string length
    int 80h                                 ;);             // make sys call

                                            ;Read and store the user input
                                            ;ssize_t read(int fd, void *buf, size_t count);
    mov eax, SYS_READ                       ;read(
    mov ebx, 2                              ;   2, //
    mov ecx, num                            ;   5, //
    mov edx, 5                              ;   5, // 5 bytes (numeric, 1 for sign) of that information
    int 80h                                 ;);   // make sys call

                                            ;Output the message 'The entered number is: '
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, dispMsg
    mov edx, lenDispMsg
    int 80h

                                            ;Output the number entered
    write_string num, 5

                                            ;Exit code
    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h
