	.text
	.p2align 4
	.globl	execute_binary
	.type	execute_binary, @function
execute_binary:
.LFB5:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rdi, %r14
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rbx
	movq	%rbx, 24(%rsp)
	movq	%rcx, %rbx
	leaq	16(%rsp), %rdi
	call	pipe@PLT
	cmpl	$-1, %eax
	je	.L2
	call	fork@PLT
	movl	%eax, %ebp
	cmpl	$-1, %eax
	je	.L16
	testl	%eax, %eax
	je	.L17
	movl	20(%rsp), %edi
	call	close@PLT
	movl	16(%rsp), %edi
	leaq	-1(%rbx), %rdx
	movq	%r12, %rsi
	call	read@PLT
	testq	%rax, %rax
	jle	.L6
	movb	$0, (%r12,%rax)
.L7:
	movl	16(%rsp), %edi
	call	close@PLT
	xorl	%edx, %edx
	leaq	12(%rsp), %rsi
	movl	%ebp, %edi
	call	waitpid@PLT
	movl	12(%rsp), %edx
	movzbl	%dh, %eax
	andl	$127, %edx
	movl	$-1, %edx
	cmovne	%edx, %eax
.L1:
	movq	24(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L18
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L6:
	.cfi_restore_state
	movb	$0, (%r12)
	jmp	.L7
.L16:
	movl	16(%rsp), %edi
	call	close@PLT
	movl	20(%rsp), %edi
	call	close@PLT
	.p2align 4
	.p2align 3
.L2:
	movl	$-1, %eax
	jmp	.L1
.L18:
	call	__stack_chk_fail@PLT
.L17:
	movl	16(%rsp), %edi
	call	close@PLT
	movl	20(%rsp), %edi
	movl	$1, %esi
	call	dup2@PLT
	movl	20(%rsp), %edi
	call	close@PLT
	movq	%r14, %rdi
	movq	%r15, %rsi
	call	execv@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE5:
	.size	execute_binary, .-execute_binary
	.ident	"GCC: (GNU) 15.2.1 20250813"
	.section	.note.GNU-stack,"",@progbits
