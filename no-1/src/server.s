	.file	"server.c"
	.text
	.p2align 4
	.type	log_close.part.0, @function
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
	.string	"./www"
.LC9:
	.string	"%s/templates%s"
.LC10:
	.string	"Loading template: %s"
.LC11:
	.string	"Failed to load template: %s"
.LC12:
	.string	"Failed to render template"
	.section	.rodata.str1.8
	.align 8
.LC13:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nConnection: close\r\n\r\n"
	.text
	.p2align 4
	.globl	serve_template
	.type	serve_template, @function
serve_template:
	pushq	%r13
	movq	%rsi, %r8
	leaq	.LC8(%rip), %rcx
	movq	%rdx, %r13
	pushq	%r12
	leaq	.LC9(%rip), %rdx
	movl	$256, %esi
	movl	%edi, %r12d
	pushq	%rbp
	pushq	%rbx
	subq	$280, %rsp
	movq	%fs:40, %rax
	movq	%rax, 264(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rdi
	call	snprintf@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	movq	%rsp, %rdx
	leaq	.LC10(%rip), %rsi
	call	log_message
	movq	%rsp, %rdi
	call	template_load_file@PLT
	testq	%rax, %rax
	je	.L76
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%rax, %rbp
	call	template_render@PLT
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	free@PLT
	testq	%rbx, %rbx
	je	.L77
	movl	$78, %edx
	leaq	.LC13(%rip), %rsi
	movl	%r12d, %edi
	call	write@PLT
	movq	%rbx, %rdi
	call	strlen@PLT
	movl	%r12d, %edi
	movq	%rbx, %rsi
	movq	%rax, %rdx
	call	write@PLT
	movq	%rbx, %rdi
	call	free@PLT
.L68:
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L78
	addq	$280, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
	.p2align 3
.L76:
	movq	%rsp, %rdx
	leaq	.LC11(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	log_message
	movq	http_404_response(%rip), %rbx
.L75:
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%r12d, %edi
	movq	%rax, %rdx
	call	write@PLT
	jmp	.L68
	.p2align 4,,10
	.p2align 3
.L77:
	leaq	.LC12(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	log_message
	movq	http_500_response(%rip), %rbx
	jmp	.L75
.L78:
	call	__stack_chk_fail@PLT
	.size	serve_template, .-serve_template
	.section	.rodata.str1.1
.LC14:
	.string	"current_time"
.LC15:
	.string	"Assembly HTTP Server"
.LC16:
	.string	"server_name"
.LC17:
	.string	"Dynamic Content"
.LC18:
	.string	"page_title"
.LC19:
	.string	"welcome"
.LC20:
	.string	"Visitor"
.LC21:
	.string	"username"
.LC22:
	.string	"Welcome to our website!"
.LC23:
	.string	"message"
.LC24:
	.string	"dashboard"
.LC25:
	.string	"Admin"
	.section	.rodata.str1.8
	.align 8
.LC26:
	.string	"Server uptime: 3 days, 2 hours"
	.section	.rodata.str1.1
.LC27:
	.string	"stats"
.LC28:
	.string	"Welcome to your dashboard!"
	.text
	.p2align 4
	.globl	handle_template_request
	.type	handle_template_request, @function
handle_template_request:
	pushq	%r13
	movl	%edi, %r13d
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$104, %rsp
	movq	%fs:40, %rbp
	movq	%rbp, 88(%rsp)
	movq	%rsi, %rbp
	call	template_create_context@PLT
	testq	%rax, %rax
	je	.L90
	xorl	%edi, %edi
	movq	%rax, %rbx
	call	time@PLT
	leaq	8(%rsp), %rdi
	movq	%rax, 8(%rsp)
	call	localtime@PLT
	movl	$64, %esi
	leaq	16(%rsp), %rdi
	leaq	.LC5(%rip), %rdx
	movq	%rax, %rcx
	call	strftime@PLT
	leaq	16(%rsp), %rdx
	leaq	.LC14(%rip), %rsi
	movq	%rbx, %rdi
	call	template_add_variable@PLT
	leaq	.LC15(%rip), %rdx
	leaq	.LC16(%rip), %rsi
	movq	%rbx, %rdi
	call	template_add_variable@PLT
	leaq	.LC18(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC17(%rip), %rdx
	call	template_add_variable@PLT
	leaq	.LC19(%rip), %rsi
	movq	%rbp, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L82
	leaq	.LC20(%rip), %rdx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	call	template_add_variable@PLT
	leaq	.LC22(%rip), %rdx
	leaq	.LC23(%rip), %rsi
	movq	%rbx, %rdi
	call	template_add_variable@PLT
.L83:
	movl	%r13d, %edi
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	call	serve_template
	movq	%rbx, %rdi
	call	template_free_context@PLT
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L89
	addq	$104, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
	.p2align 3
.L82:
	leaq	.LC24(%rip), %rsi
	movq	%rbp, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L83
	movq	%rbx, %rdi
	leaq	.LC25(%rip), %rdx
	leaq	.LC21(%rip), %rsi
	call	template_add_variable@PLT
	movq	%rbx, %rdi
	leaq	.LC26(%rip), %rdx
	leaq	.LC27(%rip), %rsi
	call	template_add_variable@PLT
	leaq	.LC28(%rip), %rdx
	leaq	.LC23(%rip), %rsi
	movq	%rbx, %rdi
	call	template_add_variable@PLT
	jmp	.L83
	.p2align 4,,10
	.p2align 3
.L90:
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L89
	addq	$104, %rsp
	movq	%rbx, %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	jmp	write@PLT
.L89:
	call	__stack_chk_fail@PLT
	.size	handle_template_request, .-handle_template_request
	.section	.rodata.str1.1
.LC29:
	.string	"Memory allocation failed"
.LC30:
	.string	"\r\n"
.LC31:
	.string	"\r\n\r\n"
.LC32:
	.string	"%s%s"
.LC33:
	.string	"Creating file: %s"
	.section	.rodata.str1.8
	.align 8
.LC34:
	.string	"Failed to create file: %s - %s"
	.section	.rodata.str1.1
.LC35:
	.string	"File created: %s"
	.section	.rodata.str1.8
	.align 8
.LC36:
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
	je	.L114
	movq	%rax, %rbp
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	call	memcpy@PLT
	leaq	.LC30(%rip), %rsi
	movq	%rbp, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L109
	leaq	5(%rax), %rdi
	call	extract_path
	movq	%r12, %rdi
	leaq	.LC31(%rip), %rsi
	movq	%rax, %r14
	call	strstr@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L95
	testq	%r14, %r14
	je	.L109
	movq	%r14, %r8
	leaq	.LC8(%rip), %rcx
	movq	%rsp, %rdi
	xorl	%eax, %eax
	leaq	.LC32(%rip), %rdx
	movl	$256, %esi
	call	snprintf@PLT
	movq	%rsp, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC33(%rip), %rsi
	call	log_message
	movl	$420, %edx
	movq	%rsp, %rdi
	xorl	%eax, %eax
	movl	$577, %esi
	call	open@PLT
	movl	%eax, %r15d
	testl	%eax, %eax
	js	.L115
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
	leaq	.LC35(%rip), %rsi
	call	log_message
	movl	$128, %edx
	leaq	.LC36(%rip), %rsi
.L111:
	movl	%r13d, %edi
	call	write@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
.L91:
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L113
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
.L109:
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r13d, %edi
	call	write@PLT
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L113
	movq	%rbp, %rdi
.L112:
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
.L115:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rsp, %rdx
	movl	$2, %edi
	leaq	.LC34(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdx
	jmp	.L111
.L113:
	call	__stack_chk_fail@PLT
.L114:
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L113
	addq	$280, %rsp
	movl	%r13d, %edi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	send_500_error
.L95:
	movl	%r13d, %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	movq	%rbp, %rdi
	call	free@PLT
	testq	%r14, %r14
	je	.L91
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L113
	movq	%r14, %rdi
	jmp	.L112
	.size	handle_post_request, .-handle_post_request
	.section	.rodata.str1.8
	.align 8
.LC37:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>File updated successfully</h1></body></html>"
	.align 8
.LC38:
	.string	"Failed to open/create file: %s - %s"
	.section	.rodata.str1.1
.LC39:
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
	je	.L145
	movq	%rax, %rbx
	movq	%r13, %rsi
	movq	%rax, %rdi
	movq	%rbp, %rdx
	call	memcpy@PLT
	leaq	.LC30(%rip), %rsi
	movq	%rbx, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L141
	leaq	4(%rax), %rdi
	call	extract_path
	leaq	.LC31(%rip), %rsi
	movq	%r13, %rdi
	movq	%rax, %r14
	call	strstr@PLT
	testq	%rax, %rax
	je	.L120
	leaq	4(%rax), %r13
	testq	%r14, %r14
	je	.L141
	leaq	160(%rsp), %rbp
	movl	$256, %esi
	xorl	%eax, %eax
	movq	%r14, %r8
	movq	%rbp, %rdi
	leaq	.LC8(%rip), %rcx
	leaq	.LC32(%rip), %rdx
	call	snprintf@PLT
	leaq	16(%rsp), %rsi
	movq	%rbp, %rdi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L126
	movl	40(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	je	.L127
.L126:
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC33(%rip), %rsi
	movq	%rbp, %rdx
	call	log_message
	xorl	%eax, %eax
	movl	$420, %edx
	movq	%rbp, %rdi
	movl	$577, %esi
	call	open@PLT
	testl	%eax, %eax
	jns	.L128
.L132:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbp, %rdx
	movl	$2, %edi
	leaq	.LC38(%rip), %rsi
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
	jne	.L143
.L129:
	movq	%rbx, %rdi
.L144:
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
.L128:
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
	leaq	.LC35(%rip), %rsi
	call	log_message
	movl	$128, %edx
	leaq	.LC36(%rip), %rsi
.L131:
	movl	%r12d, %edi
	call	write@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
.L116:
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L143
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
.L141:
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r12d, %edi
	call	write@PLT
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	je	.L129
.L143:
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L127:
	movl	$420, %edx
	movl	$577, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	open@PLT
	movl	%eax, %r15d
	testl	%eax, %eax
	js	.L132
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
	leaq	.LC39(%rip), %rsi
	call	log_message
	movl	$123, %edx
	leaq	.LC37(%rip), %rsi
	jmp	.L131
.L145:
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L143
	addq	$440, %rsp
	movl	%r12d, %edi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	send_500_error
.L120:
	movl	%r12d, %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	movq	%rbx, %rdi
	call	free@PLT
	testq	%r14, %r14
	je	.L116
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L143
	movq	%r14, %rdi
	jmp	.L144
	.size	handle_put_request, .-handle_put_request
	.section	.rodata.str1.1
.LC40:
	.string	"Deleting file: %s"
	.section	.rodata.str1.8
	.align 8
.LC41:
	.string	"Failed to delete file: %s - %s"
	.section	.rodata.str1.1
.LC42:
	.string	"File deleted: %s"
	.section	.rodata.str1.8
	.align 8
.LC43:
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
	je	.L166
	movq	%rax, %rbp
	movq	%r13, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	call	memcpy@PLT
	leaq	.LC30(%rip), %rsi
	movq	%rbp, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L151
	leaq	7(%rax), %rdi
	call	extract_path
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L151
	movq	%rax, %r8
	leaq	.LC8(%rip), %rcx
	movl	$256, %esi
	xorl	%eax, %eax
	leaq	.LC32(%rip), %rdx
	leaq	16(%rsp), %rdi
	call	snprintf@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	16(%rsp), %rdx
	leaq	.LC40(%rip), %rsi
	call	log_message
	leaq	16(%rsp), %rdi
	call	unlink@PLT
	testl	%eax, %eax
	js	.L167
	leaq	16(%rsp), %rdx
	leaq	.LC42(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	movl	$123, %edx
	leaq	.LC43(%rip), %rsi
.L165:
	movl	%r12d, %edi
	call	write@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L163
.L156:
	addq	$296, %rsp
	movq	%rbp, %rdi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L151:
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r12d, %edi
	call	write@PLT
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	je	.L156
.L163:
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L167:
	call	__errno_location@PLT
	movl	(%rax), %edi
	movq	%rax, 8(%rsp)
	call	strerror@PLT
	leaq	16(%rsp), %rdx
	movl	$2, %edi
	leaq	.LC41(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	movq	8(%rsp), %r8
	cmpl	$2, (%r8)
	je	.L168
	movq	http_500_response(%rip), %rbx
.L162:
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdx
	jmp	.L165
	.p2align 4,,10
	.p2align 3
.L168:
	movq	http_404_response(%rip), %rbx
	jmp	.L162
.L166:
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L163
	addq	$296, %rsp
	movl	%r12d, %edi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	jmp	send_500_error
	.size	handle_delete_request, .-handle_delete_request
	.section	.rodata.str1.1
.LC44:
	.string	"Shutting down server..."
	.text
	.p2align 4
	.globl	signal_handler
	.type	signal_handler, @function
signal_handler:
	cmpl	$2, %edi
	je	.L178
	ret
	.p2align 4,,10
	.p2align 3
.L178:
	xorl	%eax, %eax
	subq	$8, %rsp
	leaq	.LC44(%rip), %rsi
	xorl	%edi, %edi
	call	log_message
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L171
	movq	16+log_config(%rip), %rdi
	testq	%rdi, %rdi
	je	.L171
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
.L171:
	movl	server_socket(%rip), %edi
	call	close@PLT
	xorl	%edi, %edi
	call	exit@PLT
	.size	signal_handler, .-signal_handler
	.section	.rodata.str1.1
.LC45:
	.string	"a"
.LC46:
	.string	"Error opening log file: %s\n"
.LC47:
	.string	"Server logging initialized"
	.text
	.p2align 4
	.globl	log_init
	.type	log_init, @function
log_init:
	subq	$8, %rsp
	movl	log_config(%rip), %edx
	testl	%edx, %edx
	jne	.L184
.L181:
	leaq	.LC47(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	addq	$8, %rsp
	jmp	log_message
	.p2align 4,,10
	.p2align 3
.L184:
	movq	8+log_config(%rip), %rdi
	leaq	.LC45(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 16+log_config(%rip)
	testq	%rax, %rax
	jne	.L181
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	stderr(%rip), %rdi
	leaq	.LC46(%rip), %rsi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	fprintf@PLT
	xorl	%eax, %eax
	movl	%eax, log_config(%rip)
	jmp	.L181
	.size	log_init, .-log_init
	.section	.rodata.str1.1
.LC48:
	.string	"application/octet-stream"
.LC49:
	.string	"image/jpeg"
.LC50:
	.string	"text/css"
.LC51:
	.string	"application/javascript"
.LC52:
	.string	"text/html; charset=utf-8"
.LC53:
	.string	"image/png"
.LC54:
	.string	"image/gif"
.LC55:
	.string	"image/svg+xml"
.LC56:
	.string	"image/x-icon"
.LC57:
	.string	"application/pdf"
.LC58:
	.string	"application/zip"
.LC59:
	.string	"text/plain"
.LC60:
	.string	"audio/mpeg"
.LC61:
	.string	"video/mp4"
.LC62:
	.string	"image/webp"
.LC63:
	.string	"image/bmp"
.LC64:
	.string	"image/tiff"
.LC65:
	.string	"html"
.LC66:
	.string	"htm"
.LC67:
	.string	"css"
.LC68:
	.string	"js"
.LC69:
	.string	"jpg"
.LC70:
	.string	"jpeg"
.LC71:
	.string	"png"
.LC72:
	.string	"gif"
.LC73:
	.string	"svg"
.LC74:
	.string	"ico"
.LC75:
	.string	"pdf"
.LC76:
	.string	"zip"
.LC77:
	.string	"txt"
.LC78:
	.string	"mp3"
.LC79:
	.string	"mp4"
.LC80:
	.string	"webp"
.LC81:
	.string	"bmp"
.LC82:
	.string	"tiff"
.LC83:
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
	je	.L187
	leaq	1(%rax), %rbx
	leaq	.LC65(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC52(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC66(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC67(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC50(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC68(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC51(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC69(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC49(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC70(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC71(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC53(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC72(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC54(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC73(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC55(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC74(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC56(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC75(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC57(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC76(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC58(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC77(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC59(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC78(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC60(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC79(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC61(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC80(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC62(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC81(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC63(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L185
	leaq	.LC82(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L206
	leaq	.LC83(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L187
.L206:
	leaq	.LC64(%rip), %rbp
.L185:
	addq	$8, %rsp
	movq	%rbp, %rax
	popq	%rbx
	popq	%rbp
	ret
	.p2align 4,,10
	.p2align 3
.L187:
	leaq	.LC48(%rip), %rbp
	addq	$8, %rsp
	movq	%rbp, %rax
	popq	%rbx
	popq	%rbp
	ret
	.size	get_content_type, .-get_content_type
	.section	.rodata.str1.1
.LC84:
	.string	"File not found: %s"
.LC85:
	.string	"Serving file: %s (%ld bytes)"
.LC86:
	.string	"Failed to open file: %s - %s"
	.section	.rodata.str1.8
	.align 8
.LC87:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: %s\r\nContent-Length: %ld\r\nConnection: close\r\n\r\n"
	.text
	.p2align 4
	.globl	serve_file
	.type	serve_file, @function
serve_file:
	pushq	%r12
	movq	%rsi, %r8
	leaq	.LC8(%rip), %rcx
	movl	$256, %esi
	pushq	%rbp
	leaq	.LC32(%rip), %rdx
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
	js	.L226
	movl	24(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	je	.L227
.L226:
	movq	%rbx, %rdx
	leaq	.LC84(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
.L235:
	movq	http_404_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%ebp, %edi
	movq	%rax, %rdx
	call	write@PLT
.L225:
	movq	5016(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L236
	addq	$5024, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	ret
	.p2align 4,,10
	.p2align 3
.L227:
	movq	48(%rsp), %rcx
	movq	%rbx, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC85(%rip), %rsi
	call	log_message
	xorl	%esi, %esi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	open@PLT
	movl	%eax, %r12d
	testl	%eax, %eax
	js	.L237
	movq	%rbx, %rdi
	call	get_content_type
	movq	48(%rsp), %r8
	leaq	.LC87(%rip), %rdx
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
	jmp	.L230
	.p2align 4,,10
	.p2align 3
.L231:
	movq	%rax, %rdx
	leaq	912(%rsp), %rsi
	movl	%ebp, %edi
	call	write@PLT
.L230:
	movl	$4096, %edx
	leaq	912(%rsp), %rsi
	movl	%r12d, %edi
	call	read@PLT
	testq	%rax, %rax
	jg	.L231
	movl	%r12d, %edi
	call	close@PLT
	jmp	.L225
	.p2align 4,,10
	.p2align 3
.L237:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbx, %rdx
	movl	$2, %edi
	leaq	.LC86(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	jmp	.L235
.L236:
	call	__stack_chk_fail@PLT
	.size	serve_file, .-serve_file
	.section	.rodata.str1.1
.LC88:
	.string	"./bin/%s"
.LC89:
	.string	"Executing binary: %s"
.LC90:
	.string	"Failed to execute binary: %s"
	.section	.rodata.str1.8
	.align 8
.LC91:
	.string	"Binary executed successfully: %s (exit code: %d)"
	.text
	.p2align 4
	.globl	handle_exec_request
	.type	handle_exec_request, @function
handle_exec_request:
	pushq	%r15
	movl	$16, %ecx
	pushq	%r14
	pushq	%r13
	movl	%edi, %r13d
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$5016, %rsp
	movq	%fs:40, %rax
	movq	%rax, 5000(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rdi
	rep stosq
	leaq	6(%rsi), %rdi
	call	strdup@PLT
	testq	%rax, %rax
	je	.L251
	movl	$63, %esi
	movq	%rax, %rdi
	movq	%rax, %rbp
	call	strchr@PLT
	testq	%rax, %rax
	je	.L241
	movb	$0, (%rax)
.L241:
	leaq	128(%rsp), %rbx
	movq	%rbp, %rcx
	movl	$256, %esi
	xorl	%eax, %eax
	leaq	.LC88(%rip), %rdx
	movq	%rbx, %rdi
	call	snprintf@PLT
	movq	%rbx, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC89(%rip), %rsi
	call	log_message
	movl	$4096, %ecx
	movq	%rsp, %rsi
	movq	%rbx, %rdi
	leaq	896(%rsp), %rdx
	movq	%rbx, (%rsp)
	call	execute_binary@PLT
	movl	%eax, %r12d
	cmpl	$-1, %eax
	je	.L252
	movdqa	.LC92(%rip), %xmm0
	leaq	384(%rsp), %rdi
	movb	$0, 448(%rsp)
	movaps	%xmm0, 384(%rsp)
	movdqa	.LC93(%rip), %xmm0
	movaps	%xmm0, 400(%rsp)
	movdqa	.LC94(%rip), %xmm0
	movaps	%xmm0, 416(%rsp)
	movdqa	.LC95(%rip), %xmm0
	movaps	%xmm0, 432(%rsp)
	call	strlen@PLT
	leaq	384(%rsp), %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	call	write@PLT
	leaq	896(%rsp), %rdi
	call	strlen@PLT
	leaq	896(%rsp), %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	call	write@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	movl	%r12d, %ecx
	movq	%rbx, %rdx
	leaq	.LC91(%rip), %rsi
	call	log_message
	movq	5000(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L249
.L244:
	addq	$5016, %rsp
	movq	%rbp, %rdi
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L252:
	movq	%rbx, %rdx
	leaq	.LC90(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	log_message
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	call	write@PLT
	movq	5000(%rsp), %rax
	subq	%fs:40, %rax
	je	.L244
.L249:
	call	__stack_chk_fail@PLT
.L251:
	movl	%r13d, %edi
	call	send_500_error
	movq	5000(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L249
	addq	$5016, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.size	handle_exec_request, .-handle_exec_request
	.section	.rodata.str1.1
.LC96:
	.string	"/template/"
.LC97:
	.string	"/exec/"
.LC98:
	.string	"/index.html"
	.text
	.p2align 4
	.globl	handle_get_request
	.type	handle_get_request, @function
handle_get_request:
	pushq	%rbp
	movl	$10, %edx
	movl	%edi, %ebp
	pushq	%rbx
	movq	%rsi, %rbx
	leaq	.LC96(%rip), %rsi
	movq	%rbx, %rdi
	subq	$8, %rsp
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L260
	movl	$6, %edx
	leaq	.LC97(%rip), %rsi
	movq	%rbx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L255
	movq	%rbx, %rdi
	call	strlen@PLT
	cmpq	$6, %rax
	ja	.L261
.L255:
	cmpb	$47, (%rbx)
	jne	.L257
	cmpb	$0, 1(%rbx)
	jne	.L257
	addq	$8, %rsp
	movl	%ebp, %edi
	leaq	.LC98(%rip), %rsi
	popq	%rbx
	popq	%rbp
	jmp	serve_file
	.p2align 4,,10
	.p2align 3
.L257:
	addq	$8, %rsp
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	popq	%rbp
	jmp	serve_file
	.p2align 4,,10
	.p2align 3
.L260:
	addq	$8, %rsp
	leaq	9(%rbx), %rsi
	movl	%ebp, %edi
	popq	%rbx
	popq	%rbp
	jmp	handle_template_request
	.p2align 4,,10
	.p2align 3
.L261:
	addq	$8, %rsp
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	popq	%rbp
	jmp	handle_exec_request
	.size	handle_get_request, .-handle_get_request
	.section	.rodata.str1.1
.LC99:
	.string	"Empty request from %s"
.LC100:
	.string	"[%s] Request: %s"
.LC101:
	.string	" "
.LC102:
	.string	"Invalid HTTP request format"
	.section	.rodata.str1.8
	.align 8
.LC103:
	.string	"Path %s requires authentication"
	.section	.rodata.str1.1
.LC104:
	.string	"YES"
.LC105:
	.string	"Authentication required: %s"
.LC106:
	.string	"Authorization: Basic "
.LC107:
	.string	"NO"
.LC108:
	.string	"Auth attempt with token: %s"
.LC109:
	.string	"FAILED"
.LC110:
	.string	"Auth result: %s"
.LC111:
	.string	"SUCCESS"
.LC112:
	.string	"User authenticated for %s"
	.section	.rodata.str1.8
	.align 8
.LC113:
	.string	"Authentication required for %s"
	.section	.rodata.str1.1
.LC114:
	.string	"GET"
.LC115:
	.string	"POST"
.LC116:
	.string	"PUT"
.LC117:
	.string	"DELETE"
.LC118:
	.string	"Unsupported HTTP method: %s"
	.text
	.p2align 4
	.globl	handle_client
	.type	handle_client, @function
handle_client:
	pushq	%r15
	movl	$4095, %edx
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$8744, %rsp
	movl	%edi, 4(%rsp)
	movq	%fs:40, %rbp
	movq	%rbp, 8728(%rsp)
	movq	%rsi, %rbp
	leaq	528(%rsp), %rsi
	call	read@PLT
	testq	%rax, %rax
	jle	.L293
	leaq	16(%rsp), %rbx
	movl	$255, %edx
	movq	%rax, %r13
	movb	$0, 528(%rsp,%rax)
	leaq	528(%rsp), %rsi
	movq	%rbx, %rdi
	call	strncpy@PLT
	movl	$13, %esi
	movq	%rbx, %rdi
	movb	$0, 271(%rsp)
	call	strchr@PLT
	testq	%rax, %rax
	je	.L265
.L292:
	movb	$0, (%rax)
.L266:
	movq	%rbx, %rcx
	movq	%rbp, %rdx
	leaq	.LC100(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	leaq	1(%r13), %rdx
	leaq	4624(%rsp), %rdi
	leaq	528(%rsp), %rsi
	call	memcpy@PLT
	leaq	.LC101(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	leaq	.LC101(%rip), %rsi
	xorl	%edi, %edi
	movq	%rax, %r15
	call	strtok@PLT
	movq	%rax, %rbp
	testq	%r15, %r15
	je	.L267
	testq	%rax, %rax
	je	.L267
	movq	protected_paths(%rip), %rbx
	leaq	protected_paths(%rip), %r14
	testq	%rbx, %rbx
	jne	.L273
	jmp	.L269
	.p2align 4,,10
	.p2align 3
.L270:
	movq	8(%r14), %rbx
	addq	$8, %r14
	testq	%rbx, %rbx
	je	.L269
.L273:
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rdx
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L270
	movq	%rbp, %rdx
	leaq	.LC103(%rip), %rsi
	movl	$3, %edi
	call	log_message
	leaq	.LC105(%rip), %rsi
	xorl	%eax, %eax
	movl	$3, %edi
	leaq	.LC104(%rip), %rdx
	call	log_message
	leaq	.LC106(%rip), %rsi
	leaq	528(%rsp), %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L272
	leaq	21(%rax), %rbx
	leaq	.LC30(%rip), %rsi
	movq	%rbx, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L294
.L275:
	subq	%rbx, %rax
	movq	%rax, %rdx
	cmpq	$254, %rax
	jbe	.L295
.L272:
	call	create_auth_response@PLT
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	strlen@PLT
	movl	4(%rsp), %edi
	movq	%rbx, %rsi
	movq	%rax, %rdx
	call	write@PLT
	movq	%rbp, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	leaq	.LC113(%rip), %rsi
	call	log_message
.L262:
	movq	8728(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L296
	addq	$8744, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4,,10
	.p2align 3
.L269:
	leaq	.LC107(%rip), %rdx
	leaq	.LC105(%rip), %rsi
	movl	$3, %edi
	xorl	%eax, %eax
	call	log_message
.L274:
	leaq	.LC114(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L297
	leaq	.LC115(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L298
	leaq	.LC116(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L299
	leaq	.LC117(%rip), %rsi
	movq	%r15, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L281
	movl	4(%rsp), %edi
	movq	%r13, %rdx
	leaq	528(%rsp), %rsi
	call	handle_delete_request
	jmp	.L262
	.p2align 4,,10
	.p2align 3
.L293:
	movq	%rbp, %rdx
	leaq	.LC99(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
	jmp	.L262
	.p2align 4,,10
	.p2align 3
.L265:
	movl	$10, %esi
	movq	%rbx, %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L292
	jmp	.L266
	.p2align 4,,10
	.p2align 3
.L295:
	movq	%rbx, %rsi
	leaq	272(%rsp), %rdi
	movq	%rax, 8(%rsp)
	call	strncpy@PLT
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	movl	$3, %edi
	leaq	.LC108(%rip), %rsi
	movb	$0, 272(%rsp,%rdx)
	leaq	272(%rsp), %rdx
	call	log_message
	leaq	272(%rsp), %rdi
	call	authenticate_user@PLT
	testl	%eax, %eax
	jne	.L277
	leaq	.LC109(%rip), %rdx
	leaq	.LC110(%rip), %rsi
	movl	$3, %edi
	call	log_message
	jmp	.L272
	.p2align 4,,10
	.p2align 3
.L294:
	movl	$10, %esi
	movq	%rbx, %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L275
	jmp	.L272
	.p2align 4,,10
	.p2align 3
.L298:
	movl	4(%rsp), %edi
	movq	%r13, %rdx
	leaq	528(%rsp), %rsi
	call	handle_post_request
	jmp	.L262
	.p2align 4,,10
	.p2align 3
.L267:
	leaq	.LC102(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
	movl	4(%rsp), %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	jmp	.L262
	.p2align 4,,10
	.p2align 3
.L297:
	movl	4(%rsp), %edi
	movq	%rbp, %rsi
	call	handle_get_request
	jmp	.L262
	.p2align 4,,10
	.p2align 3
.L277:
	xorl	%eax, %eax
	leaq	.LC111(%rip), %rdx
	movl	$3, %edi
	leaq	.LC110(%rip), %rsi
	call	log_message
	movq	%rbp, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC112(%rip), %rsi
	call	log_message
	jmp	.L274
.L281:
	movq	%r15, %rdx
	leaq	.LC118(%rip), %rsi
	xorl	%eax, %eax
	movl	$1, %edi
	call	log_message
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movl	4(%rsp), %edi
	movq	%rbx, %rsi
	movq	%rax, %rdx
	call	write@PLT
	jmp	.L262
.L299:
	movl	4(%rsp), %edi
	movq	%r13, %rdx
	leaq	528(%rsp), %rsi
	call	handle_put_request
	jmp	.L262
.L296:
	call	__stack_chk_fail@PLT
	.size	handle_client, .-handle_client
	.section	.rodata.str1.8
	.align 8
.LC119:
	.string	"Invalid port number. Using default port %d"
	.align 8
.LC120:
	.string	"HTTP Server starting on port %d"
	.section	.rodata.str1.1
.LC121:
	.string	"Error creating socket: %s"
	.section	.rodata.str1.8
	.align 8
.LC122:
	.string	"Error setting socket options: %s"
	.section	.rodata.str1.1
.LC123:
	.string	"Error binding socket: %s"
.LC124:
	.string	"Error listening on socket: %s"
	.section	.rodata.str1.8
	.align 8
.LC125:
	.string	"Server ready to accept connections"
	.align 8
.LC126:
	.string	"Error accepting connection: %s"
	.align 8
.LC127:
	.string	"New connection accepted from %s"
	.section	.rodata.str1.1
.LC128:
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
	jg	.L319
.L301:
	movl	$6969, %ebx
.L302:
	movl	%ebx, %edx
	leaq	.LC120(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	xorl	%edx, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, server_socket(%rip)
	testl	%eax, %eax
	js	.L320
	leaq	8(%rsp), %rcx
	movl	$4, %r8d
	movl	$2, %edx
	movl	%eax, %edi
	movl	$1, %esi
	movl	$1, 8(%rsp)
	call	setsockopt@PLT
	testl	%eax, %eax
	js	.L321
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
	js	.L322
	movl	server_socket(%rip), %edi
	movl	$10, %esi
	call	listen@PLT
	testl	%eax, %eax
	js	.L323
	leaq	signal_handler(%rip), %rsi
	movl	$2, %edi
	leaq	48(%rsp), %rbp
	call	signal@PLT
	movl	$493, %esi
	leaq	.LC8(%rip), %rdi
	call	mkdir@PLT
	leaq	.LC125(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	.p2align 4
	.p2align 3
.L310:
	movl	server_socket(%rip), %edi
	leaq	12(%rsp), %rdx
	leaq	32(%rsp), %rsi
	movl	$16, 12(%rsp)
	call	accept@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L324
	movl	$16, %ecx
	movq	%rbp, %rdx
	leaq	36(%rsp), %rsi
	movl	$2, %edi
	call	inet_ntop@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	movq	%rbp, %rdx
	leaq	.LC127(%rip), %rsi
	call	log_message
	call	fork@PLT
	testl	%eax, %eax
	js	.L325
	je	.L326
	movl	%ebx, %edi
	call	close@PLT
	jmp	.L310
.L324:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC126(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	log_message
	jmp	.L310
.L325:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC128(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	log_message
	movl	%ebx, %edi
	call	close@PLT
	jmp	.L310
.L319:
	movq	8(%rbp), %rdi
	call	parse_port
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L302
	movl	$6969, %edx
	leaq	.LC119(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
	jmp	.L301
.L326:
	movl	server_socket(%rip), %edi
	call	close@PLT
	movq	%rbp, %rsi
	movl	%ebx, %edi
	call	handle_client
	movl	%ebx, %edi
	call	close@PLT
	xorl	%edi, %edi
	call	exit@PLT
.L320:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC121(%rip), %rsi
	movq	%rax, %rdx
.L318:
	movl	$2, %edi
	xorl	%eax, %eax
	call	log_message
	movl	log_config(%rip), %ecx
	testl	%ecx, %ecx
	je	.L305
	call	log_close.part.0
.L305:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L327
	addq	$80, %rsp
	movl	$1, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	ret
.L322:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC123(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L318
.L321:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC122(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L318
.L323:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC124(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L318
.L327:
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
.LC129:
	.string	"HTTP/1.1 500 Internal Server Error\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>500 Internal Server Error</h1></body></html>\r\n"
	.section	.data.rel.local,"aw"
	.align 8
	.type	http_500_response, @object
	.size	http_500_response, 8
http_500_response:
	.quad	.LC129
	.globl	http_404_response
	.section	.rodata.str1.8
	.align 8
.LC130:
	.string	"HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>404 Not Found</h1></body></html>\r\n"
	.section	.data.rel.local
	.align 8
	.type	http_404_response, @object
	.size	http_404_response, 8
http_404_response:
	.quad	.LC130
	.globl	http_200_header
	.align 8
	.type	http_200_header, @object
	.size	http_200_header, 8
http_200_header:
	.quad	.LC13
	.globl	protected_paths
	.section	.rodata.str1.1
.LC131:
	.string	"/private/"
.LC132:
	.string	"/admin/"
	.section	.data.rel.local
	.align 16
	.type	protected_paths, @object
	.size	protected_paths, 24
protected_paths:
	.quad	.LC131
	.quad	.LC132
	.quad	0
	.globl	log_config
	.section	.rodata.str1.1
.LC133:
	.string	"server.log"
	.section	.data.rel.local
	.align 16
	.type	log_config, @object
	.size	log_config, 24
log_config:
	.long	1
	.long	1
	.quad	.LC133
	.quad	0
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC92:
	.quad	3543824036068086856
	.quad	957946345412375072
	.align 16
.LC93:
	.quad	8389754706581209866
	.quad	8367752315007489069
	.align 16
.LC94:
	.quad	7593469675811666021
	.quad	7308900669414051182
	.align 16
.LC95:
	.quad	7142773254999602275
	.quad	724246167729434476
	.ident	"GCC: (GNU) 15.2.1 20250813"
	.section	.note.GNU-stack,"",@progbits
