	.text
	.p2align 4
	.globl	base64_decode
	.type	base64_decode, @function
base64_decode:
.LFB10:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$288, %rsp
	.cfi_def_cfa_offset 320
	movq	%fs:40, %rax
	movq	%rax, 280(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L3
	movq	%rdi, %rbp
	call	strlen@PLT
	movq	%rax, %rbx
	movq	%rax, %r12
	andl	$3, %ebx
	jne	.L3
	shrq	$2, %rax
	leaq	(%rax,%rax,2), %rdi
	cmpb	$61, -1(%rbp,%r12)
	jne	.L5
	subq	$1, %rdi
.L5:
	cmpb	$61, -2(%rbp,%r12)
	je	.L6
	addq	$1, %rdi
.L6:
	call	malloc@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L3
	movl	$-2139062144, %eax
	leaq	base64_table(%rip), %rcx
	movd	%eax, %xmm0
	xorl	%eax, %eax
	pshufd	$0, %xmm0, %xmm0
	movaps	%xmm0, 16(%rsp)
	movaps	%xmm0, 32(%rsp)
	movaps	%xmm0, 48(%rsp)
	movaps	%xmm0, 64(%rsp)
	movaps	%xmm0, 80(%rsp)
	movaps	%xmm0, 96(%rsp)
	movaps	%xmm0, 112(%rsp)
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm0, 144(%rsp)
	movaps	%xmm0, 160(%rsp)
	movaps	%xmm0, 176(%rsp)
	movaps	%xmm0, 192(%rsp)
	movaps	%xmm0, 208(%rsp)
	movaps	%xmm0, 224(%rsp)
	movaps	%xmm0, 240(%rsp)
	movaps	%xmm0, 256(%rsp)
	.p2align 5
	.p2align 4
	.p2align 3
.L7:
	movzbl	(%rcx,%rax), %edx
	movb	%al, 16(%rsp,%rdx)
	addq	$1, %rax
	cmpq	$64, %rax
	jne	.L7
	testq	%r12, %r12
	je	.L19
	xorl	%esi, %esi
	leaq	16(%rsp), %r8
	.p2align 4
	.p2align 3
.L17:
	movl	$0, 12(%rsp)
	leaq	0(%rbp,%rbx), %rcx
	leaq	12(%rsp), %rdx
.L14:
	movzbl	(%rcx), %eax
	cmpb	$61, %al
	je	.L15
	movzbl	16(%rsp,%rax), %eax
	movb	%al, (%rdx)
	cmpb	$-128, %al
	je	.L28
	addq	$1, %rdx
	addq	$1, %rcx
	cmpq	%rdx, %r8
	jne	.L14
.L15:
	movzbl	13(%rsp), %edx
	movzbl	12(%rsp), %eax
	movslq	%esi, %r9
	leal	1(%rsi), %ecx
	movl	%edx, %r10d
	sall	$2, %eax
	shrb	$4, %r10b
	orl	%r10d, %eax
	movb	%al, (%rdi,%r9)
	cmpb	$61, 2(%rbp,%rbx)
	je	.L29
	movzbl	14(%rsp), %eax
	sall	$4, %edx
	movslq	%ecx, %rcx
	addl	$2, %esi
	shrb	$2, %al
	orl	%edx, %eax
	movb	%al, (%rdi,%rcx)
.L11:
	cmpb	$61, 3(%rbp,%rbx)
	je	.L16
	movzbl	14(%rsp), %eax
	movslq	%esi, %rdx
	addl	$1, %esi
	sall	$6, %eax
	orb	15(%rsp), %al
	movb	%al, (%rdi,%rdx)
.L16:
	addq	$4, %rbx
	cmpq	%r12, %rbx
	jb	.L17
	movslq	%esi, %rax
	addq	%rdi, %rax
.L8:
	movb	$0, (%rax)
.L1:
	movq	280(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L30
	addq	$288, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rdi, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L29:
	.cfi_restore_state
	movl	%ecx, %esi
	jmp	.L11
	.p2align 4,,10
	.p2align 3
.L28:
	call	free@PLT
.L3:
	xorl	%edi, %edi
	jmp	.L1
.L19:
	movq	%rdi, %rax
	jmp	.L8
.L30:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE10:
	.size	base64_decode, .-base64_decode
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"admin"
.LC3:
	.string	"Decoded credentials: %s\n"
.LC4:
	.string	"Username: %s, Password: %s\n"
	.text
	.p2align 4
	.globl	authenticate_user
	.type	authenticate_user, @function
authenticate_user:
.LFB11:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	testq	%rdi, %rdi
	je	.L33
	call	base64_decode
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L33
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movl	$58, %esi
	movq	%rbp, %rdi
	call	strchr@PLT
	testq	%rax, %rax
	je	.L46
	movb	$0, (%rax)
	leaq	1(%rax), %r12
	xorl	%eax, %eax
	movq	%rbp, %rsi
	movq	%r12, %rdx
	leaq	.LC4(%rip), %rdi
	leaq	users(%rip), %rbx
	call	printf@PLT
	leaq	.LC2(%rip), %rsi
	.p2align 4
	.p2align 3
.L39:
	movq	%rbp, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L37
	movq	8(%rbx), %rsi
	movq	%r12, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L40
.L37:
	movq	16(%rbx), %rsi
	addq	$16, %rbx
	testq	%rsi, %rsi
	jne	.L39
	xorl	%ebx, %ebx
.L38:
	movq	%rbp, %rdi
	call	free@PLT
	movl	%ebx, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L46:
	.cfi_restore_state
	movq	%rbp, %rdi
	call	free@PLT
.L33:
	xorl	%ebx, %ebx
	movl	%ebx, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L40:
	.cfi_restore_state
	movl	$1, %ebx
	jmp	.L38
	.cfi_endproc
.LFE11:
	.size	authenticate_user, .-authenticate_user
	.p2align 4
	.globl	create_auth_response
	.type	create_auth_response, @function
create_auth_response:
.LFB12:
	.cfi_startproc
	leaq	response.0(%rip), %rax
	ret
	.cfi_endproc
.LFE12:
	.size	create_auth_response, .-create_auth_response
	.data
	.align 32
	.type	response.0, @object
	.size	response.0, 225
response.0:
	.string	"HTTP/1.1 401 Unauthorized\r\nWWW-Authenticate: Basic realm=\"HTTP Server\"\r\nContent-Type: text/html\r\nConnection: close\r\n\r\n<html><body><h1>401 Unauthorized</h1><p>Authentication required to access this resource.</p></body></html>"
	.section	.rodata.str1.1
.LC5:
	.string	"password123"
.LC6:
	.string	"user1"
.LC7:
	.string	"userpass"
	.section	.data.rel.ro.local,"aw"
	.align 32
	.type	users, @object
	.size	users, 48
users:
	.quad	.LC2
	.quad	.LC5
	.quad	.LC6
	.quad	.LC7
	.quad	0
	.quad	0
	.section	.rodata
	.align 32
	.type	base64_table, @object
	.size	base64_table, 65
base64_table:
	.string	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	.ident	"GCC: (GNU) 15.2.1 20250813"
	.section	.note.GNU-stack,"",@progbits
