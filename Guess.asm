section .data
	prompt db "Enter a number and guess", 0xa
	len equ $-prompt
	more db "no, your guess is bigger",0xa
	less db "no, number too small", 0xa
	correct db "Correct :3", 0xa
	number times 2 db 0
	retryask times 2 db 0
	ask db "Try again? 1 for yes, 0 to exit", 0xa
	askl equ $-ask
section .text
	global _start
_start:
game:
	mov rax, 1
	mov rdi, 1
	mov rsi, prompt
	mov rdx, len
	syscall
	mov rax, 0
	mov rdi, 0
	mov rsi, number
	mov rdx, 2
	syscall
	mov al, [number]
	sub al, '0'
	cmp al, 5
	je success
	jl fail2
	jmp fail
success:
	mov rax, 1
	mov rdi, 1
	mov rsi, correct
	mov rdx, 10
	syscall
	jmp retry
fail:
	mov rax, 1
	mov rdi, 1
	mov rsi, more
	mov rdx, 20
	syscall
	jmp retry
fail2:
	mov rax, 1
	mov rdi, 1
	mov rsi, less
	mov rdx, 21
	syscall
	jmp retry
retry:
	mov rax, 1
	mov rdi, 1
	mov rsi, ask
	mov rdx, askl
	syscall
	mov rax, 0
	mov rdi, 0
	mov rsi, retryask
	mov rdx, 2
	syscall
	mov al, [retryask]
	sub al, '0'
	cmp al, 1
	je game
	cmp al, 0
	je exit
	jmp retry
exit:
	mov rax, 60
	mov rdi, 0
	syscall
