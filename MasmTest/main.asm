includelib	kernel32.lib
includelib	msvcrt.lib


.data
string db"hello world",0
.code
stringAddrs	equ	<[rbp-8]>

stringLength equ <[rbp-16]>
externdef	WriteConsoleA :proto		
externdef	GetStdHandle:proto	
	main proc
	push rbp	
	mov rbp, rsp
	sub rsp, 40
	lea rcx, string
	mov stringAddrs,rcx	;convenient local variable addressing 
	; for element in string addrs inc stringLength if not 0
	xor rcx,rcx
	LoopStart:
	cmp dword ptr[stringAddrs + rcx], 0
	jz LoopEnd
	inc rcx

	jmp LoopStart
	LoopEnd:
	mov stringLength, rcx
	mov rcx, -11
	call GetStdHandle
	mov rcx, rax; DWORD hStdOut = GetStdHandle(-11);
	lea rdx, stringAddrs
	mov r8, stringLength
	call WriteConsoleA


	mov rsp,rbp	;rsp is non-volitie, make sure to restore it 
	pop rbp	
	ret		
	main endp	
	end