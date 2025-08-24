	.globl	log_config
	.section	.rodata
.LC0:
	.string	"server.log"
	.section	.data.rel.local,"aw"
	.align 16
	.type	log_config, @object
	.size	log_config, 24
log_config:
	.long	1
	.long	1
	.quad	.LC0
	.quad	0
	.globl	http_200_header
	.section	.rodata
	.align 8
.LC1:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nConnection: close\r\n\r\n"
	.section	.data.rel.local
	.align 8
	.type	http_200_header, @object
	.size	http_200_header, 8
http_200_header:
	.quad	.LC1
	.globl	http_404_response
	.section	.rodata
	.align 8
.LC2:
	.string	"HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>404 Not Found</h1></body></html>\r\n"
	.section	.data.rel.local
	.align 8
	.type	http_404_response, @object
	.size	http_404_response, 8
http_404_response:
	.quad	.LC2
	.globl	http_500_response
	.section	.rodata
	.align 8
.LC3:
	.string	"HTTP/1.1 500 Internal Server Error\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>500 Internal Server Error</h1></body></html>\r\n"
	.section	.data.rel.local
	.align 8
	.type	http_500_response, @object
	.size	http_500_response, 8
http_500_response:
	.quad	.LC3
	.globl	server_socket
	.bss
	.align 4
	.type	server_socket, @object
	.size	server_socket, 4
server_socket:
	.zero	4
	.section	.rodata
	.align 8
.LC4:
	.string	"Invalid port number. Using default port %d"
	.align 8
.LC5:
	.string	"HTTP Server starting on port %d"
.LC6:
	.string	"Error creating socket: %s"
	.align 8
.LC7:
	.string	"Error setting socket options: %s"
.LC8:
	.string	"Error binding socket: %s"
.LC9:
	.string	"Error listening on socket: %s"
.LC10:
	.string	"./www"
	.align 8
.LC11:
	.string	"Server ready to accept connections"
	.align 8
.LC12:
	.string	"Error accepting connection: %s"
	.align 8
.LC13:
	.string	"New connection accepted from %s"
.LC14:
	.string	"Error forking process: %s"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$6969, -76(%rbp)
	call	log_init
	cmpl	$1, -100(%rbp)
	jle	.L2
	movq	-112(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	parse_port
	movl	%eax, -76(%rbp)
	cmpl	$0, -76(%rbp)
	jne	.L2
	leaq	.LC4(%rip), %rax
	movl	$6969, %edx
	movq	%rax, %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	log_message
	movl	$6969, -76(%rbp)
.L2:
	movl	-76(%rbp), %eax
	leaq	.LC5(%rip), %rcx
	movl	%eax, %edx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, server_socket(%rip)
	movl	server_socket(%rip), %eax
	testl	%eax, %eax
	jns	.L3
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	.LC6(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	call	log_close
	movl	$1, %eax
	jmp	.L14
.L3:
	movl	$1, -84(%rbp)
	movl	server_socket(%rip), %eax
	leaq	-84(%rbp), %rdx
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt@PLT
	testl	%eax, %eax
	jns	.L5
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	.LC7(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	call	log_close
	movl	$1, %eax
	jmp	.L14
.L5:
	leaq	-64(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movw	$2, -64(%rbp)
	movl	$0, %edi
	call	htonl@PLT
	movl	%eax, -60(%rbp)
	movl	-76(%rbp), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	htons@PLT
	movw	%ax, -62(%rbp)
	movl	server_socket(%rip), %eax
	leaq	-64(%rbp), %rcx
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind@PLT
	testl	%eax, %eax
	jns	.L6
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	call	log_close
	movl	$1, %eax
	jmp	.L14
.L6:
	movl	server_socket(%rip), %eax
	movl	$10, %esi
	movl	%eax, %edi
	call	listen@PLT
	testl	%eax, %eax
	jns	.L7
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	.LC9(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	call	log_close
	movl	$1, %eax
	jmp	.L14
.L7:
	leaq	signal_handler(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	signal@PLT
	leaq	.LC10(%rip), %rax
	movl	$493, %esi
	movq	%rax, %rdi
	call	mkdir@PLT
	leaq	.LC11(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
.L13:
	movl	$16, -80(%rbp)
	movl	server_socket(%rip), %eax
	leaq	-80(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept@PLT
	movl	%eax, -72(%rbp)
	cmpl	$0, -72(%rbp)
	jns	.L8
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	.LC12(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	jmp	.L12
.L8:
	leaq	-32(%rbp), %rax
	leaq	-48(%rbp), %rdx
	leaq	4(%rdx), %rsi
	movl	$16, %ecx
	movq	%rax, %rdx
	movl	$2, %edi
	call	inet_ntop@PLT
	leaq	-32(%rbp), %rax
	leaq	.LC13(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	call	fork@PLT
	movl	%eax, -68(%rbp)
	cmpl	$0, -68(%rbp)
	jns	.L10
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	.LC14(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-72(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	jmp	.L12
.L10:
	cmpl	$0, -68(%rbp)
	jne	.L11
	movl	server_socket(%rip), %eax
	movl	%eax, %edi
	call	close@PLT
	leaq	-32(%rbp), %rdx
	movl	-72(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	handle_client
	movl	-72(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$0, %edi
	call	exit@PLT
.L11:
	movl	-72(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
.L12:
	jmp	.L13
.L14:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L15
	call	__stack_chk_fail@PLT
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
.LC15:
	.string	"Empty request from %s"
.LC16:
	.string	"[%s] Request: %s"
.LC17:
	.string	"GET "
.LC18:
	.string	"[%s] GET %s"
.LC19:
	.string	"POST "
.LC20:
	.string	"[%s] POST %s"
.LC21:
	.string	"PUT "
.LC22:
	.string	"[%s] PUT %s"
.LC23:
	.string	"DELETE "
.LC24:
	.string	"[%s] DELETE %s"
.LC25:
	.string	"EXEC "
.LC26:
	.string	"[%s] EXEC %s"
.LC27:
	.string	"[%s] Unknown HTTP method"
	.text
	.globl	handle_client
	.type	handle_client, @function
handle_client:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8544, %rsp
	movl	%edi, -8532(%rbp)
	movq	%rsi, -8544(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-8208(%rbp), %rcx
	movl	-8532(%rbp), %eax
	movl	$4095, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -8520(%rbp)
	cmpq	$0, -8520(%rbp)
	jg	.L17
	movq	-8544(%rbp), %rax
	leaq	.LC15(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	log_message
	jmp	.L16
.L17:
	leaq	-8208(%rbp), %rdx
	movq	-8520(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	leaq	-8208(%rbp), %rcx
	leaq	-8464(%rbp), %rax
	movl	$255, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncpy@PLT
	movb	$0, -8209(%rbp)
	leaq	-8464(%rbp), %rax
	movl	$13, %esi
	movq	%rax, %rdi
	call	strchr@PLT
	movq	%rax, -8512(%rbp)
	cmpq	$0, -8512(%rbp)
	je	.L19
	movq	-8512(%rbp), %rax
	movb	$0, (%rax)
	jmp	.L20
.L19:
	leaq	-8464(%rbp), %rax
	movl	$10, %esi
	movq	%rax, %rdi
	call	strchr@PLT
	movq	%rax, -8512(%rbp)
	cmpq	$0, -8512(%rbp)
	je	.L20
	movq	-8512(%rbp), %rax
	movb	$0, (%rax)
.L20:
	movq	-8520(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rdx
	leaq	-8208(%rbp), %rcx
	leaq	-4112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	leaq	-8464(%rbp), %rdx
	movq	-8544(%rbp), %rax
	leaq	.LC16(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	.LC17(%rip), %rcx
	leaq	-8208(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L21
	leaq	-8208(%rbp), %rax
	addq	$4, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -8472(%rbp)
	movq	-8472(%rbp), %rdx
	movq	-8544(%rbp), %rax
	leaq	.LC18(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	movq	-8472(%rbp), %rdx
	movl	-8532(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	handle_get_request
	movq	-8472(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L16
.L21:
	leaq	.LC19(%rip), %rcx
	leaq	-8208(%rbp), %rax
	movl	$5, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L23
	leaq	-8208(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -8480(%rbp)
	movq	-8480(%rbp), %rdx
	movq	-8544(%rbp), %rax
	leaq	.LC20(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	movq	-8520(%rbp), %rdx
	leaq	-4112(%rbp), %rcx
	movl	-8532(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	handle_post_request
	movq	-8480(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L16
.L23:
	leaq	.LC21(%rip), %rcx
	leaq	-8208(%rbp), %rax
	movl	$4, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L24
	leaq	-8208(%rbp), %rax
	addq	$4, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -8488(%rbp)
	movq	-8488(%rbp), %rdx
	movq	-8544(%rbp), %rax
	leaq	.LC22(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	movq	-8520(%rbp), %rdx
	leaq	-4112(%rbp), %rcx
	movl	-8532(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	handle_put_request
	movq	-8488(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L16
.L24:
	leaq	.LC23(%rip), %rcx
	leaq	-8208(%rbp), %rax
	movl	$7, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L25
	leaq	-8208(%rbp), %rax
	addq	$7, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -8496(%rbp)
	movq	-8496(%rbp), %rdx
	movq	-8544(%rbp), %rax
	leaq	.LC24(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	movq	-8520(%rbp), %rdx
	leaq	-4112(%rbp), %rcx
	movl	-8532(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	handle_delete_request
	movq	-8496(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L16
.L25:
	leaq	.LC25(%rip), %rcx
	leaq	-8208(%rbp), %rax
	movl	$5, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	jne	.L26
	leaq	-8208(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -8504(%rbp)
	movq	-8504(%rbp), %rdx
	movq	-8544(%rbp), %rax
	leaq	.LC26(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	movq	-8504(%rbp), %rdx
	movl	-8532(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	handle_exec_request
	movq	-8504(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L16
.L26:
	movq	-8544(%rbp), %rax
	leaq	.LC27(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	log_message
	movl	-8532(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
.L16:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L27
	call	__stack_chk_fail@PLT
.L27:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	handle_client, .-handle_client
	.section	.rodata
.LC28:
	.string	"/"
.LC29:
	.string	"/index.html"
	.text
	.globl	handle_get_request
	.type	handle_get_request, @function
handle_get_request:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	.LC28(%rip), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L29
	leaq	.LC29(%rip), %rdx
	movl	-4(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	serve_file
	jmp	.L31
.L29:
	movq	-16(%rbp), %rdx
	movl	-4(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	serve_file
.L31:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	handle_get_request, .-handle_get_request
	.section	.rodata
.LC30:
	.string	"Memory allocation failed"
.LC31:
	.string	"\r\n"
.LC32:
	.string	"\r\n\r\n"
.LC33:
	.string	"%s%s"
.LC34:
	.string	"Creating file: %s"
	.align 8
.LC35:
	.string	"Failed to create file: %s - %s"
.LC36:
	.string	"File created: %s"
	.align 8
.LC37:
	.string	"HTTP/1.1 201 Created\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>File created successfully</h1></body></html>"
	.text
	.globl	handle_post_request
	.type	handle_post_request, @function
handle_post_request:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$352, %rsp
	movl	%edi, -324(%rbp)
	movq	%rsi, -336(%rbp)
	movq	%rdx, -344(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -312(%rbp)
	movq	$0, -304(%rbp)
	movq	-344(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -296(%rbp)
	cmpq	$0, -296(%rbp)
	jne	.L33
	leaq	.LC30(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-324(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
	jmp	.L32
.L33:
	movq	-344(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rdx
	movq	-336(%rbp), %rcx
	movq	-296(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	leaq	.LC31(%rip), %rdx
	movq	-296(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -288(%rbp)
	cmpq	$0, -288(%rbp)
	je	.L35
	movq	-288(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -312(%rbp)
.L35:
	leaq	.LC32(%rip), %rdx
	movq	-336(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	movq	%rax, -304(%rbp)
	cmpq	$0, -304(%rbp)
	je	.L36
	addq	$4, -304(%rbp)
.L36:
	cmpq	$0, -312(%rbp)
	je	.L37
	cmpq	$0, -304(%rbp)
	jne	.L38
.L37:
	movl	-324(%rbp), %eax
	movl	%eax, %edi
	call	send_400_error
	movq	-296(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	cmpq	$0, -312(%rbp)
	je	.L43
	movq	-312(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L43
.L38:
	movq	-312(%rbp), %rsi
	leaq	.LC10(%rip), %rcx
	leaq	.LC33(%rip), %rdx
	leaq	-272(%rbp), %rax
	movq	%rsi, %r8
	movl	$256, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-272(%rbp), %rax
	leaq	.LC34(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	-272(%rbp), %rax
	movl	$420, %edx
	movl	$577, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -316(%rbp)
	cmpl	$0, -316(%rbp)
	jns	.L40
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	-272(%rbp), %rax
	leaq	.LC35(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-324(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
	movq	-296(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-312(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L32
.L40:
	movq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-304(%rbp), %rcx
	movl	-316(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movl	-316(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	leaq	-272(%rbp), %rax
	leaq	.LC36(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	.LC37(%rip), %rax
	movq	%rax, -280(%rbp)
	movq	-280(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-280(%rbp), %rcx
	movl	-324(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movq	-296(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-312(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L32
.L43:
	nop
.L32:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L42
	call	__stack_chk_fail@PLT
.L42:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	handle_post_request, .-handle_post_request
	.section	.rodata
	.align 8
.LC38:
	.string	"Failed to open/create file: %s - %s"
.LC39:
	.string	"File updated: %s"
	.align 8
.LC40:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>File updated successfully</h1></body></html>"
	.text
	.globl	handle_put_request
	.type	handle_put_request, @function
handle_put_request:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$496, %rsp
	movl	%edi, -468(%rbp)
	movq	%rsi, -480(%rbp)
	movq	%rdx, -488(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -456(%rbp)
	movq	$0, -448(%rbp)
	movq	-488(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -432(%rbp)
	cmpq	$0, -432(%rbp)
	jne	.L45
	leaq	.LC30(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-468(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
	jmp	.L44
.L45:
	movq	-488(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rdx
	movq	-480(%rbp), %rcx
	movq	-432(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	leaq	.LC31(%rip), %rdx
	movq	-432(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -424(%rbp)
	cmpq	$0, -424(%rbp)
	je	.L47
	movq	-424(%rbp), %rax
	addq	$4, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -456(%rbp)
.L47:
	leaq	.LC32(%rip), %rdx
	movq	-480(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	movq	%rax, -448(%rbp)
	cmpq	$0, -448(%rbp)
	je	.L48
	addq	$4, -448(%rbp)
.L48:
	cmpq	$0, -456(%rbp)
	je	.L49
	cmpq	$0, -448(%rbp)
	jne	.L50
.L49:
	movl	-468(%rbp), %eax
	movl	%eax, %edi
	call	send_400_error
	movq	-432(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	cmpq	$0, -456(%rbp)
	je	.L60
	movq	-456(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L60
.L50:
	movq	-456(%rbp), %rsi
	leaq	.LC10(%rip), %rcx
	leaq	.LC33(%rip), %rdx
	leaq	-272(%rbp), %rax
	movq	%rsi, %r8
	movl	$256, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-416(%rbp), %rdx
	leaq	-272(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stat@PLT
	testl	%eax, %eax
	jne	.L52
	movl	-392(%rbp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	jne	.L52
	movl	$1, %eax
	jmp	.L53
.L52:
	movl	$0, %eax
.L53:
	movl	%eax, -464(%rbp)
	cmpl	$0, -464(%rbp)
	jne	.L54
	leaq	-272(%rbp), %rax
	leaq	.LC34(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
.L54:
	leaq	-272(%rbp), %rax
	movl	$420, %edx
	movl	$577, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -460(%rbp)
	cmpl	$0, -460(%rbp)
	jns	.L55
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	-272(%rbp), %rax
	leaq	.LC38(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-468(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
	movq	-456(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-432(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L44
.L55:
	movq	-448(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-448(%rbp), %rcx
	movl	-460(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movl	-460(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	cmpl	$0, -464(%rbp)
	je	.L56
	leaq	-272(%rbp), %rax
	leaq	.LC39(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	.LC40(%rip), %rax
	movq	%rax, -440(%rbp)
	jmp	.L57
.L56:
	leaq	-272(%rbp), %rax
	leaq	.LC36(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	.LC37(%rip), %rax
	movq	%rax, -440(%rbp)
.L57:
	movq	-440(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-440(%rbp), %rcx
	movl	-468(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movq	-432(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-456(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L44
.L60:
	nop
.L44:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L59
	call	__stack_chk_fail@PLT
.L59:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	handle_put_request, .-handle_put_request
	.section	.rodata
.LC41:
	.string	"Deleting file: %s"
	.align 8
.LC42:
	.string	"Failed to delete file: %s - %s"
.LC43:
	.string	"File deleted: %s"
	.align 8
.LC44:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>File deleted successfully</h1></body></html>"
	.text
	.globl	handle_delete_request
	.type	handle_delete_request, @function
handle_delete_request:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$336, %rsp
	movl	%edi, -308(%rbp)
	movq	%rsi, -320(%rbp)
	movq	%rdx, -328(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -304(%rbp)
	movq	-328(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -296(%rbp)
	cmpq	$0, -296(%rbp)
	jne	.L62
	leaq	.LC30(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-308(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
	jmp	.L61
.L62:
	movq	-328(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rdx
	movq	-320(%rbp), %rcx
	movq	-296(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	leaq	.LC31(%rip), %rdx
	movq	-296(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -288(%rbp)
	cmpq	$0, -288(%rbp)
	je	.L64
	movq	-288(%rbp), %rax
	addq	$7, %rax
	movq	%rax, %rdi
	call	extract_path
	movq	%rax, -304(%rbp)
.L64:
	cmpq	$0, -304(%rbp)
	jne	.L65
	movl	-308(%rbp), %eax
	movl	%eax, %edi
	call	send_400_error
	movq	-296(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	cmpq	$0, -304(%rbp)
	je	.L72
	movq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L72
.L65:
	movq	-304(%rbp), %rsi
	leaq	.LC10(%rip), %rcx
	leaq	.LC33(%rip), %rdx
	leaq	-272(%rbp), %rax
	movq	%rsi, %r8
	movl	$256, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-272(%rbp), %rax
	leaq	.LC41(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	unlink@PLT
	testl	%eax, %eax
	jns	.L67
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	-272(%rbp), %rax
	leaq	.LC42(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	call	__errno_location@PLT
	movl	(%rax), %eax
	cmpl	$2, %eax
	jne	.L68
	movl	-308(%rbp), %eax
	movl	%eax, %edi
	call	send_404_error
	jmp	.L69
.L68:
	movl	-308(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
.L69:
	movq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-296(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L61
.L67:
	leaq	-272(%rbp), %rax
	leaq	.LC43(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	.LC44(%rip), %rax
	movq	%rax, -280(%rbp)
	movq	-280(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-280(%rbp), %rcx
	movl	-308(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-296(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L61
.L72:
	nop
.L61:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L71
	call	__stack_chk_fail@PLT
.L71:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	handle_delete_request, .-handle_delete_request
	.section	.rodata
.LC45:
	.string	"File not found: %s"
.LC46:
	.string	"Serving file: %s (%ld bytes)"
.LC47:
	.string	"Failed to open file: %s - %s"
	.align 8
.LC48:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: %s\r\nContent-Length: %ld\r\nConnection: close\r\n\r\n"
	.text
	.globl	serve_file
	.type	serve_file, @function
serve_file:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$5072, %rsp
	movl	%edi, -5060(%rbp)
	movq	%rsi, -5072(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-5072(%rbp), %rsi
	leaq	.LC10(%rip), %rcx
	leaq	.LC33(%rip), %rdx
	leaq	-4880(%rbp), %rax
	movq	%rsi, %r8
	movl	$256, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-5024(%rbp), %rdx
	leaq	-4880(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stat@PLT
	testl	%eax, %eax
	js	.L74
	movl	-5000(%rbp), %eax
	andl	$61440, %eax
	cmpl	$32768, %eax
	je	.L75
.L74:
	leaq	-4880(%rbp), %rax
	leaq	.LC45(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	log_message
	movl	-5060(%rbp), %eax
	movl	%eax, %edi
	call	send_404_error
	jmp	.L73
.L75:
	movq	-4976(%rbp), %rdx
	leaq	-4880(%rbp), %rax
	leaq	.LC46(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	-4880(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -5044(%rbp)
	cmpl	$0, -5044(%rbp)
	jns	.L77
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	leaq	-4880(%rbp), %rax
	leaq	.LC47(%rip), %rsi
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-5060(%rbp), %eax
	movl	%eax, %edi
	call	send_404_error
	jmp	.L73
.L77:
	leaq	-4880(%rbp), %rax
	movq	%rax, %rdi
	call	get_content_type
	movq	%rax, -5040(%rbp)
	movq	-4976(%rbp), %rcx
	movq	-5040(%rbp), %rdx
	leaq	.LC48(%rip), %rsi
	leaq	-4624(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	$512, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-4624(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-4624(%rbp), %rcx
	movl	-5060(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	jmp	.L78
.L79:
	movq	-5032(%rbp), %rdx
	leaq	-4112(%rbp), %rcx
	movl	-5060(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
.L78:
	leaq	-4112(%rbp), %rcx
	movl	-5044(%rbp), %eax
	movl	$4096, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -5032(%rbp)
	cmpq	$0, -5032(%rbp)
	jg	.L79
	movl	-5044(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
.L73:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L81
	call	__stack_chk_fail@PLT
.L81:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	serve_file, .-serve_file
	.globl	send_404_error
	.type	send_404_error, @function
send_404_error:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	http_404_response(%rip), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	http_404_response(%rip), %rcx
	movl	-4(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	send_404_error, .-send_404_error
	.globl	send_500_error
	.type	send_500_error, @function
send_500_error:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	http_500_response(%rip), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	http_500_response(%rip), %rcx
	movl	-4(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	send_500_error, .-send_500_error
	.section	.rodata
	.align 8
.LC49:
	.string	"HTTP/1.1 400 Bad Request\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>400 Bad Request</h1></body></html>\r\n"
	.text
	.globl	send_400_error
	.type	send_400_error, @function
send_400_error:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	leaq	.LC49(%rip), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-8(%rbp), %rcx
	movl	-20(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	send_400_error, .-send_400_error
	.globl	extract_path
	.type	extract_path, @function
extract_path:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$256, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L86
	movl	$0, %eax
	jmp	.L87
.L86:
	movl	$0, -12(%rbp)
	jmp	.L88
.L90:
	movq	-24(%rbp), %rax
	leaq	1(%rax), %rdx
	movq	%rdx, -24(%rbp)
	movl	-12(%rbp), %edx
	leal	1(%rdx), %ecx
	movl	%ecx, -12(%rbp)
	movslq	%edx, %rcx
	movq	-8(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
.L88:
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L89
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L89
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$63, %al
	je	.L89
	cmpl	$254, -12(%rbp)
	jle	.L90
.L89:
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-8(%rbp), %rax
.L87:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	extract_path, .-extract_path
	.globl	parse_port
	.type	parse_port, @function
parse_port:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -4(%rbp)
	cmpl	$1023, -4(%rbp)
	jle	.L92
	cmpl	$65535, -4(%rbp)
	jle	.L93
.L92:
	movl	$0, %eax
	jmp	.L94
.L93:
	movl	-4(%rbp), %eax
.L94:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	parse_port, .-parse_port
	.section	.rodata
.LC50:
	.string	"Shutting down server..."
	.text
	.globl	signal_handler
	.type	signal_handler, @function
signal_handler:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$2, -4(%rbp)
	jne	.L97
	leaq	.LC50(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	call	log_close
	movl	server_socket(%rip), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$0, %edi
	call	exit@PLT
.L97:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	signal_handler, .-signal_handler
	.section	.rodata
.LC51:
	.string	"a"
.LC52:
	.string	"Error opening log file: %s\n"
.LC53:
	.string	"Server logging initialized"
	.text
	.globl	log_init
	.type	log_init, @function
log_init:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L99
	movq	8+log_config(%rip), %rax
	leaq	.LC51(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, 16+log_config(%rip)
	movq	16+log_config(%rip), %rax
	testq	%rax, %rax
	jne	.L99
	call	__errno_location@PLT
	movl	(%rax), %eax
	movl	%eax, %edi
	call	strerror@PLT
	movq	%rax, %rdx
	movq	stderr(%rip), %rax
	leaq	.LC52(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$0, log_config(%rip)
.L99:
	leaq	.LC53(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	log_init, .-log_init
	.globl	log_close
	.type	log_close, @function
log_close:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L102
	movq	16+log_config(%rip), %rax
	testq	%rax, %rax
	je	.L102
	movq	16+log_config(%rip), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movq	$0, 16+log_config(%rip)
.L102:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	log_close, .-log_close
	.section	.rodata
.LC54:
	.string	"%Y-%m-%d %H:%M:%S"
.LC55:
	.string	"INFO"
.LC56:
	.string	"WARNING"
.LC57:
	.string	"ERROR"
.LC58:
	.string	"UNKNOWN"
.LC59:
	.string	"[%s] [%s] %s\n"
.LC60:
	.string	"%s"
	.text
	.globl	log_message
	.type	log_message, @function
log_message:
.LFB21:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$8480, %rsp
	movl	%edi, -8468(%rbp)
	movq	%rsi, -8480(%rbp)
	movq	%rdx, -160(%rbp)
	movq	%rcx, -152(%rbp)
	movq	%r8, -144(%rbp)
	movq	%r9, -136(%rbp)
	testb	%al, %al
	je	.L104
	movaps	%xmm0, -128(%rbp)
	movaps	%xmm1, -112(%rbp)
	movaps	%xmm2, -96(%rbp)
	movaps	%xmm3, -80(%rbp)
	movaps	%xmm4, -64(%rbp)
	movaps	%xmm5, -48(%rbp)
	movaps	%xmm6, -32(%rbp)
	movaps	%xmm7, -16(%rbp)
.L104:
	movq	%fs:40, %rax
	movq	%rax, -184(%rbp)
	xorl	%eax, %eax
	movl	$0, %edi
	call	time@PLT
	movq	%rax, -8464(%rbp)
	leaq	-8464(%rbp), %rax
	movq	%rax, %rdi
	call	localtime@PLT
	movq	%rax, -8448(%rbp)
	movq	-8448(%rbp), %rdx
	leaq	.LC54(%rip), %rsi
	leaq	-8416(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	$26, %esi
	movq	%rax, %rdi
	call	strftime@PLT
	cmpl	$2, -8468(%rbp)
	je	.L105
	cmpl	$2, -8468(%rbp)
	ja	.L106
	cmpl	$0, -8468(%rbp)
	je	.L107
	cmpl	$1, -8468(%rbp)
	je	.L108
	jmp	.L106
.L107:
	leaq	.LC55(%rip), %rax
	movq	%rax, -8456(%rbp)
	jmp	.L109
.L108:
	leaq	.LC56(%rip), %rax
	movq	%rax, -8456(%rbp)
	jmp	.L109
.L105:
	leaq	.LC57(%rip), %rax
	movq	%rax, -8456(%rbp)
	jmp	.L109
.L106:
	leaq	.LC58(%rip), %rax
	movq	%rax, -8456(%rbp)
.L109:
	movl	$16, -8440(%rbp)
	movl	$48, -8436(%rbp)
	leaq	16(%rbp), %rax
	movq	%rax, -8432(%rbp)
	leaq	-176(%rbp), %rax
	movq	%rax, -8424(%rbp)
	leaq	-8440(%rbp), %rcx
	movq	-8480(%rbp), %rdx
	leaq	-8384(%rbp), %rax
	movl	$4096, %esi
	movq	%rax, %rdi
	call	vsnprintf@PLT
	leaq	-8384(%rbp), %rdi
	movq	-8456(%rbp), %rcx
	leaq	-8416(%rbp), %rdx
	leaq	.LC59(%rip), %rsi
	leaq	-4288(%rbp), %rax
	movq	%rdi, %r9
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	$4096, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	movl	4+log_config(%rip), %eax
	testl	%eax, %eax
	je	.L110
	leaq	-4288(%rbp), %rax
	leaq	.LC60(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
.L110:
	movl	log_config(%rip), %eax
	testl	%eax, %eax
	je	.L113
	movq	16+log_config(%rip), %rax
	testq	%rax, %rax
	je	.L113
	movq	16+log_config(%rip), %rdx
	leaq	-4288(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	16+log_config(%rip), %rax
	movq	%rax, %rdi
	call	fflush@PLT
.L113:
	nop
	movq	-184(%rbp), %rax
	subq	%fs:40, %rax
	je	.L112
	call	__stack_chk_fail@PLT
.L112:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	log_message, .-log_message
	.section	.rodata
.LC61:
	.string	"application/octet-stream"
.LC62:
	.string	"html"
.LC63:
	.string	"htm"
.LC64:
	.string	"text/html; charset=utf-8"
.LC65:
	.string	"css"
.LC66:
	.string	"text/css"
.LC67:
	.string	"js"
.LC68:
	.string	"application/javascript"
.LC69:
	.string	"jpg"
.LC70:
	.string	"jpeg"
.LC71:
	.string	"image/jpeg"
.LC72:
	.string	"png"
.LC73:
	.string	"image/png"
.LC74:
	.string	"gif"
.LC75:
	.string	"image/gif"
.LC76:
	.string	"svg"
.LC77:
	.string	"image/svg+xml"
.LC78:
	.string	"ico"
.LC79:
	.string	"image/x-icon"
.LC80:
	.string	"pdf"
.LC81:
	.string	"application/pdf"
.LC82:
	.string	"zip"
.LC83:
	.string	"application/zip"
.LC84:
	.string	"txt"
.LC85:
	.string	"text/plain"
.LC86:
	.string	"mp3"
.LC87:
	.string	"audio/mpeg"
.LC88:
	.string	"mp4"
.LC89:
	.string	"video/mp4"
.LC90:
	.string	"webp"
.LC91:
	.string	"image/webp"
.LC92:
	.string	"bmp"
.LC93:
	.string	"image/bmp"
.LC94:
	.string	"tiff"
.LC95:
	.string	"tif"
.LC96:
	.string	"image/tiff"
	.text
	.globl	get_content_type
	.type	get_content_type, @function
get_content_type:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$46, %esi
	movq	%rax, %rdi
	call	strrchr@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L115
	leaq	.LC61(%rip), %rax
	jmp	.L116
.L115:
	addq	$1, -8(%rbp)
	leaq	.LC62(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L117
	leaq	.LC63(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L118
.L117:
	leaq	.LC64(%rip), %rax
	jmp	.L116
.L118:
	leaq	.LC65(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L119
	leaq	.LC66(%rip), %rax
	jmp	.L116
.L119:
	leaq	.LC67(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L120
	leaq	.LC68(%rip), %rax
	jmp	.L116
.L120:
	leaq	.LC69(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L121
	leaq	.LC70(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L122
.L121:
	leaq	.LC71(%rip), %rax
	jmp	.L116
.L122:
	leaq	.LC72(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L123
	leaq	.LC73(%rip), %rax
	jmp	.L116
.L123:
	leaq	.LC74(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L124
	leaq	.LC75(%rip), %rax
	jmp	.L116
.L124:
	leaq	.LC76(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L125
	leaq	.LC77(%rip), %rax
	jmp	.L116
.L125:
	leaq	.LC78(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L126
	leaq	.LC79(%rip), %rax
	jmp	.L116
.L126:
	leaq	.LC80(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L127
	leaq	.LC81(%rip), %rax
	jmp	.L116
.L127:
	leaq	.LC82(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L128
	leaq	.LC83(%rip), %rax
	jmp	.L116
.L128:
	leaq	.LC84(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L129
	leaq	.LC85(%rip), %rax
	jmp	.L116
.L129:
	leaq	.LC86(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L130
	leaq	.LC87(%rip), %rax
	jmp	.L116
.L130:
	leaq	.LC88(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L131
	leaq	.LC89(%rip), %rax
	jmp	.L116
.L131:
	leaq	.LC90(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L132
	leaq	.LC91(%rip), %rax
	jmp	.L116
.L132:
	leaq	.LC92(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L133
	leaq	.LC93(%rip), %rax
	jmp	.L116
.L133:
	leaq	.LC94(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	je	.L134
	leaq	.LC95(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L135
.L134:
	leaq	.LC96(%rip), %rax
	jmp	.L116
.L135:
	leaq	.LC61(%rip), %rax
.L116:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	get_content_type, .-get_content_type
	.section	.rodata
.LC97:
	.string	"./bin/%s"
.LC98:
	.string	"Executing binary: %s"
.LC99:
	.string	"Failed to execute binary: %s"
	.align 8
.LC100:
	.string	"HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nConnection: close\r\n\r\n"
	.align 8
.LC101:
	.string	"Binary executed successfully: %s (exit code: %d)"
	.text
	.globl	handle_exec_request
	.type	handle_exec_request, @function
handle_exec_request:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$5056, %rsp
	movl	%edi, -5044(%rbp)
	movq	%rsi, -5056(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-5008(%rbp), %rdx
	movl	$0, %eax
	movl	$16, %ecx
	movq	%rdx, %rdi
	rep stosq
	movl	$0, -5032(%rbp)
	movq	-5056(%rbp), %rax
	addq	$6, %rax
	movq	%rax, %rdi
	call	strdup@PLT
	movq	%rax, -5024(%rbp)
	cmpq	$0, -5024(%rbp)
	jne	.L137
	movl	-5044(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
	jmp	.L136
.L137:
	movq	-5024(%rbp), %rax
	movl	$63, %esi
	movq	%rax, %rdi
	call	strchr@PLT
	movq	%rax, -5016(%rbp)
	cmpq	$0, -5016(%rbp)
	je	.L139
	movq	-5016(%rbp), %rax
	movb	$0, (%rax)
.L139:
	movq	-5024(%rbp), %rdx
	leaq	.LC97(%rip), %rsi
	leaq	-4880(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	$256, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-4880(%rbp), %rax
	leaq	.LC98(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	leaq	-4880(%rbp), %rax
	movq	%rax, -5008(%rbp)
	leaq	-4112(%rbp), %rdx
	leaq	-5008(%rbp), %rsi
	leaq	-4880(%rbp), %rax
	movl	$4096, %ecx
	movq	%rax, %rdi
	call	execute_binary@PLT
	movl	%eax, -5028(%rbp)
	cmpl	$-1, -5028(%rbp)
	jne	.L140
	leaq	-4880(%rbp), %rax
	leaq	.LC99(%rip), %rcx
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	log_message
	movl	-5044(%rbp), %eax
	movl	%eax, %edi
	call	send_500_error
	movq	-5024(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	jmp	.L136
.L140:
	leaq	.LC100(%rip), %rdx
	leaq	-4624(%rbp), %rax
	movl	$512, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-4624(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-4624(%rbp), %rcx
	movl	-5044(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	leaq	-4112(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-4112(%rbp), %rcx
	movl	-5044(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movl	-5028(%rbp), %edx
	leaq	-4880(%rbp), %rax
	leaq	.LC101(%rip), %rsi
	movl	%edx, %ecx
	movq	%rax, %rdx
	movl	$0, %edi
	movl	$0, %eax
	call	log_message
	movq	-5024(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
.L136:
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L142
	call	__stack_chk_fail@PLT
.L142:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	handle_exec_request, .-handle_exec_request
	.ident	"GCC: (GNU) 15.2.1 20250813"
	.section	.note.GNU-stack,"",@progbits
