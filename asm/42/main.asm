section .text
	global main
main:
	mov eax, 1
	mov ebx, 42
	int 0x80
