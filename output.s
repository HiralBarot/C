	.file	"main.c"
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "ERROR: Basic write read: write to index 5 failed with %d\12\0"
	.align 8
.LC1:
	.ascii "ERROR: Basic write read: reading back data from index 5 failed with %d\12\0"
	.align 8
.LC2:
	.ascii "ERROR: Basic write read: Retrieved data does not match expected data\0"
	.align 8
.LC3:
	.ascii "ERROR: Basic write read: Actual: %lx, Expected: %lx\12\0"
	.text
	.globl	basic_write_read
	.def	basic_write_read;	.scl	2;	.type	32;	.endef
	.seh_proc	basic_write_read
basic_write_read:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movabsq	$2777955651626, %rax
	movq	%rax, -24(%rbp)
	leaq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	process_command
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	je	.L2
	movl	-4(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC0(%rip), %rcx
	call	printf
	movl	$0, %eax
	jmp	.L6
.L2:
	movq	$41, -24(%rbp)
	leaq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	process_command
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	je	.L4
	movl	-4(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC1(%rip), %rcx
	call	printf
	movl	$0, %eax
	jmp	.L6
.L4:
	movabsq	$2777955651625, %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	cmpq	-16(%rbp), %rax
	je	.L5
	leaq	.LC2(%rip), %rcx
	call	puts
	movq	-24(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC3(%rip), %rcx
	call	printf
	movl	$0, %eax
	jmp	.L6
.L5:
	movl	$1, %eax
.L6:
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC4:
	.ascii "ERROR: Repeated write: Write of data failed with error %d\12\0"
	.align 8
.LC5:
	.ascii "ERROR: Repeated write: Unable to read back data\0"
	.align 8
.LC6:
	.ascii "ERROR: Repeated write: Retrieved data does not match expected data\0"
	.align 8
.LC7:
	.ascii "ERROR: Repeated write: Actual: %lx, Expected: %lx\12\0"
	.align 8
.LC8:
	.ascii "INFO: Repeated write: Writes achieved: %d\12\0"
	.align 8
.LC9:
	.ascii "ERROR: Repeated write: Minimum write count not achieved\0"
	.align 8
.LC10:
	.ascii "ERROR: Repeated write: Actual write count exceeds theoretical write count\0"
	.text
	.globl	repeated_write
	.def	repeated_write;	.scl	2;	.type	32;	.endef
	.seh_proc	repeated_write
repeated_write:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$80, %rsp
	.seh_stackalloc	80
	.seh_endprologue
	movl	$2712781265, %eax
	movq	%rax, -24(%rbp)
	movl	$0, -8(%rbp)
	movb	$1, -9(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L8
.L14:
	movq	-24(%rbp), %rax
	salq	$10, %rax
	addq	$10, %rax
	movq	%rax, -48(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	call	process_command
	movl	%eax, -28(%rbp)
	cmpl	$1, -28(%rbp)
	jne	.L9
	movb	$0, -9(%rbp)
	jmp	.L10
.L9:
	cmpl	$0, -28(%rbp)
	je	.L11
	movl	-28(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC4(%rip), %rcx
	call	printf
	movb	$0, -9(%rbp)
	movl	$0, %eax
	jmp	.L19
.L11:
	addq	$1, -24(%rbp)
	addl	$1, -8(%rbp)
.L10:
	addl	$1, -4(%rbp)
.L8:
	cmpl	$109, -4(%rbp)
	jg	.L13
	cmpb	$0, -9(%rbp)
	jne	.L14
.L13:
	movq	$9, -48(%rbp)
	movq	-24(%rbp), %rax
	subq	$1, %rax
	salq	$10, %rax
	addq	$9, %rax
	movq	%rax, -40(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rcx
	call	process_command
	testl	%eax, %eax
	je	.L15
	leaq	.LC5(%rip), %rcx
	call	puts
	movl	$0, %eax
	jmp	.L19
.L15:
	movq	-48(%rbp), %rax
	cmpq	-40(%rbp), %rax
	je	.L16
	leaq	.LC6(%rip), %rcx
	call	puts
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, %r8
	movq	%rax, %rdx
	leaq	.LC7(%rip), %rcx
	call	printf
	movl	$0, %eax
	jmp	.L19
.L16:
	movl	-8(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC8(%rip), %rcx
	call	printf
	cmpl	$9, -8(%rbp)
	jg	.L17
	leaq	.LC9(%rip), %rcx
	call	puts
	movl	$0, %eax
	jmp	.L19
.L17:
	cmpl	$100, -8(%rbp)
	jle	.L18
	leaq	.LC10(%rip), %rcx
	call	puts
	movl	$0, %eax
	jmp	.L19
.L18:
	movl	$1, %eax
.L19:
	addq	$80, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 8
.LC11:
	.ascii "Testing a single write/read and bit conversion\0"
.LC12:
	.ascii "Basic write and read\0"
.LC13:
	.ascii "Test Passed: %s\12\12\0"
.LC14:
	.ascii "Test Failed: %s\12\12\0"
	.align 8
.LC15:
	.ascii "Testing repeated write to same index\0"
.LC16:
	.ascii "Repeated write\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	call	__main
	call	initialize
	leaq	.LC11(%rip), %rcx
	call	puts
	call	basic_write_read
	testb	%al, %al
	je	.L21
	leaq	.LC12(%rip), %rdx
	leaq	.LC13(%rip), %rcx
	call	printf
	jmp	.L22
.L21:
	leaq	.LC12(%rip), %rdx
	leaq	.LC14(%rip), %rcx
	call	printf
.L22:
	call	reset
	leaq	.LC15(%rip), %rcx
	call	puts
	call	repeated_write
	testb	%al, %al
	je	.L23
	leaq	.LC16(%rip), %rdx
	leaq	.LC13(%rip), %rcx
	call	printf
	jmp	.L24
.L23:
	leaq	.LC16(%rip), %rdx
	leaq	.LC14(%rip), %rcx
	call	printf
.L24:
	call	reset
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (tdm64-1) 5.1.0"
	.def	process_command;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	initialize;	.scl	2;	.type	32;	.endef
	.def	reset;	.scl	2;	.type	32;	.endef
