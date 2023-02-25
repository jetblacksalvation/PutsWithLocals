includelib kernel32.lib	
includelib msvcrt.lib

.data	

.code
externdef	GetStdHandle:proto	
externdef	WriteConsoleA :proto	

stringAddrs	equ	<rbp-8>

stdout equ <rbp-16>
	puts	proc
	push rbp	
	mov rbp, rsp
<<<<<<< HEAD
	sub rsp, 40
	mov rcx,offset string
	mov stringAddrs,rcx	;convenient local variable addressing 
	; for element in string addrs inc stringLength if not 0
	xor rcx,rcx
	LoopStart:
	cmp dword ptr[stringAddrs + rcx], 0
	jz LoopEnd
	inc rcx
=======
	sub rsp, 70h
	;double address
	mov qword ptr [stringAddrs], rcx	
	mov rdx, qword ptr [stringAddrs]
>>>>>>> fbf93af (Update main.asm)

	mov bl, byte ptr [rdx]
	mov rcx, -11
	call GetStdHandle
	; rax now has handle to stdout move that to stdout
	mov qword ptr [stdout], rax
	xor r8,r8
	;Looping until terminating character
	LabelStart:
	; use r8 to count
	cmp	 byte ptr[rdx+r8], 0
	jz LabelEnd
	inc r8
	jmp LabelStart
	LabelEnd:
	;write to console
	mov rcx, qword ptr[stdout]
	call WriteConsoleA

	mov rsp,rbp	;rsp is non-volitie, make sure to restore it 
	pop rbp	
	ret	
	puts endp	

	string db "amongus",10,0

	main proc	
	sub rsp, 70h
	mov rcx, offset string
	call puts	
	add rsp,70h

	ret	
	main endp	


	end
