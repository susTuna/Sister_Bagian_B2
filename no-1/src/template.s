	.text
	.p2align 4
	.globl	template_create_context
	.type	template_create_context, @function
template_create_context:
.LFB10:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$416004, %edi
	call	malloc@PLT
	testq	%rax, %rax
	je	.L1
	movl	$0, 416000(%rax)
.L1:
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE10:
	.size	template_create_context, .-template_create_context
	.p2align 4
	.globl	template_add_variable
	.type	template_add_variable, @function
template_add_variable:
.LFB11:
	.cfi_startproc
	testq	%rsi, %rsi
	sete	%al
	testq	%rdx, %rdx
	sete	%cl
	orb	%cl, %al
	jne	.L14
	testq	%rdi, %rdi
	je	.L14
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xorl	%eax, %eax
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movl	416000(%rdi), %r14d
	cmpl	$99, %r14d
	jg	.L8
	movq	%rdx, %r15
	movq	%rsi, %r13
	movq	%rdi, %r12
	testl	%r14d, %r14d
	jle	.L10
	xorl	%ebp, %ebp
	xorl	%ebx, %ebx
	jmp	.L12
	.p2align 4,,10
	.p2align 3
.L11:
	addl	$1, %ebx
	addq	$4160, %rbp
	cmpl	%ebx, %r14d
	je	.L10
.L12:
	leaq	(%r12,%rbp), %rdi
	movq	%r13, %rsi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L11
	movslq	%ebx, %rbx
	leaq	64(%r12,%rbp), %rdi
	movl	$4095, %edx
	movq	%r15, %rsi
	call	strncpy@PLT
	imulq	$4160, %rbx, %rbx
	movb	$0, 4159(%r12,%rbx)
.L13:
	movl	$1, %eax
.L8:
	addq	$8, %rsp
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
.L14:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L10:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movslq	%r14d, %rdi
	movl	$63, %edx
	movq	%r13, %rsi
	imulq	$4160, %rdi, %rdi
	addq	%r12, %rdi
	call	strncpy@PLT
	movslq	416000(%r12), %rax
	movl	$4095, %edx
	movq	%r15, %rsi
	imulq	$4160, %rax, %rax
	leaq	64(%r12,%rax), %rdi
	call	strncpy@PLT
	movslq	416000(%r12), %rax
	movq	%rax, %rdx
	imulq	$4160, %rax, %rax
	addl	$1, %edx
	movb	$0, 63(%r12,%rax)
	movb	$0, 4159(%r12,%rax)
	movl	%edx, 416000(%r12)
	jmp	.L13
	.cfi_endproc
.LFE11:
	.size	template_add_variable, .-template_add_variable
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"rb"
	.text
	.p2align 4
	.globl	template_load_file
	.type	template_load_file, @function
template_load_file:
.LFB12:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	.LC0(%rip), %rsi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	fopen@PLT
	testq	%rax, %rax
	je	.L22
	xorl	%esi, %esi
	movq	%rax, %rbx
	movl	$2, %edx
	movq	%rax, %rdi
	call	fseek@PLT
	movq	%rbx, %rdi
	call	ftell@PLT
	xorl	%edx, %edx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	movq	%rax, %r12
	call	fseek@PLT
	cmpq	$65536, %r12
	jg	.L31
	leaq	1(%r12), %rdi
	call	malloc@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L31
	movq	%rax, %rdi
	movq	%rbx, %rcx
	movq	%r12, %rdx
	movl	$1, %esi
	call	fread@PLT
	movq	%rbx, %rdi
	movq	%rax, %r13
	call	fclose@PLT
	cmpq	%r13, %r12
	jne	.L32
	movb	$0, 0(%rbp,%r12)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rax
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
.L31:
	.cfi_restore_state
	movq	%rbx, %rdi
	call	fclose@PLT
.L22:
	xorl	%ebp, %ebp
.L33:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rax
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
.L32:
	.cfi_restore_state
	movq	%rbp, %rdi
	xorl	%ebp, %ebp
	call	free@PLT
	jmp	.L33
	.cfi_endproc
.LFE12:
	.size	template_load_file, .-template_load_file
	.section	.rodata.str1.1
.LC1:
	.string	"}}"
	.text
	.p2align 4
	.globl	template_render
	.type	template_render, @function
template_render:
.LFB13:
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
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	movq	%fs:40, %rax
	movq	%rax, 104(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L38
	movq	%rsi, %r13
	testq	%rsi, %rsi
	je	.L38
	movq	%rdi, %rbx
	movl	$65536, %edi
	call	malloc@PLT
	movq	%rax, %r12
	testq	%rax, %rax
	je	.L38
	movb	$0, (%rax)
	movzbl	(%rbx), %eax
	testb	%al, %al
	je	.L34
	xorl	%ebp, %ebp
	jmp	.L56
	.p2align 4,,10
	.p2align 3
.L40:
	movzbl	(%rbx), %eax
	movb	$0, 1(%r12,%rbp)
	addq	$1, %rbx
	movb	%al, (%r12,%rbp)
	movl	%edx, %eax
	addq	$1, %rbp
.L55:
	testb	%al, %al
	je	.L34
	cmpq	$65534, %rbp
	ja	.L34
.L56:
	movzbl	1(%rbx), %edx
	cmpb	$123, %al
	jne	.L40
	cmpb	$123, %dl
	jne	.L40
	leaq	2(%rbx), %r14
	leaq	.LC1(%rip), %rsi
	movq	%r14, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	je	.L42
	movq	%rax, %rdx
	subq	%r14, %rdx
	cmpq	$63, %rdx
	jbe	.L75
.L42:
	movzbl	3(%rbx), %edx
	movq	%r14, %rbx
	jmp	.L40
	.p2align 4,,10
	.p2align 3
.L38:
	xorl	%r12d, %r12d
.L34:
	movq	104(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L76
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
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
.L75:
	.cfi_restore_state
	leaq	32(%rsp), %rdi
	movq	%r14, %rsi
	movq	%rdx, 8(%rsp)
	movq	%rax, 24(%rsp)
	movq	%rdi, 16(%rsp)
	call	memcpy@PLT
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rbx
	movq	24(%rsp), %rcx
	movb	$0, 32(%rsp,%rdx)
	movsbq	32(%rsp), %r14
	testb	%r14b, %r14b
	je	.L44
	movq	%rcx, 8(%rsp)
	call	__ctype_b_loc@PLT
	movq	16(%rsp), %rbx
	movq	8(%rsp), %rcx
	movq	(%rax), %rsi
	jmp	.L45
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L46:
	movsbq	1(%rbx), %r14
	addq	$1, %rbx
	testb	%r14b, %r14b
	je	.L44
.L45:
	testb	$32, 1(%rsi,%r14,2)
	jne	.L46
	cmpb	$0, (%rbx)
	je	.L44
	movq	%rbx, %rax
	.p2align 4
	.p2align 4
	.p2align 3
.L47:
	addq	$1, %rax
	cmpb	$0, (%rax)
	jne	.L47
	cmpq	%rax, %rbx
	jb	.L48
	jmp	.L49
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L50:
	subq	$1, %rax
	cmpq	%rbx, %rax
	je	.L49
.L48:
	movsbq	-1(%rax), %rdi
	testb	$32, 1(%rsi,%rdi,2)
	jne	.L50
.L49:
	movb	$0, (%rax)
	movslq	416000(%r13), %rax
	testl	%eax, %eax
	jle	.L51
	imulq	$4160, %rax, %r15
	xorl	%r14d, %r14d
	jmp	.L54
	.p2align 4,,10
	.p2align 3
.L52:
	addq	$4160, %r14
	cmpq	%r14, %r15
	je	.L51
.L54:
	leaq	0(%r13,%r14), %rdi
	movq	%rbx, %rsi
	movq	%rcx, 8(%rsp)
	call	strcmp@PLT
	movq	8(%rsp), %rcx
	testl	%eax, %eax
	jne	.L52
	leaq	64(%r13,%r14), %rdi
	call	strlen@PLT
	movq	8(%rsp), %rcx
	leaq	(%rax,%rbp), %rbx
	cmpq	$65534, %rbx
	jbe	.L77
.L53:
	movzbl	2(%rcx), %eax
	leaq	2(%rcx), %rbx
	jmp	.L55
.L51:
	movq	%r12, %rdi
	movq	%rcx, 8(%rsp)
	call	strlen@PLT
	movl	$31611, %edx
	movq	16(%rsp), %rbx
	movw	%dx, (%r12,%rax)
	leaq	2(%r12,%rax), %rdi
	movq	%rbx, %rsi
	call	strcpy@PLT
	movq	%rbx, %rdi
	call	strlen@PLT
	movq	%r12, %rdi
	leaq	4(%rax,%rbp), %rbp
	call	strlen@PLT
	movl	$32125, %ecx
	movw	%cx, (%r12,%rax)
	movq	8(%rsp), %rcx
	movb	$0, 2(%r12,%rax)
	jmp	.L53
.L77:
	leaq	64(%r13,%r14), %rsi
	movq	%r12, %rdi
	movq	%rbx, %rbp
	call	strcat@PLT
	movq	8(%rsp), %rcx
	jmp	.L53
.L44:
	movq	%rbx, %rax
	jmp	.L49
.L76:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE13:
	.size	template_render, .-template_render
	.p2align 4
	.globl	template_free_context
	.type	template_free_context, @function
template_free_context:
.LFB14:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L78
	jmp	free@PLT
	.p2align 4,,10
	.p2align 3
.L78:
	ret
	.cfi_endproc
.LFE14:
	.size	template_free_context, .-template_free_context
	.ident	"GCC: (GNU) 15.2.1 20250813"
	.section	.note.GNU-stack,"",@progbits
