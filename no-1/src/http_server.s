log_close.part.0:
	movq	16+log_config(%rip), %rdi
	testq	%rdi, %rdi
	je	.L7
	subq	$8, %rsp
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
	addq	$8, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	ret
	.size	log_close.part.0, .-log_close.part.0
	.p2align 4
	.globl	send_404_error
	.type	send_404_error, @function
send_404_error:
	pushq	%rbp
	movl	%edi, %ebp
	pushq	%rbx
	subq	$8, %rsp
	movq	http_404_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	addq	$8, %rsp
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	movq	%rax, %rdx
	popq	%rbp
	jmp	write@PLT
	.size	send_404_error, .-send_404_error
	.p2align 4
	.globl	send_500_error
	.type	send_500_error, @function
send_500_error:
	pushq	%rbp
	movl	%edi, %ebp
	pushq	%rbx
	subq	$8, %rsp
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	addq	$8, %rsp
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	movq	%rax, %rdx
	popq	%rbp
	jmp	write@PLT
	.size	send_500_error, .-send_500_error
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"HTTP/1.1 400 Bad Request\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>400 Bad Request</h1></body></html>\r\n"
	.text
	.p2align 4
	.globl	send_400_error
	.type	send_400_error, @function
send_400_error:
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	jmp	write@PLT
	.size	send_400_error, .-send_400_error
	.p2align 4
	.globl	extract_path
	.type	extract_path, @function
extract_path:
	pushq	%rbx
	movq	%rdi, %rbx
	movl	$256, %edi
	call	malloc@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L16
	movzbl	(%rbx), %edx
	testb	$-33, %dl
	je	.L22
	cmpb	$63, %dl
	je	.L22
	movl	$1, %eax
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L39:
	cmpb	$63, %dl
	je	.L23
	addq	$1, %rax
	cmpq	$256, %rax
	je	.L38
.L21:
	movb	%dl, -1(%rcx,%rax)
	movzbl	(%rbx,%rax), %edx
	testb	$-33, %dl
	jne	.L39
.L23:
	cltq
	addq	%rcx, %rax
.L18:
	movb	$0, (%rax)
.L16:
	movq	%rcx, %rax
	popq	%rbx
	ret
.L38:
	leaq	255(%rcx), %rax
	jmp	.L18
.L22:
	movq	%rcx, %rax
	jmp	.L18
	.size	extract_path, .-extract_path
	.p2align 4
	.globl	parse_port
	.type	parse_port, @function
parse_port:
	subq	$8, %rsp
	movl	$10, %edx
	xorl	%esi, %esi
	call	__isoc23_strtol@PLT
	leal	-1024(%rax), %edx
	cmpl	$64512, %edx
	movl	$0, %edx
	cmovnb	%rdx, %rax
	addq	$8, %rsp
	ret
	.size	parse_port, .-parse_port
	.p2align 4
	.globl	log_close
	.type	log_close, @function
log_close:
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L49
	movq	16+log_config(%rip), %rdi
	testq	%rdi, %rdi
	je	.L49
	subq	$8, %rsp
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
	addq	$8, %rsp
	ret
	.p2align 4,,10
	.p2align 3
.L49:
	ret
	.size	log_close, .-log_close
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"INFO"
.LC2:
	.string	"WARNING"
.LC3:
	.string	"ERROR"
.LC4:
	.string	"UNKNOWN"
.LC5:
	.string	"%Y-%m-%d %H:%M:%S"
.LC6:
	.string	"[%s] [%s] %s\n"
.LC7:
	.string	"%s"
	.text
	.p2align 4
	.globl	log_message
	.type	log_message, @function
log_message:
	pushq	%r13
	movq	%rsi, %r13
	pushq	%r12
	pushq	%rbp
	movl	%edi, %ebp
	pushq	%rbx
	subq	$8456, %rsp
	movq	%rdx, 8288(%rsp)
	movq	%rcx, 8296(%rsp)
	movq	%r8, 8304(%rsp)
	movq	%r9, 8312(%rsp)
	testb	%al, %al
	je	.L53
	movaps	%xmm0, 8320(%rsp)
	movaps	%xmm1, 8336(%rsp)
	movaps	%xmm2, 8352(%rsp)
	movaps	%xmm3, 8368(%rsp)
	movaps	%xmm4, 8384(%rsp)
	movaps	%xmm5, 8400(%rsp)
	movaps	%xmm6, 8416(%rsp)
	movaps	%xmm7, 8432(%rsp)
.L53:
	movq	%fs:40, %rdi
	movq	%rdi, 8264(%rsp)
	xorl	%edi, %edi
	call	time@PLT
	movq	%rsp, %rdi
	movq	%rax, (%rsp)
	call	localtime@PLT
	movl	$26, %esi
	leaq	32(%rsp), %rdi
	leaq	.LC5(%rip), %rdx
	movq	%rax, %rcx
	call	strftime@PLT
	cmpl	$1, %ebp
	je	.L58
	leaq	.LC3(%rip), %rbx
	cmpl	$2, %ebp
	je	.L54
	leaq	.LC1(%rip), %rbx
	testl	%ebp, %ebp
	leaq	.LC4(%rip), %rax
	cmovne	%rax, %rbx
.L54:
	leaq	8496(%rsp), %rax
	leaq	64(%rsp), %rbp
	movq	%r13, %rdx
	movl	$16, 8(%rsp)
	movq	%rax, 16(%rsp)
	leaq	8(%rsp), %rcx
	movl	$4096, %esi
	movq	%rbp, %rdi
	leaq	8272(%rsp), %rax
	movl	$48, 12(%rsp)
	movq	%rax, 24(%rsp)
	call	vsnprintf@PLT
	movq	%rbp, %r9
	movq	%rbx, %r8
	leaq	32(%rsp), %rcx
	leaq	.LC6(%rip), %rdx
	movl	$4096, %esi
	leaq	4160(%rsp), %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	movl	4+log_config(%rip), %edx
	testl	%edx, %edx
	jne	.L66
.L55:
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L52
	movq	16+log_config(%rip), %rsi
	testq	%rsi, %rsi
	je	.L52
	leaq	4160(%rsp), %rdi
	call	fputs@PLT
	movq	16+log_config(%rip), %rdi
	call	fflush@PLT
.L52:
	movq	8264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L67
	addq	$8456, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
	.p2align 3
.L66:
	leaq	4160(%rsp), %rsi
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L55
	.p2align 4,,10
	.p2align 3
.L58:
	leaq	.LC2(%rip), %rbx
	jmp	.L54
.L67:
	call	__stack_chk_fail@PLT
	.size	log_message, .-log_message
	.section	.rodata.str1.1
.LC8:
	.string	"Memory allocation failed"
.LC9:
	.string	"\r\n"
.LC10:
	.string	"\r\n\r\n"
.LC11:
	.string	"./www"
.LC12:
	.string	"%s%s"
.LC13:
	.string	"Creating file: %s"
	.section	.rodata.str1.8
	.align 8
.LC14:
	.string	"Failed to create file: %s - %s"
	.section	.rodata.str1.1
.LC15:
	.string	"File created: %s"
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"HTTP/1.1 201 Created\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>File created successfully</h1></body></html>"
	.text
	.p2align 4
	.globl	handle_post_request
	.type	handle_post_request, @function
handle_post_request:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	movl	%edi, %r13d
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	leaq	1(%rdx), %rbx
	movq	%rbx, %rdi
	subq	$280, %rsp
	movq	%fs:40, %r12
	movq	%r12, 264(%rsp)
	movq	%rsi, %r12
	call	malloc@PLT
	testq	%rax, %rax
	je	.L91
	movq	%rax, %rbp
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	call	memcpy@PLT
	leaq	.LC9(%rip), %rsi
	movq	%rbp, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L86
	leaq	5(%rax), %rdi
	call	extract_path
	movq	%r12, %rdi
	leaq	.LC10(%rip), %rsi
	movq	%rax, %r14
	call	strstr@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L72
	testq	%r14, %r14
	je	.L86
	movq	%r14, %r8
	leaq	.LC11(%rip), %rcx
	movq	%rsp, %rdi
	xorl	%eax, %eax
	leaq	.LC12(%rip), %rdx
	movl	$256, %esi
	call	snprintf@PLT
	movq	%rsp, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC13(%rip), %rsi
	call	log_message
	movl	$420, %edx
	movq	%rsp, %rdi
	xorl	%eax, %eax
	movl	$577, %esi
	call	open@PLT
	movl	%eax, %r15d
	testl	%eax, %eax
	js	.L92
	leaq	4(%r12), %rdi
	call	strlen@PLT
	leaq	4(%r12), %rsi
	movl	%r15d, %edi
	movq	%rax, %rdx
	call	write@PLT
	movl	%r15d, %edi
	call	close@PLT
	movq	%rsp, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC15(%rip), %rsi
	call	log_message
	movl	$128, %edx
	leaq	.LC16(%rip), %rsi
.L88:
	movl	%r13d, %edi
	call	write@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
.L68:
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L90
	addq	$280, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4,,10
	.p2align 3
.L86:
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r13d, %edi
	call	write@PLT
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L90
	movq	%rbp, %rdi
.L89:
	addq	$280, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L92:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rsp, %rdx
	movl	$2, %edi
	leaq	.LC14(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdx
	jmp	.L88
.L90:
	call	__stack_chk_fail@PLT
.L91:
	xorl	%eax, %eax
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L90
	addq	$280, %rsp
	movl	%r13d, %edi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	send_500_error
.L72:
	movl	%r13d, %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	movq	%rbp, %rdi
	call	free@PLT
	testq	%r14, %r14
	je	.L68
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L90
	movq	%r14, %rdi
	jmp	.L89
	.size	handle_post_request, .-handle_post_request
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>File updated successfully</h1></body></html>"
	.align 8
.LC18:
	.string	"Failed to open/create file: %s - %s"
	.section	.rodata.str1.1
.LC19:
	.string	"File updated: %s"
	.text
	.p2align 4
	.globl	handle_put_request
	.type	handle_put_request, @function
handle_put_request:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	movl	%edi, %r12d
	pushq	%rbp
	leaq	1(%rdx), %rbp
	pushq	%rbx
	movq	%rbp, %rdi
	subq	$440, %rsp
	movq	%fs:40, %r13
	movq	%r13, 424(%rsp)
	movq	%rsi, %r13
	call	malloc@PLT
	testq	%rax, %rax
	je	.L122
	movq	%rax, %rbx
	movq	%r13, %rsi
	movq	%rax, %rdi
	movq	%rbp, %rdx
	call	memcpy@PLT
	leaq	.LC9(%rip), %rsi
	movq	%rbx, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L118
	leaq	4(%rax), %rdi
	call	extract_path
	leaq	.LC10(%rip), %rsi
	movq	%r13, %rdi
	movq	%rax, %r14
	call	strstr@PLT
	testq	%rax, %rax
	je	.L97
	leaq	4(%rax), %r13
	testq	%r14, %r14
	je	.L118
	leaq	160(%rsp), %rbp
	movl	$256, %esi
	xorl	%eax, %eax
	movq	%r14, %r8
	movq	%rbp, %rdi
	leaq	.LC11(%rip), %rcx
	leaq	.LC12(%rip), %rdx
	call	snprintf@PLT
	leaq	16(%rsp), %rsi
	movq	%rbp, %rdi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L103
	movl	40(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	je	.L104
.L103:
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC13(%rip), %rsi
	movq	%rbp, %rdx
	call	log_message
	xorl	%eax, %eax
	movl	$420, %edx
	movq	%rbp, %rdi
	movl	$577, %esi
	call	open@PLT
	testl	%eax, %eax
	jns	.L105
.L109:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rdx
	movl	$2, %edi
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	movq	http_500_response(%rip), %rbp
	movq	%rbp, %rdi
	call	strlen@PLT
	movl	%r12d, %edi
	movq	%rbp, %rsi
	movq	%rax, %rdx
	call	write@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L120
.L106:
	movq	%rbx, %rdi
.L121:
	addq	$440, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L105:
	movq	%r13, %rdi
	movl	%eax, 12(%rsp)
	call	strlen@PLT
	movl	12(%rsp), %edi
	movq	%r13, %rsi
	movq	%rax, %rdx
	call	write@PLT
	movl	12(%rsp), %edi
	call	close@PLT
	movq	%rbp, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC15(%rip), %rsi
	call	log_message
	movl	$128, %edx
	leaq	.LC16(%rip), %rsi
.L108:
	movl	%r12d, %edi
	call	write@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
.L93:
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L120
	addq	$440, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4,,10
	.p2align 3
.L118:
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r12d, %edi
	call	write@PLT
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	je	.L106
.L120:
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L104:
	movl	$420, %edx
	movl	$577, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	open@PLT
	movl	%eax, %r15d
	testl	%eax, %eax
	js	.L109
	movq	%r13, %rdi
	call	strlen@PLT
	movq	%r13, %rsi
	movl	%r15d, %edi
	movq	%rax, %rdx
	call	write@PLT
	movl	%r15d, %edi
	call	close@PLT
	movq	%rbp, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC19(%rip), %rsi
	call	log_message
	movl	$123, %edx
	leaq	.LC17(%rip), %rsi
	jmp	.L108
.L122:
	xorl	%eax, %eax
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L120
	addq	$440, %rsp
	movl	%r12d, %edi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	send_500_error
.L97:
	movl	%r12d, %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	movq	%rbx, %rdi
	call	free@PLT
	testq	%r14, %r14
	je	.L93
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L120
	movq	%r14, %rdi
	jmp	.L121
	.size	handle_put_request, .-handle_put_request
	.section	.rodata.str1.1
.LC20:
	.string	"Deleting file: %s"
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"Failed to delete file: %s - %s"
	.section	.rodata.str1.1
.LC22:
	.string	"File deleted: %s"
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>File deleted successfully</h1></body></html>"
	.text
	.p2align 4
	.globl	handle_delete_request
	.type	handle_delete_request, @function
handle_delete_request:
	pushq	%r13
	pushq	%r12
	movl	%edi, %r12d
	pushq	%rbp
	pushq	%rbx
	leaq	1(%rdx), %rbx
	movq	%rbx, %rdi
	subq	$296, %rsp
	movq	%fs:40, %r13
	movq	%r13, 280(%rsp)
	movq	%rsi, %r13
	call	malloc@PLT
	testq	%rax, %rax
	je	.L143
	movq	%rax, %rbp
	movq	%r13, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	call	memcpy@PLT
	leaq	.LC9(%rip), %rsi
	movq	%rbp, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L128
	leaq	7(%rax), %rdi
	call	extract_path
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L128
	movq	%rax, %r8
	leaq	.LC11(%rip), %rcx
	movl	$256, %esi
	xorl	%eax, %eax
	leaq	.LC12(%rip), %rdx
	leaq	16(%rsp), %rdi
	call	snprintf@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	16(%rsp), %rdx
	leaq	.LC20(%rip), %rsi
	call	log_message
	leaq	16(%rsp), %rdi
	call	unlink@PLT
	testl	%eax, %eax
	js	.L144
	leaq	16(%rsp), %rdx
	leaq	.LC22(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	movl	$123, %edx
	leaq	.LC23(%rip), %rsi
.L142:
	movl	%r12d, %edi
	call	write@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L140
.L133:
	addq	$296, %rsp
	movq	%rbp, %rdi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L128:
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r12d, %edi
	call	write@PLT
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	je	.L133
.L140:
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L144:
	call	__errno_location@PLT
	movl	(%rax), %edi
	movq	%rax, 8(%rsp)
	call	strerror@PLT
	leaq	16(%rsp), %rdx
	movl	$2, %edi
	leaq	.LC21(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	movq	8(%rsp), %r8
	cmpl	$2, (%r8)
	je	.L145
	movq	http_500_response(%rip), %rbx
.L139:
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdx
	jmp	.L142
	.p2align 4,,10
	.p2align 3
.L145:
	movq	http_404_response(%rip), %rbx
	jmp	.L139
.L143:
	xorl	%eax, %eax
	leaq	.LC8(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L140
	addq	$296, %rsp
	movl	%r12d, %edi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	jmp	send_500_error
	.size	handle_delete_request, .-handle_delete_request
	.section	.rodata.str1.1
.LC24:
	.string	"Shutting down server..."
	.text
	.p2align 4
	.globl	signal_handler
	.type	signal_handler, @function
signal_handler:
	cmpl	$2, %edi
	je	.L155
	ret
	.p2align 4,,10
	.p2align 3
.L155:
	xorl	%eax, %eax
	subq	$8, %rsp
	leaq	.LC24(%rip), %rsi
	xorl	%edi, %edi
	call	log_message
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L148
	movq	16+log_config(%rip), %rdi
	testq	%rdi, %rdi
	je	.L148
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
.L148:
	movl	server_socket(%rip), %edi
	call	close@PLT
	xorl	%edi, %edi
	call	exit@PLT
	.size	signal_handler, .-signal_handler
	.section	.rodata.str1.1
.LC25:
	.string	"a"
.LC26:
	.string	"Error opening log file: %s\n"
.LC27:
	.string	"Server logging initialized"
	.text
	.p2align 4
	.globl	log_init
	.type	log_init, @function
log_init:
	subq	$8, %rsp
	movl	log_config(%rip), %edx
	testl	%edx, %edx
	jne	.L161
.L158:
	leaq	.LC27(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	addq	$8, %rsp
	jmp	log_message
	.p2align 4,,10
	.p2align 3
.L161:
	movq	8+log_config(%rip), %rdi
	leaq	.LC25(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 16+log_config(%rip)
	testq	%rax, %rax
	jne	.L158
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC26(%rip), %rsi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%eax, log_config(%rip)
	jmp	.L158
	.size	log_init, .-log_init
	.section	.rodata.str1.1
.LC28:
	.string	"application/octet-stream"
.LC29:
	.string	"image/jpeg"
.LC30:
	.string	"text/css"
.LC31:
	.string	"application/javascript"
.LC32:
	.string	"text/html; charset=utf-8"
.LC33:
	.string	"image/png"
.LC34:
	.string	"image/gif"
.LC35:
	.string	"image/svg+xml"
.LC36:
	.string	"image/x-icon"
.LC37:
	.string	"application/pdf"
.LC38:
	.string	"application/zip"
.LC39:
	.string	"text/plain"
.LC40:
	.string	"audio/mpeg"
.LC41:
	.string	"video/mp4"
.LC42:
	.string	"image/webp"
.LC43:
	.string	"image/bmp"
.LC44:
	.string	"image/tiff"
.LC45:
	.string	"html"
.LC46:
	.string	"htm"
.LC47:
	.string	"css"
.LC48:
	.string	"js"
.LC49:
	.string	"jpg"
.LC50:
	.string	"jpeg"
.LC51:
	.string	"png"
.LC52:
	.string	"gif"
.LC53:
	.string	"svg"
.LC54:
	.string	"ico"
.LC55:
	.string	"pdf"
.LC56:
	.string	"zip"
.LC57:
	.string	"txt"
.LC58:
	.string	"mp3"
.LC59:
	.string	"mp4"
.LC60:
	.string	"webp"
.LC61:
	.string	"bmp"
.LC62:
	.string	"tiff"
.LC63:
	.string	"tif"
	.text
	.p2align 4
	.globl	get_content_type
	.type	get_content_type, @function
get_content_type:
	pushq	%rbp
	movl	$46, %esi
	pushq	%rbx
	subq	$8, %rsp
	call	strrchr@PLT
	testq	%rax, %rax
	je	.L164
	leaq	1(%rax), %rbx
	leaq	.LC45(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC32(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC46(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC47(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC30(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC48(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC31(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC49(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC29(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC50(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC51(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC33(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC52(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC34(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC53(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC35(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC54(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC36(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC55(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC37(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC56(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC38(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC57(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC39(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC58(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC40(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC59(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC41(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC60(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC42(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC61(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC43(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L162
	leaq	.LC62(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L183
	leaq	.LC63(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L164
.L183:
	leaq	.LC44(%rip), %rbp
.L162:
	addq	$8, %rsp
	movq	%rbp, %rax
	popq	%rbx
	popq	%rbp
	ret
	.p2align 4,,10
	.p2align 3
.L164:
	leaq	.LC28(%rip), %rbp
	addq	$8, %rsp
	movq	%rbp, %rax
	popq	%rbx
	popq	%rbp
	ret
	.size	get_content_type, .-get_content_type
	.section	.rodata.str1.1
.LC64:
	.string	"File not found: %s"
.LC65:
	.string	"Serving file: %s (%ld bytes)"
.LC66:
	.string	"Failed to open file: %s - %s"
	.section	.rodata.str1.8
	.align 8
.LC67:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: %s\r\nContent-Length: %ld\r\nConnection: close\r\n\r\n"
	.text
	.p2align 4
	.globl	serve_file
	.type	serve_file, @function
serve_file:
	pushq	%r12
	movq	%rsi, %r8
	leaq	.LC11(%rip), %rcx
	movl	$256, %esi
	pushq	%rbp
	leaq	.LC12(%rip), %rdx
	movl	%edi, %ebp
	pushq	%rbx
	subq	$5024, %rsp
	movq	%fs:40, %rax
	movq	%rax, 5016(%rsp)
	xorl	%eax, %eax
	leaq	144(%rsp), %rbx
	movq	%rbx, %rdi
	call	snprintf@PLT
	movq	%rsp, %rsi
	movq	%rbx, %rdi
	call	stat@PLT
	testl	%eax, %eax
	js	.L203
	movl	24(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	je	.L204
.L203:
	movq	%rbx, %rdx
	leaq	.LC64(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
.L212:
	movq	http_404_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%ebp, %edi
	movq	%rax, %rdx
	call	write@PLT
.L202:
	movq	5016(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L213
	addq	$5024, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
	.p2align 3
.L204:
	movq	48(%rsp), %rcx
	movq	%rbx, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC65(%rip), %rsi
	call	log_message
	xorl	%esi, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	open@PLT
	movl	%eax, %r12d
	testl	%eax, %eax
	js	.L214
	movq	%rbx, %rdi
	call	get_content_type
	movq	48(%rsp), %r8
	leaq	.LC67(%rip), %rdx
	movl	$512, %esi
	movq	%rax, %rcx
	leaq	400(%rsp), %rdi
	xorl	%eax, %eax
	call	snprintf@PLT
	leaq	400(%rsp), %rdi
	call	strlen@PLT
	leaq	400(%rsp), %rsi
	movl	%ebp, %edi
	movq	%rax, %rdx
	call	write@PLT
	jmp	.L207
	.p2align 4,,10
	.p2align 3
.L208:
	movq	%rax, %rdx
	leaq	912(%rsp), %rsi
	movl	%ebp, %edi
	call	write@PLT
.L207:
	movl	$4096, %edx
	leaq	912(%rsp), %rsi
	movl	%r12d, %edi
	call	read@PLT
	testq	%rax, %rax
	jg	.L208
	movl	%r12d, %edi
	call	close@PLT
	jmp	.L202
	.p2align 4,,10
	.p2align 3
.L214:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbx, %rdx
	movl	$2, %edi
	leaq	.LC66(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	jmp	.L212
.L213:
	call	__stack_chk_fail@PLT
	.size	serve_file, .-serve_file
	.section	.rodata.str1.1
.LC68:
	.string	"/index.html"
	.text
	.p2align 4
	.globl	handle_get_request
	.type	handle_get_request, @function
handle_get_request:
	cmpb	$47, (%rsi)
	jne	.L217
	cmpb	$0, 1(%rsi)
	jne	.L217
	leaq	.LC68(%rip), %rsi
	jmp	serve_file
	.p2align 4,,10
	.p2align 3
.L217:
	jmp	serve_file
	.size	handle_get_request, .-handle_get_request
	.section	.rodata.str1.1
.LC69:
	.string	"Empty request from %s"
.LC70:
	.string	"[%s] Request: %s"
.LC71:
	.string	"GET "
.LC72:
	.string	"[%s] GET %s"
.LC73:
	.string	"POST "
.LC74:
	.string	"[%s] POST %s"
.LC75:
	.string	"PUT "
.LC76:
	.string	"[%s] PUT %s"
.LC77:
	.string	"DELETE "
.LC78:
	.string	"[%s] DELETE %s"
.LC79:
	.string	"[%s] Unknown HTTP method"
	.text
	.p2align 4
	.globl	handle_client
	.type	handle_client, @function
handle_client:
	pushq	%r15
	movl	$4095, %edx
	pushq	%r14
	movl	%edi, %r14d
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$8472, %rsp
	movq	%fs:40, %r13
	movq	%r13, 8456(%rsp)
	movq	%rsi, %r13
	leaq	256(%rsp), %rbp
	movq	%rbp, %rsi
	call	read@PLT
	testq	%rax, %rax
	jle	.L247
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movl	$255, %edx
	movq	%rax, %rbx
	movb	$0, 256(%rsp,%rax)
	call	strncpy@PLT
	movl	$13, %esi
	movq	%rsp, %rdi
	movb	$0, 255(%rsp)
	call	strchr@PLT
	testq	%rax, %rax
	je	.L221
.L246:
	movb	$0, (%rax)
.L222:
	leaq	1(%rbx), %rdx
	movq	%rbp, %rsi
	leaq	4352(%rsp), %rdi
	call	memcpy@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	movq	%rsp, %rcx
	movq	%r13, %rdx
	leaq	.LC70(%rip), %rsi
	call	log_message
	cmpl	$542393671, 256(%rsp)
	je	.L248
	cmpl	$1414745936, 256(%rsp)
	je	.L249
.L230:
	cmpl	$542397776, 256(%rsp)
	je	.L250
	cmpl	$1162626372, 256(%rsp)
	je	.L251
.L236:
	movq	%r13, %rdx
	leaq	.LC79(%rip), %rsi
	xorl	%eax, %eax
	movl	$1, %edi
	call	log_message
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%r14d, %edi
	movq	%rax, %rdx
	call	write@PLT
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L248:
	leaq	260(%rsp), %rdi
	call	extract_path
	xorl	%edi, %edi
	movq	%r13, %rdx
	leaq	.LC72(%rip), %rsi
	movq	%rax, %rbx
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	cmpb	$47, (%rbx)
	jne	.L227
	cmpb	$0, 1(%rbx)
	jne	.L227
	leaq	.LC68(%rip), %rsi
	movl	%r14d, %edi
	call	serve_file
.L228:
	movq	%rbx, %rdi
	call	free@PLT
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L247:
	movq	%r13, %rdx
	leaq	.LC69(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
.L218:
	movq	8456(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L252
	addq	$8472, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4,,10
	.p2align 3
.L221:
	movl	$10, %esi
	movq	%rsp, %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L246
	jmp	.L222
	.p2align 4,,10
	.p2align 3
.L227:
	movq	%rbx, %rsi
	movl	%r14d, %edi
	call	serve_file
	jmp	.L228
	.p2align 4,,10
	.p2align 3
.L251:
	cmpl	$541414469, 259(%rsp)
	jne	.L236
	leaq	263(%rsp), %rdi
	call	extract_path
	movq	%r13, %rdx
	xorl	%edi, %edi
	leaq	.LC78(%rip), %rsi
	movq	%rax, %rcx
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	log_message
	movl	%r14d, %edi
	movq	%rbx, %rdx
	leaq	4352(%rsp), %rsi
	call	handle_delete_request
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L249:
	cmpb	$32, 260(%rsp)
	jne	.L230
	leaq	261(%rsp), %rdi
	call	extract_path
	movq	%r13, %rdx
	xorl	%edi, %edi
	leaq	.LC74(%rip), %rsi
	movq	%rax, %rcx
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	log_message
	movl	%r14d, %edi
	movq	%rbx, %rdx
	leaq	4352(%rsp), %rsi
	call	handle_post_request
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L218
	.p2align 4,,10
	.p2align 3
.L250:
	leaq	260(%rsp), %rdi
	call	extract_path
	movq	%r13, %rdx
	xorl	%edi, %edi
	leaq	.LC76(%rip), %rsi
	movq	%rax, %rcx
	movq	%rax, %rbp
	xorl	%eax, %eax
	call	log_message
	movl	%r14d, %edi
	movq	%rbx, %rdx
	leaq	4352(%rsp), %rsi
	call	handle_put_request
	movq	%rbp, %rdi
	call	free@PLT
	jmp	.L218
.L252:
	call	__stack_chk_fail@PLT
	.size	handle_client, .-handle_client
	.section	.rodata.str1.8
	.align 8
.LC80:
	.string	"Invalid port number. Using default port %d"
	.align 8
.LC81:
	.string	"HTTP Server starting on port %d"
	.section	.rodata.str1.1
.LC82:
	.string	"Error creating socket: %s"
	.section	.rodata.str1.8
	.align 8
.LC83:
	.string	"Error setting socket options: %s"
	.section	.rodata.str1.1
.LC84:
	.string	"Error binding socket: %s"
.LC85:
	.string	"Error listening on socket: %s"
	.section	.rodata.str1.8
	.align 8
.LC86:
	.string	"Server ready to accept connections"
	.align 8
.LC87:
	.string	"Error accepting connection: %s"
	.align 8
.LC88:
	.string	"New connection accepted from %s"
	.section	.rodata.str1.1
.LC89:
	.string	"Error forking process: %s"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	movl	%edi, %ebx
	subq	$80, %rsp
	movq	%fs:40, %rbp
	movq	%rbp, 72(%rsp)
	movq	%rsi, %rbp
	call	log_init
	cmpl	$1, %ebx
	jg	.L272
.L254:
	movl	$6969, %ebx
.L255:
	movl	%ebx, %edx
	leaq	.LC81(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	xorl	%edx, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, server_socket(%rip)
	testl	%eax, %eax
	js	.L273
	leaq	8(%rsp), %rcx
	movl	$4, %r8d
	movl	$2, %edx
	movl	%eax, %edi
	movl	$1, %esi
	movl	$1, 8(%rsp)
	call	setsockopt@PLT
	testl	%eax, %eax
	js	.L274
	xorl	%edx, %edx
	movl	server_socket(%rip), %edi
	xorl	%eax, %eax
	rolw	$8, %bx
	movl	%edx, 28(%rsp)
	leaq	16(%rsp), %rsi
	movl	$16, %edx
	movq	%rax, 20(%rsp)
	movw	$2, 16(%rsp)
	movw	%bx, 18(%rsp)
	call	bind@PLT
	testl	%eax, %eax
	js	.L275
	movl	server_socket(%rip), %edi
	movl	$10, %esi
	call	listen@PLT
	testl	%eax, %eax
	js	.L276
	leaq	signal_handler(%rip), %rsi
	movl	$2, %edi
	leaq	48(%rsp), %rbp
	call	signal@PLT
	movl	$493, %esi
	leaq	.LC11(%rip), %rdi
	call	mkdir@PLT
	leaq	.LC86(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	.p2align 4
	.p2align 3
.L263:
	movl	server_socket(%rip), %edi
	leaq	12(%rsp), %rdx
	leaq	32(%rsp), %rsi
	movl	$16, 12(%rsp)
	call	accept@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L277
	movl	$16, %ecx
	movq	%rbp, %rdx
	leaq	36(%rsp), %rsi
	movl	$2, %edi
	call	inet_ntop@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	movq	%rbp, %rdx
	leaq	.LC88(%rip), %rsi
	call	log_message
	call	fork@PLT
	testl	%eax, %eax
	js	.L278
	je	.L279
	movl	%ebx, %edi
	call	close@PLT
	jmp	.L263
.L277:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC87(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	log_message
	jmp	.L263
.L278:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC89(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	log_message
	movl	%ebx, %edi
	call	close@PLT
	jmp	.L263
.L272:
	movq	8(%rbp), %rdi
	call	parse_port
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L255
	movl	$6969, %edx
	leaq	.LC80(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
	jmp	.L254
.L279:
	movl	server_socket(%rip), %edi
	call	close@PLT
	movq	%rbp, %rsi
	movl	%ebx, %edi
	call	handle_client
	movl	%ebx, %edi
	call	close@PLT
	xorl	%edi, %edi
	call	exit@PLT
.L273:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC82(%rip), %rsi
	movq	%rax, %rdx
.L271:
	movl	$2, %edi
	xorl	%eax, %eax
	call	log_message
	movl	log_config(%rip), %ecx
	testl	%ecx, %ecx
	je	.L258
	call	log_close.part.0
.L258:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L280
	addq	$80, %rsp
	movl	$1, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L275:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC84(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L271
.L274:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC83(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L271
.L276:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC85(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L271
.L280:
	call	__stack_chk_fail@PLT
	.size	main, .-main
	.globl	server_socket
	.bss
	.align 4
	.type	server_socket, @object
	.size	server_socket, 4
server_socket:
	.zero	4
	.globl	http_500_response
	.section	.rodata.str1.8
	.align 8
.LC90:
	.string	"HTTP/1.1 500 Internal Server Error\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>500 Internal Server Error</h1></body></html>\r\n"
	.section	.data.rel.local,"aw"
	.align 8
	.type	http_500_response, @object
	.size	http_500_response, 8
http_500_response:
	.quad	.LC90
	.globl	http_404_response
	.section	.rodata.str1.8
	.align 8
.LC91:
	.string	"HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>404 Not Found</h1></body></html>\r\n"
	.section	.data.rel.local
	.align 8
	.type	http_404_response, @object
	.size	http_404_response, 8
http_404_response:
	.quad	.LC91
	.globl	http_200_header
	.section	.rodata.str1.8
	.align 8
.LC92:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nConnection: close\r\n\r\n"
	.section	.data.rel.local
	.align 8
	.type	http_200_header, @object
	.size	http_200_header, 8
http_200_header:
	.quad	.LC92
	.globl	log_config
	.section	.rodata.str1.1
.LC93:
	.string	"server.log"
	.section	.data.rel.local
	.align 16
	.type	log_config, @object
	.size	log_config, 24
log_config:
	.long	1
	.long	1
	.quad	.LC93
	.quad	0
	.ident	"GCC: (GNU) 15.2.1 20250813"
	.section	.note.GNU-stack,"",@progbits
