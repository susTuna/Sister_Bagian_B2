	.text
	.p2align 4
	.type	log_close.part.0, @function
log_close.part.0:
.LFB38:
	.cfi_startproc
	movq	16+log_config(%rip), %rdi
	testq	%rdi, %rdi
	je	.L7
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	ret
	.cfi_endproc
.LFE38:
	.size	log_close.part.0, .-log_close.part.0
	.p2align 4
	.globl	strdup
	.type	strdup, @function
strdup:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strlen@PLT
	leaq	1(%rax), %rbx
	movq	%rbx, %rdi
	call	malloc@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L11
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	movq	%rax, %rcx
.L11:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rcx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE17:
	.size	strdup, .-strdup
	.p2align 4
	.globl	send_404_error
	.type	send_404_error, @function
send_404_error:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	http_404_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	.cfi_def_cfa_offset 16
	movq	%rax, %rdx
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	write@PLT
	.cfi_endproc
.LFE27:
	.size	send_404_error, .-send_404_error
	.p2align 4
	.globl	send_500_error
	.type	send_500_error, @function
send_500_error:
.LFB28:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	.cfi_def_cfa_offset 16
	movq	%rax, %rdx
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	write@PLT
	.cfi_endproc
.LFE28:
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
.LFB29:
	.cfi_startproc
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	jmp	write@PLT
	.cfi_endproc
.LFE29:
	.size	send_400_error, .-send_400_error
	.p2align 4
	.globl	extract_path
	.type	extract_path, @function
extract_path:
.LFB30:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	movl	$256, %edi
	call	malloc@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L22
	movzbl	(%rbx), %edx
	testb	$-33, %dl
	je	.L28
	cmpb	$63, %dl
	je	.L28
	movl	$1, %eax
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L45:
	cmpb	$63, %dl
	je	.L29
	addq	$1, %rax
	cmpq	$256, %rax
	je	.L44
.L27:
	movb	%dl, -1(%rcx,%rax)
	movzbl	(%rbx,%rax), %edx
	testb	$-33, %dl
	jne	.L45
.L29:
	cltq
	addq	%rcx, %rax
.L24:
	movb	$0, (%rax)
.L22:
	movq	%rcx, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L44:
	.cfi_restore_state
	leaq	255(%rcx), %rax
	jmp	.L24
.L28:
	movq	%rcx, %rax
	jmp	.L24
	.cfi_endproc
.LFE30:
	.size	extract_path, .-extract_path
	.p2align 4
	.globl	parse_port
	.type	parse_port, @function
parse_port:
.LFB31:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	leal	-1024(%rax), %edx
	cmpl	$64512, %edx
	movl	$0, %edx
	cmovnb	%rdx, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE31:
	.size	parse_port, .-parse_port
	.p2align 4
	.globl	log_close
	.type	log_close, @function
log_close:
.LFB34:
	.cfi_startproc
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L55
	movq	16+log_config(%rip), %rdi
	testq	%rdi, %rdi
	je	.L55
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L55:
	ret
	.cfi_endproc
.LFE34:
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
.LFB35:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8456, %rsp
	.cfi_def_cfa_offset 8496
	movq	%rdx, 8288(%rsp)
	movq	%rcx, 8296(%rsp)
	movq	%r8, 8304(%rsp)
	movq	%r9, 8312(%rsp)
	testb	%al, %al
	je	.L59
	movaps	%xmm0, 8320(%rsp)
	movaps	%xmm1, 8336(%rsp)
	movaps	%xmm2, 8352(%rsp)
	movaps	%xmm3, 8368(%rsp)
	movaps	%xmm4, 8384(%rsp)
	movaps	%xmm5, 8400(%rsp)
	movaps	%xmm6, 8416(%rsp)
	movaps	%xmm7, 8432(%rsp)
.L59:
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
	je	.L64
	leaq	.LC3(%rip), %rbx
	cmpl	$2, %ebp
	je	.L60
	leaq	.LC1(%rip), %rbx
	testl	%ebp, %ebp
	leaq	.LC4(%rip), %rax
	cmovne	%rax, %rbx
.L60:
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
	jne	.L72
.L61:
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L58
	movq	16+log_config(%rip), %rsi
	testq	%rsi, %rsi
	je	.L58
	leaq	4160(%rsp), %rdi
	call	fputs@PLT
	movq	16+log_config(%rip), %rdi
	call	fflush@PLT
.L58:
	movq	8264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L73
	addq	$8456, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L72:
	.cfi_restore_state
	leaq	4160(%rsp), %rsi
	leaq	.LC7(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	jmp	.L61
	.p2align 4,,10
	.p2align 3
.L64:
	leaq	.LC2(%rip), %rbx
	jmp	.L60
.L73:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE35:
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
.LFB20:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rsi, %r8
	leaq	.LC8(%rip), %rcx
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	leaq	.LC9(%rip), %rdx
	movl	$256, %esi
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$280, %rsp
	.cfi_def_cfa_offset 320
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
	je	.L82
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%rax, %rbp
	call	template_render@PLT
	movq	%rbp, %rdi
	movq	%rax, %rbx
	call	free@PLT
	testq	%rbx, %rbx
	je	.L83
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
.L74:
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L84
	addq	$280, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L82:
	.cfi_restore_state
	movq	%rsp, %rdx
	leaq	.LC11(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	log_message
	movq	http_404_response(%rip), %rbx
.L81:
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%r12d, %edi
	movq	%rax, %rdx
	call	write@PLT
	jmp	.L74
	.p2align 4,,10
	.p2align 3
.L83:
	leaq	.LC12(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	call	log_message
	movq	http_500_response(%rip), %rbx
	jmp	.L81
.L84:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE20:
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
.LFB21:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	%edi, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$104, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rbp
	movq	%rbp, 88(%rsp)
	movq	%rsi, %rbp
	call	template_create_context@PLT
	testq	%rax, %rax
	je	.L96
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
	je	.L88
	leaq	.LC20(%rip), %rdx
	leaq	.LC21(%rip), %rsi
	movq	%rbx, %rdi
	call	template_add_variable@PLT
	leaq	.LC22(%rip), %rdx
	leaq	.LC23(%rip), %rsi
	movq	%rbx, %rdi
	call	template_add_variable@PLT
.L89:
	movl	%r13d, %edi
	movq	%rbx, %rdx
	movq	%rbp, %rsi
	call	serve_template
	movq	%rbx, %rdi
	call	template_free_context@PLT
	movq	88(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L95
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L88:
	.cfi_restore_state
	leaq	.LC24(%rip), %rsi
	movq	%rbp, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L89
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
	jmp	.L89
	.p2align 4,,10
	.p2align 3
.L96:
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L95
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	write@PLT
.L95:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE21:
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
.LFB23:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movl	%edi, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	1(%rdx), %rbx
	movq	%rbx, %rdi
	subq	$280, %rsp
	.cfi_def_cfa_offset 336
	movq	%fs:40, %r12
	movq	%r12, 264(%rsp)
	movq	%rsi, %r12
	call	malloc@PLT
	testq	%rax, %rax
	je	.L120
	movq	%rax, %rbp
	movq	%r12, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	call	memcpy@PLT
	leaq	.LC30(%rip), %rsi
	movq	%rbp, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L115
	leaq	5(%rax), %rdi
	call	extract_path
	movq	%r12, %rdi
	leaq	.LC31(%rip), %rsi
	movq	%rax, %r14
	call	strstr@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L101
	testq	%r14, %r14
	je	.L115
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
	js	.L121
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
.L117:
	movl	%r13d, %edi
	call	write@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
.L97:
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L119
	addq	$280, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L115:
	.cfi_restore_state
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r13d, %edi
	call	write@PLT
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L119
	movq	%rbp, %rdi
.L118:
	addq	$280, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L121:
	.cfi_restore_state
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
	jmp	.L117
.L119:
	call	__stack_chk_fail@PLT
.L120:
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L119
	addq	$280, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r13d, %edi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	send_500_error
.L101:
	.cfi_restore_state
	movl	%r13d, %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	movq	%rbp, %rdi
	call	free@PLT
	testq	%r14, %r14
	je	.L97
	movq	264(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L119
	movq	%r14, %rdi
	jmp	.L118
	.cfi_endproc
.LFE23:
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
.LFB24:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leaq	1(%rdx), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rbp, %rdi
	subq	$440, %rsp
	.cfi_def_cfa_offset 496
	movq	%fs:40, %r13
	movq	%r13, 424(%rsp)
	movq	%rsi, %r13
	call	malloc@PLT
	testq	%rax, %rax
	je	.L151
	movq	%rax, %rbx
	movq	%r13, %rsi
	movq	%rax, %rdi
	movq	%rbp, %rdx
	call	memcpy@PLT
	leaq	.LC30(%rip), %rsi
	movq	%rbx, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L147
	leaq	4(%rax), %rdi
	call	extract_path
	leaq	.LC31(%rip), %rsi
	movq	%r13, %rdi
	movq	%rax, %r14
	call	strstr@PLT
	testq	%rax, %rax
	je	.L126
	leaq	4(%rax), %r13
	testq	%r14, %r14
	je	.L147
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
	jne	.L132
	movl	40(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	je	.L133
.L132:
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
	jns	.L134
.L138:
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
	jne	.L149
.L135:
	movq	%rbx, %rdi
.L150:
	addq	$440, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L134:
	.cfi_restore_state
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
.L137:
	movl	%r12d, %edi
	call	write@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
.L122:
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L149
	addq	$440, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L147:
	.cfi_restore_state
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r12d, %edi
	call	write@PLT
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	je	.L135
.L149:
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L133:
	movl	$420, %edx
	movl	$577, %esi
	movq	%rbp, %rdi
	xorl	%eax, %eax
	call	open@PLT
	movl	%eax, %r15d
	testl	%eax, %eax
	js	.L138
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
	jmp	.L137
.L151:
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L149
	addq	$440, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%r12d, %edi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	send_500_error
.L126:
	.cfi_restore_state
	movl	%r12d, %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	movq	%rbx, %rdi
	call	free@PLT
	testq	%r14, %r14
	je	.L122
	movq	424(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L149
	movq	%r14, %rdi
	jmp	.L150
	.cfi_endproc
.LFE24:
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
.LFB25:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	leaq	1(%rdx), %rbx
	movq	%rbx, %rdi
	subq	$296, %rsp
	.cfi_def_cfa_offset 336
	movq	%fs:40, %r13
	movq	%r13, 280(%rsp)
	movq	%rsi, %r13
	call	malloc@PLT
	testq	%rax, %rax
	je	.L172
	movq	%rax, %rbp
	movq	%r13, %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	call	memcpy@PLT
	leaq	.LC30(%rip), %rsi
	movq	%rbp, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L157
	leaq	7(%rax), %rdi
	call	extract_path
	movq	%rax, %r13
	testq	%rax, %rax
	je	.L157
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
	js	.L173
	leaq	16(%rsp), %rdx
	leaq	.LC42(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	movl	$123, %edx
	leaq	.LC43(%rip), %rsi
.L171:
	movl	%r12d, %edi
	call	write@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L169
.L162:
	addq	$296, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L157:
	.cfi_restore_state
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	movl	%r12d, %edi
	call	write@PLT
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	je	.L162
.L169:
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L173:
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
	je	.L174
	movq	http_500_response(%rip), %rbx
.L168:
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdx
	jmp	.L171
	.p2align 4,,10
	.p2align 3
.L174:
	movq	http_404_response(%rip), %rbx
	jmp	.L168
.L172:
	xorl	%eax, %eax
	leaq	.LC29(%rip), %rsi
	movl	$2, %edi
	call	log_message
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L169
	addq	$296, %rsp
	.cfi_def_cfa_offset 40
	movl	%r12d, %edi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	send_500_error
	.cfi_endproc
.LFE25:
	.size	handle_delete_request, .-handle_delete_request
	.section	.rodata.str1.1
.LC44:
	.string	"Shutting down server..."
	.text
	.p2align 4
	.globl	signal_handler
	.type	signal_handler, @function
signal_handler:
.LFB32:
	.cfi_startproc
	cmpl	$2, %edi
	je	.L184
	ret
	.p2align 4,,10
	.p2align 3
.L184:
	xorl	%eax, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC44(%rip), %rsi
	xorl	%edi, %edi
	call	log_message
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L177
	movq	16+log_config(%rip), %rdi
	testq	%rdi, %rdi
	je	.L177
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
.L177:
	movl	server_socket(%rip), %edi
	call	close@PLT
	xorl	%edi, %edi
	call	exit@PLT
	.cfi_endproc
.LFE32:
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
.LFB33:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	log_config(%rip), %edx
	testl	%edx, %edx
	jne	.L190
.L187:
	leaq	.LC47(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	log_message
	.p2align 4,,10
	.p2align 3
.L190:
	.cfi_restore_state
	movq	8+log_config(%rip), %rdi
	leaq	.LC45(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 16+log_config(%rip)
	testq	%rax, %rax
	jne	.L187
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
	jmp	.L187
	.cfi_endproc
.LFE33:
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
.LFB36:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$46, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strrchr@PLT
	testq	%rax, %rax
	je	.L193
	leaq	1(%rax), %rbx
	leaq	.LC65(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC52(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC66(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC67(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC50(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC68(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC51(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC69(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC49(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC70(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC71(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC53(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC72(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC54(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC73(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC55(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC74(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC56(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC75(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC57(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC76(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC58(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC77(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC59(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC78(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC60(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC79(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC61(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC80(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC62(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC81(%rip), %rsi
	movq	%rbx, %rdi
	leaq	.LC63(%rip), %rbp
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L191
	leaq	.LC82(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L212
	leaq	.LC83(%rip), %rsi
	movq	%rbx, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L193
.L212:
	leaq	.LC64(%rip), %rbp
.L191:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L193:
	.cfi_restore_state
	leaq	.LC48(%rip), %rbp
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE36:
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
.LFB26:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r8
	leaq	.LC8(%rip), %rcx
	movl	$256, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	.LC32(%rip), %rdx
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$5024, %rsp
	.cfi_def_cfa_offset 5056
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
	js	.L232
	movl	24(%rsp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	je	.L233
.L232:
	movq	%rbx, %rdx
	leaq	.LC84(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
.L241:
	movq	http_404_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%ebp, %edi
	movq	%rax, %rdx
	call	write@PLT
.L231:
	movq	5016(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L242
	addq	$5024, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L233:
	.cfi_restore_state
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
	js	.L243
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
	jmp	.L236
	.p2align 4,,10
	.p2align 3
.L237:
	movq	%rax, %rdx
	leaq	912(%rsp), %rsi
	movl	%ebp, %edi
	call	write@PLT
.L236:
	movl	$4096, %edx
	leaq	912(%rsp), %rsi
	movl	%r12d, %edi
	call	read@PLT
	testq	%rax, %rax
	jg	.L237
	movl	%r12d, %edi
	call	close@PLT
	jmp	.L231
	.p2align 4,,10
	.p2align 3
.L243:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	movq	%rbx, %rdx
	movl	$2, %edi
	leaq	.LC86(%rip), %rsi
	movq	%rax, %rcx
	xorl	%eax, %eax
	call	log_message
	jmp	.L241
.L242:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE26:
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
.LFB37:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	$16, %ecx
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	%edi, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	leaq	6(%rsi), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$5024, %rsp
	.cfi_def_cfa_offset 5072
	movq	%fs:40, %rax
	movq	%rax, 5016(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rdi
	rep stosq
	movq	%rbp, %rdi
	call	strlen@PLT
	leaq	1(%rax), %r14
	movq	%r14, %rdi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L257
	movq	%rax, %rbx
	movq	%rbp, %rsi
	movq	%rax, %rdi
	movq	%r14, %rdx
	call	memcpy@PLT
	movl	$63, %esi
	movq	%rbx, %rdi
	call	strchr@PLT
	testq	%rax, %rax
	je	.L247
	movb	$0, (%rax)
.L247:
	leaq	144(%rsp), %rbp
	movq	%rbx, %rcx
	movl	$256, %esi
	xorl	%eax, %eax
	leaq	.LC88(%rip), %rdx
	movq	%rbp, %rdi
	call	snprintf@PLT
	movq	%rbp, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC89(%rip), %rsi
	call	log_message
	movl	$4096, %ecx
	leaq	16(%rsp), %rsi
	movq	%rbp, %rdi
	leaq	912(%rsp), %rdx
	movq	%rbp, 16(%rsp)
	call	execute_binary@PLT
	movl	%eax, %r12d
	cmpl	$-1, %eax
	je	.L258
	movdqa	.LC92(%rip), %xmm0
	leaq	400(%rsp), %rsi
	movb	$0, 464(%rsp)
	movq	%rsi, %rdi
	movq	%rsi, 8(%rsp)
	movaps	%xmm0, 400(%rsp)
	movdqa	.LC93(%rip), %xmm0
	movaps	%xmm0, 416(%rsp)
	movdqa	.LC94(%rip), %xmm0
	movaps	%xmm0, 432(%rsp)
	movdqa	.LC95(%rip), %xmm0
	movaps	%xmm0, 448(%rsp)
	call	strlen@PLT
	movq	8(%rsp), %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	call	write@PLT
	leaq	912(%rsp), %rdi
	call	strlen@PLT
	leaq	912(%rsp), %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	call	write@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	movl	%r12d, %ecx
	movq	%rbp, %rdx
	leaq	.LC91(%rip), %rsi
	call	log_message
	movq	5016(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L255
.L250:
	addq	$5024, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L258:
	.cfi_restore_state
	movq	%rbp, %rdx
	leaq	.LC90(%rip), %rsi
	xorl	%eax, %eax
	movl	$2, %edi
	call	log_message
	movq	http_500_response(%rip), %rbp
	movq	%rbp, %rdi
	call	strlen@PLT
	movq	%rbp, %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	call	write@PLT
	movq	5016(%rsp), %rax
	subq	%fs:40, %rax
	je	.L250
.L255:
	call	__stack_chk_fail@PLT
	.p2align 4,,10
	.p2align 3
.L257:
	movq	http_500_response(%rip), %rbx
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movl	%r13d, %edi
	movq	%rax, %rdx
	call	write@PLT
	movq	5016(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L255
	addq	$5024, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE37:
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
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$10, %edx
	movl	%edi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	leaq	.LC96(%rip), %rsi
	movq	%rbx, %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L266
	movl	$6, %edx
	leaq	.LC97(%rip), %rsi
	movq	%rbx, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L261
	movq	%rbx, %rdi
	call	strlen@PLT
	cmpq	$6, %rax
	ja	.L267
.L261:
	cmpb	$47, (%rbx)
	jne	.L263
	cmpb	$0, 1(%rbx)
	jne	.L263
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebp, %edi
	leaq	.LC98(%rip), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	serve_file
	.p2align 4,,10
	.p2align 3
.L263:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	serve_file
	.p2align 4,,10
	.p2align 3
.L266:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	leaq	9(%rbx), %rsi
	movl	%ebp, %edi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	handle_template_request
	.p2align 4,,10
	.p2align 3
.L267:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rsi
	movl	%ebp, %edi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	handle_exec_request
	.cfi_endproc
.LFE22:
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
	.section	.rodata.str1.8
	.align 8
.LC106:
	.string	"Method %s requires authentication"
	.section	.rodata.str1.1
.LC107:
	.string	"NO"
.LC108:
	.string	"Authorization: Basic "
.LC109:
	.string	"Auth attempt with token: %s"
.LC110:
	.string	"FAILED"
.LC111:
	.string	"Auth result: %s"
.LC112:
	.string	"SUCCESS"
.LC113:
	.string	"User authenticated for %s"
	.section	.rodata.str1.8
	.align 8
.LC114:
	.string	"Authentication required for %s"
	.section	.rodata.str1.1
.LC115:
	.string	"GET"
.LC116:
	.string	"POST"
.LC117:
	.string	"PUT"
.LC118:
	.string	"DELETE"
.LC119:
	.string	"Unsupported HTTP method: %s"
	.text
	.p2align 4
	.globl	handle_client
	.type	handle_client, @function
handle_client:
.LFB19:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$4095, %edx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8744, %rsp
	.cfi_def_cfa_offset 8800
	movl	%edi, 4(%rsp)
	movq	%fs:40, %rbp
	movq	%rbp, 8728(%rsp)
	movq	%rsi, %rbp
	leaq	528(%rsp), %rsi
	call	read@PLT
	testq	%rax, %rax
	jle	.L317
	leaq	16(%rsp), %rbx
	movl	$255, %edx
	movq	%rax, %r14
	movb	$0, 528(%rsp,%rax)
	leaq	528(%rsp), %rsi
	movq	%rbx, %rdi
	call	strncpy@PLT
	movl	$13, %esi
	movq	%rbx, %rdi
	movb	$0, 271(%rsp)
	call	strchr@PLT
	testq	%rax, %rax
	je	.L271
.L315:
	movb	$0, (%rax)
.L272:
	movq	%rbx, %rcx
	movq	%rbp, %rdx
	leaq	.LC100(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	leaq	1(%r14), %rdx
	leaq	4624(%rsp), %rdi
	leaq	528(%rsp), %rsi
	call	memcpy@PLT
	leaq	.LC101(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	leaq	.LC101(%rip), %rsi
	xorl	%edi, %edi
	movq	%rax, %rbp
	call	strtok@PLT
	movq	%rax, %r12
	testq	%rbp, %rbp
	je	.L273
	testq	%rax, %rax
	je	.L273
	movq	protected_paths(%rip), %rbx
	leaq	protected_paths(%rip), %r15
	testq	%rbx, %rbx
	jne	.L279
	jmp	.L318
	.p2align 4,,10
	.p2align 3
.L276:
	movq	8(%r15), %rbx
	addq	$8, %r15
	testq	%rbx, %rbx
	je	.L319
.L279:
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%rbx, %rsi
	movq	%r12, %rdi
	movq	%rax, %rdx
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L276
	leaq	.LC103(%rip), %rsi
	movq	%r12, %rdx
	movl	$3, %edi
	movl	$1, %r15d
	call	log_message
	movq	protected_methods(%rip), %rsi
	testq	%rsi, %rsi
	je	.L316
.L277:
	leaq	protected_methods(%rip), %rbx
	jmp	.L283
	.p2align 4,,10
	.p2align 3
.L282:
	movq	8(%rbx), %rsi
	addq	$8, %rbx
	testq	%rsi, %rsi
	je	.L320
.L283:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L282
	movq	%rbp, %rdx
	leaq	.LC106(%rip), %rsi
	movl	$3, %edi
	call	log_message
.L316:
	leaq	.LC105(%rip), %rsi
	movl	$3, %edi
	xorl	%eax, %eax
	leaq	.LC104(%rip), %rdx
	call	log_message
	leaq	.LC108(%rip), %rsi
	leaq	528(%rsp), %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L286
	leaq	21(%rax), %rbx
	leaq	.LC30(%rip), %rsi
	movq	%rbx, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L321
.L287:
	subq	%rbx, %rax
	movq	%rax, %rdx
	cmpq	$254, %rax
	jbe	.L322
.L286:
	call	create_auth_response@PLT
	movq	%rax, %rdi
	movq	%rax, %rbx
	call	strlen@PLT
	movl	4(%rsp), %edi
	movq	%rbx, %rsi
	movq	%rax, %rdx
	call	write@PLT
	movq	%r12, %rdx
	movl	$1, %edi
	xorl	%eax, %eax
	leaq	.LC114(%rip), %rsi
	call	log_message
.L268:
	movq	8728(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L323
	addq	$8744, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L320:
	.cfi_restore_state
	testl	%r15d, %r15d
	jne	.L316
.L281:
	leaq	.LC107(%rip), %rdx
	leaq	.LC105(%rip), %rsi
	movl	$3, %edi
	xorl	%eax, %eax
	call	log_message
.L285:
	leaq	.LC115(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L324
	leaq	.LC116(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L325
	leaq	.LC117(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L326
	leaq	.LC118(%rip), %rsi
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L293
	movl	4(%rsp), %edi
	movq	%r14, %rdx
	leaq	528(%rsp), %rsi
	call	handle_delete_request
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L319:
	movq	protected_methods(%rip), %rsi
	testq	%rsi, %rsi
	je	.L281
	xorl	%r15d, %r15d
	jmp	.L277
	.p2align 4,,10
	.p2align 3
.L317:
	movq	%rbp, %rdx
	leaq	.LC99(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L271:
	movl	$10, %esi
	movq	%rbx, %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L315
	jmp	.L272
	.p2align 4,,10
	.p2align 3
.L322:
	movq	%rbx, %rsi
	leaq	272(%rsp), %rdi
	movq	%rax, 8(%rsp)
	call	strncpy@PLT
	movq	8(%rsp), %rdx
	xorl	%eax, %eax
	movl	$3, %edi
	leaq	.LC109(%rip), %rsi
	movb	$0, 272(%rsp,%rdx)
	leaq	272(%rsp), %rdx
	call	log_message
	leaq	272(%rsp), %rdi
	call	authenticate_user@PLT
	testl	%eax, %eax
	jne	.L289
	leaq	.LC110(%rip), %rdx
	leaq	.LC111(%rip), %rsi
	movl	$3, %edi
	call	log_message
	jmp	.L286
	.p2align 4,,10
	.p2align 3
.L321:
	movl	$10, %esi
	movq	%rbx, %rdi
	call	strchr@PLT
	testq	%rax, %rax
	jne	.L287
	jmp	.L286
	.p2align 4,,10
	.p2align 3
.L273:
	leaq	.LC102(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
	movl	4(%rsp), %edi
	movl	$124, %edx
	leaq	.LC0(%rip), %rsi
	call	write@PLT
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L324:
	movl	4(%rsp), %edi
	movq	%r12, %rsi
	call	handle_get_request
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L325:
	movl	4(%rsp), %edi
	movq	%r14, %rdx
	leaq	528(%rsp), %rsi
	call	handle_post_request
	jmp	.L268
	.p2align 4,,10
	.p2align 3
.L289:
	xorl	%eax, %eax
	leaq	.LC112(%rip), %rdx
	movl	$3, %edi
	leaq	.LC111(%rip), %rsi
	call	log_message
	movq	%r12, %rdx
	xorl	%edi, %edi
	xorl	%eax, %eax
	leaq	.LC113(%rip), %rsi
	call	log_message
	jmp	.L285
.L293:
	movq	%rbp, %rdx
	leaq	.LC119(%rip), %rsi
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
	jmp	.L268
.L326:
	movl	4(%rsp), %edi
	movq	%r14, %rdx
	leaq	528(%rsp), %rsi
	call	handle_put_request
	jmp	.L268
.L318:
	movq	protected_methods(%rip), %rsi
	xorl	%r15d, %r15d
	testq	%rsi, %rsi
	jne	.L277
	jmp	.L281
.L323:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE19:
	.size	handle_client, .-handle_client
	.section	.rodata.str1.8
	.align 8
.LC120:
	.string	"Invalid port number. Using default port %d"
	.align 8
.LC121:
	.string	"HTTP Server starting on port %d"
	.section	.rodata.str1.1
.LC122:
	.string	"Error creating socket: %s"
	.section	.rodata.str1.8
	.align 8
.LC123:
	.string	"Error setting socket options: %s"
	.section	.rodata.str1.1
.LC124:
	.string	"Error binding socket: %s"
.LC125:
	.string	"Error listening on socket: %s"
	.section	.rodata.str1.8
	.align 8
.LC126:
	.string	"Server ready to accept connections"
	.align 8
.LC127:
	.string	"Error accepting connection: %s"
	.align 8
.LC128:
	.string	"New connection accepted from %s"
	.section	.rodata.str1.1
.LC129:
	.string	"Error forking process: %s"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB18:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movl	%edi, %ebx
	subq	$80, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rbp
	movq	%rbp, 72(%rsp)
	movq	%rsi, %rbp
	call	log_init
	cmpl	$1, %ebx
	jg	.L346
.L328:
	movl	$6969, %ebx
.L329:
	movl	%ebx, %edx
	leaq	.LC121(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	xorl	%edx, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, server_socket(%rip)
	testl	%eax, %eax
	js	.L347
	leaq	8(%rsp), %rcx
	movl	$4, %r8d
	movl	$2, %edx
	movl	%eax, %edi
	movl	$1, %esi
	movl	$1, 8(%rsp)
	call	setsockopt@PLT
	testl	%eax, %eax
	js	.L348
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
	js	.L349
	movl	server_socket(%rip), %edi
	movl	$10, %esi
	call	listen@PLT
	testl	%eax, %eax
	js	.L350
	leaq	signal_handler(%rip), %rsi
	movl	$2, %edi
	leaq	48(%rsp), %rbp
	call	__sysv_signal@PLT
	movl	$493, %esi
	leaq	.LC8(%rip), %rdi
	call	mkdir@PLT
	leaq	.LC126(%rip), %rsi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	log_message
	.p2align 4
	.p2align 3
.L337:
	movl	server_socket(%rip), %edi
	leaq	12(%rsp), %rdx
	leaq	32(%rsp), %rsi
	movl	$16, 12(%rsp)
	call	accept@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	js	.L351
	movl	$16, %ecx
	movq	%rbp, %rdx
	leaq	36(%rsp), %rsi
	movl	$2, %edi
	call	inet_ntop@PLT
	xorl	%edi, %edi
	xorl	%eax, %eax
	movq	%rbp, %rdx
	leaq	.LC128(%rip), %rsi
	call	log_message
	call	fork@PLT
	testl	%eax, %eax
	js	.L352
	je	.L353
	movl	%ebx, %edi
	call	close@PLT
	jmp	.L337
.L351:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC127(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	log_message
	jmp	.L337
.L352:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC129(%rip), %rsi
	movl	$2, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	log_message
	movl	%ebx, %edi
	call	close@PLT
	jmp	.L337
.L346:
	movq	8(%rbp), %rdi
	call	parse_port
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L329
	movl	$6969, %edx
	leaq	.LC120(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	call	log_message
	jmp	.L328
.L353:
	movl	server_socket(%rip), %edi
	call	close@PLT
	movq	%rbp, %rsi
	movl	%ebx, %edi
	call	handle_client
	movl	%ebx, %edi
	call	close@PLT
	xorl	%edi, %edi
	call	exit@PLT
.L347:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC122(%rip), %rsi
	movq	%rax, %rdx
.L345:
	movl	$2, %edi
	xorl	%eax, %eax
	call	log_message
	movl	log_config(%rip), %ecx
	testl	%ecx, %ecx
	je	.L332
	call	log_close.part.0
.L332:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L354
	addq	$80, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L349:
	.cfi_restore_state
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC124(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L345
.L348:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC123(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L345
.L350:
	call	__errno_location@PLT
	movl	(%rax), %edi
	call	strerror@PLT
	leaq	.LC125(%rip), %rsi
	movq	%rax, %rdx
	jmp	.L345
.L354:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE18:
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
.LC130:
	.string	"HTTP/1.1 500 Internal Server Error\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>500 Internal Server Error</h1></body></html>\r\n"
	.section	.data.rel.local,"aw"
	.align 8
	.type	http_500_response, @object
	.size	http_500_response, 8
http_500_response:
	.quad	.LC130
	.globl	http_404_response
	.section	.rodata.str1.8
	.align 8
.LC131:
	.string	"HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>404 Not Found</h1></body></html>\r\n"
	.section	.data.rel.local
	.align 8
	.type	http_404_response, @object
	.size	http_404_response, 8
http_404_response:
	.quad	.LC131
	.globl	http_200_header
	.align 8
	.type	http_200_header, @object
	.size	http_200_header, 8
http_200_header:
	.quad	.LC13
	.globl	protected_methods
	.align 32
	.type	protected_methods, @object
	.size	protected_methods, 32
protected_methods:
	.quad	.LC116
	.quad	.LC117
	.quad	.LC118
	.quad	0
	.globl	protected_paths
	.section	.rodata.str1.1
.LC132:
	.string	"/private/"
.LC133:
	.string	"/admin/"
	.section	.data.rel.local
	.align 16
	.type	protected_paths, @object
	.size	protected_paths, 24
protected_paths:
	.quad	.LC132
	.quad	.LC133
	.quad	0
	.globl	log_config
	.section	.rodata.str1.1
.LC134:
	.string	"server.log"
	.section	.data.rel.local
	.align 16
	.type	log_config, @object
	.size	log_config, 24
log_config:
	.long	1
	.long	1
	.quad	.LC134
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
