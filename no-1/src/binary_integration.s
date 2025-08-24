	.globl	execute_binary
	.type	execute_binary, @function
execute_binary:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	pipe@PLT
	cmpl	$-1, %eax
	jne	.L2
	movl	$-1, %eax
	jmp	.L10
.L2:
	call	fork@PLT
	movl	%eax, -28(%rbp)
	cmpl	$-1, -28(%rbp)
	jne	.L4
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	$-1, %eax
	jmp	.L10
.L4:
	cmpl	$0, -28(%rbp)
	jne	.L5
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	-12(%rbp), %eax
	movl	$1, %esi
	movl	%eax, %edi
	call	dup2@PLT
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execv@PLT
	movl	$1, %edi
	call	exit@PLT
.L5:
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movq	-64(%rbp), %rax
	leaq	-1(%rax), %rdx
	movl	-16(%rbp), %eax
	movq	-56(%rbp), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jle	.L6
	movq	-24(%rbp), %rdx
	movq	-56(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	jmp	.L7
.L6:
	movq	-56(%rbp), %rax
	movb	$0, (%rax)
.L7:
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	leaq	-32(%rbp), %rcx
	movl	-28(%rbp), %eax
	movl	$0, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	waitpid@PLT
	movl	-32(%rbp), %eax
	andl	$127, %eax
	testl	%eax, %eax
	jne	.L8
	movl	-32(%rbp), %eax
	sarl	$8, %eax
	movzbl	%al, %eax
	jmp	.L10
.L8:
	movl	$-1, %eax
.L10:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	execute_binary, .-execute_binary
	.ident	"GCC: (GNU) 15.2.1 20250813"
	.section	.note.GNU-stack,"",@progbits
