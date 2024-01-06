	.file	"counter_la_mm.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/ubuntu/Desktop/caravel-soc_fpga-lab/lab-sdram/testbench/counter_la_mm" "counter_la_mm.c"
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
.LFB316:
	.file 1 "../../firmware/stub.c"
	.loc 1 19 1
	.cfi_startproc
.LVL0:
	.loc 1 20 2
	.loc 1 20 5 is_stmt 0
	li	a5,10
	beq	a0,a5,.L8
.L2:
	.loc 1 22 13 discriminator 1
	li	a4,-268410880
	.loc 1 22 60 discriminator 1
	li	a3,1
.L4:
	.loc 1 22 60 is_stmt 1 discriminator 1
	.loc 1 22 13 is_stmt 0 discriminator 1
	lw	a5,-2044(a4)
	.loc 1 22 60 discriminator 1
	beq	a5,a3,.L4
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	sw	a0,-2048(a4)
	.loc 1 24 1
	ret
.L8:
.LBB4:
.LBB5:
	.loc 1 22 13
	li	a4,-268410880
	.loc 1 22 60
	li	a3,1
.L3:
	.loc 1 22 60 is_stmt 1
	.loc 1 22 13 is_stmt 0
	lw	a5,-2044(a4)
	.loc 1 22 60
	beq	a5,a3,.L3
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	li	a5,13
	sw	a5,-2048(a4)
	.loc 1 24 1
	j	.L2
.LBE5:
.LBE4:
	.cfi_endproc
.LFE316:
	.size	putchar, .-putchar
	.align	2
	.globl	print
	.type	print, @function
print:
.LFB317:
	.loc 1 27 1 is_stmt 1
	.cfi_startproc
.LVL1:
	.loc 1 28 2
	.loc 1 28 9
	lbu	a2,0(a0)
	beq	a2,zero,.L9
.LBB10:
.LBB11:
	.loc 1 20 5 is_stmt 0
	li	a1,10
.LBB12:
.LBB13:
	.loc 1 22 13
	li	a4,-268410880
	.loc 1 22 60
	li	a3,1
	.loc 1 23 50
	li	a6,13
.L14:
.LBE13:
.LBE12:
.LBE11:
.LBE10:
	.loc 1 29 3 is_stmt 1
	.loc 1 29 14 is_stmt 0
	addi	a0,a0,1
.LVL2:
.LBB18:
.LBB16:
	.loc 1 20 2 is_stmt 1
	.loc 1 20 5 is_stmt 0
	beq	a2,a1,.L12
.L13:
	.loc 1 22 60 is_stmt 1
	.loc 1 22 13 is_stmt 0
	lw	a5,-2044(a4)
	.loc 1 22 60
	beq	a5,a3,.L13
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	sw	a2,-2048(a4)
.LVL3:
.LBE16:
.LBE18:
	.loc 1 28 9 is_stmt 1
	lbu	a2,0(a0)
	bne	a2,zero,.L14
.L9:
	.loc 1 30 1 is_stmt 0
	ret
.LVL4:
.L12:
.LBB19:
.LBB17:
.LBB15:
.LBB14:
	.loc 1 22 60 is_stmt 1
	.loc 1 22 13 is_stmt 0
	lw	a5,-2044(a4)
	.loc 1 22 60
	beq	a5,a3,.L12
	.loc 1 23 2 is_stmt 1
	.loc 1 23 50 is_stmt 0
	sw	a6,-2048(a4)
	.loc 1 24 1
	j	.L13
.LBE14:
.LBE15:
.LBE17:
.LBE19:
	.cfi_endproc
.LFE317:
	.size	print, .-print
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
.LFB318:
	.file 2 "counter_la_mm.c"
	.loc 2 36 1 is_stmt 1
	.cfi_startproc
	.loc 2 37 2
	.loc 2 64 9
	.loc 2 36 1 is_stmt 0
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	.loc 2 64 43
	li	a4,8192
	li	a5,637534208
	.loc 2 36 1
	sw	s0,8(sp)
	sw	ra,12(sp)
	.cfi_offset 8, -8
	.cfi_offset 1, -4
	.loc 2 64 43
	addi	a3,a4,-2039
	sw	a3,160(a5)
	.loc 2 65 9 is_stmt 1
	.loc 2 65 43 is_stmt 0
	sw	a3,156(a5)
	.loc 2 66 9 is_stmt 1
	.loc 2 66 43 is_stmt 0
	sw	a3,152(a5)
	.loc 2 67 9 is_stmt 1
	.loc 2 67 43 is_stmt 0
	sw	a3,148(a5)
	.loc 2 68 9 is_stmt 1
	.loc 2 68 43 is_stmt 0
	sw	a3,144(a5)
	.loc 2 69 9 is_stmt 1
	.loc 2 69 43 is_stmt 0
	sw	a3,140(a5)
	.loc 2 70 9 is_stmt 1
	.loc 2 70 43 is_stmt 0
	sw	a3,136(a5)
	.loc 2 71 9 is_stmt 1
	.loc 2 71 43 is_stmt 0
	sw	a3,132(a5)
	.loc 2 72 9 is_stmt 1
	.loc 2 72 43 is_stmt 0
	sw	a3,128(a5)
	.loc 2 73 9 is_stmt 1
	.loc 2 73 43 is_stmt 0
	sw	a3,124(a5)
	.loc 2 74 9 is_stmt 1
	.loc 2 74 43 is_stmt 0
	sw	a3,120(a5)
	.loc 2 75 9 is_stmt 1
	.loc 2 75 43 is_stmt 0
	sw	a3,116(a5)
	.loc 2 76 9 is_stmt 1
	.loc 2 76 43 is_stmt 0
	sw	a3,112(a5)
	.loc 2 77 9 is_stmt 1
	.loc 2 77 43 is_stmt 0
	sw	a3,108(a5)
	.loc 2 78 9 is_stmt 1
	.loc 2 78 43 is_stmt 0
	sw	a3,104(a5)
	.loc 2 79 9 is_stmt 1
	.loc 2 79 43 is_stmt 0
	sw	a3,100(a5)
	.loc 2 81 9 is_stmt 1
	.loc 2 81 43 is_stmt 0
	addi	a4,a4,-2040
	sw	a4,96(a5)
	.loc 2 82 9 is_stmt 1
	.loc 2 82 43 is_stmt 0
	sw	a4,92(a5)
	.loc 2 83 9 is_stmt 1
	.loc 2 83 43 is_stmt 0
	sw	a4,88(a5)
	.loc 2 84 9 is_stmt 1
	.loc 2 84 43 is_stmt 0
	sw	a4,84(a5)
	.loc 2 85 9 is_stmt 1
	.loc 2 85 43 is_stmt 0
	sw	a4,80(a5)
	.loc 2 86 9 is_stmt 1
	.loc 2 86 43 is_stmt 0
	sw	a4,76(a5)
	.loc 2 87 9 is_stmt 1
	.loc 2 87 43 is_stmt 0
	sw	a4,72(a5)
	.loc 2 88 9 is_stmt 1
	.loc 2 88 43 is_stmt 0
	sw	a4,68(a5)
	.loc 2 89 9 is_stmt 1
	.loc 2 89 43 is_stmt 0
	sw	a4,64(a5)
	.loc 2 90 9 is_stmt 1
	.loc 2 90 43 is_stmt 0
	sw	a4,56(a5)
	.loc 2 91 9 is_stmt 1
	.loc 2 91 43 is_stmt 0
	sw	a4,52(a5)
	.loc 2 92 9 is_stmt 1
	.loc 2 92 43 is_stmt 0
	sw	a4,48(a5)
	.loc 2 93 9 is_stmt 1
	.loc 2 93 43 is_stmt 0
	sw	a4,44(a5)
	.loc 2 94 9 is_stmt 1
	.loc 2 94 43 is_stmt 0
	sw	a4,40(a5)
	.loc 2 95 9 is_stmt 1
	.loc 2 95 43 is_stmt 0
	sw	a4,36(a5)
	.loc 2 97 9 is_stmt 1
	.loc 2 97 43 is_stmt 0
	sw	a3,60(a5)
	.loc 2 101 2 is_stmt 1
	.loc 2 101 50 is_stmt 0
	li	a4,1
	li	a3,-268410880
	sw	a4,0(a3)
	.loc 2 104 2 is_stmt 1
	.loc 2 105 10 is_stmt 0
	li	s0,637534208
	.loc 2 104 36
	sw	a4,0(a5)
	.loc 2 105 2 is_stmt 1
.L22:
	.loc 2 105 43 discriminator 1
	.loc 2 105 10 is_stmt 0 discriminator 1
	lw	a5,0(s0)
	.loc 2 105 43 discriminator 1
	beq	a5,a4,.L22
	.loc 2 109 2 is_stmt 1
	.loc 2 109 114 is_stmt 0
	li	a5,-268423168
	sw	zero,12(a5)
	.loc 2 109 57
	sw	zero,28(a5)
	.loc 2 110 2 is_stmt 1
	.loc 2 110 112 is_stmt 0
	li	a4,-1
	sw	a4,8(a5)
	.loc 2 110 56
	sw	a4,24(a5)
	.loc 2 111 2 is_stmt 1
	.loc 2 111 112 is_stmt 0
	sw	zero,4(a5)
	.loc 2 111 56
	sw	zero,20(a5)
	.loc 2 112 2 is_stmt 1
	.loc 2 112 100 is_stmt 0
	sw	zero,0(a5)
	.loc 2 112 50
	sw	zero,16(a5)
	.loc 2 115 2 is_stmt 1
	.loc 2 115 36 is_stmt 0
	li	a4,-1421869056
	sw	a4,12(s0)
	.loc 2 118 2 is_stmt 1
	.loc 2 118 56 is_stmt 0
	sw	zero,56(a5)
	.loc 2 121 2 is_stmt 1
	.loc 2 121 112 is_stmt 0
	sw	zero,8(a5)
	.loc 2 121 56
	sw	zero,24(a5)
	.loc 2 131 2 is_stmt 1
	.loc 2 131 13 is_stmt 0
	call	matmul
.LVL5:
	.loc 2 132 2 is_stmt 1
	.loc 2 132 43 is_stmt 0
	lw	a5,0(a0)
	.loc 2 133 47
	lw	a2,4(a0)
	.loc 2 134 47
	lw	a3,8(a0)
	.loc 2 135 47
	lw	a4,12(a0)
	.loc 2 132 43
	slli	a5,a5,16
	.loc 2 132 36
	sw	a5,12(s0)
	.loc 2 133 2 is_stmt 1
	.loc 2 133 47 is_stmt 0
	slli	a2,a2,16
	.loc 2 139 47
	lw	a5,36(a0)
	.loc 2 134 47
	slli	a3,a3,16
	.loc 2 133 36
	sw	a2,12(s0)
	.loc 2 134 2 is_stmt 1
	.loc 2 134 36 is_stmt 0
	sw	a3,12(s0)
	.loc 2 135 2 is_stmt 1
	.loc 2 135 47 is_stmt 0
	slli	a4,a4,16
	.loc 2 135 36
	sw	a4,12(s0)
	.loc 2 139 2 is_stmt 1
	.loc 2 139 47 is_stmt 0
	slli	a5,a5,16
	.loc 2 139 36
	sw	a5,12(s0)
	.loc 2 149 2 is_stmt 1
	.loc 2 149 36 is_stmt 0
	li	a5,-1420754944
	.loc 2 151 1
	lw	ra,12(sp)
	.cfi_restore 1
	.loc 2 149 36
	sw	a5,12(s0)
	.loc 2 151 1
	lw	s0,8(sp)
	.cfi_restore 8
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE318:
	.size	main, .-main
	.text
.Letext0:
	.file 3 "/opt/riscv/lib/gcc/riscv32-unknown-elf/12.1.0/include/stdint-gcc.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x16b
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x5
	.4byte	.LASF14
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.LLRL4
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF2
	.byte	0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	.LASF4
	.byte	0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF5
	.byte	0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF6
	.byte	0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF7
	.byte	0x6
	.4byte	.LASF15
	.byte	0x3
	.byte	0x34
	.byte	0x1b
	.4byte	0x5c
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.byte	0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.byte	0x7
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.byte	0x8
	.4byte	.LASF12
	.byte	0x2
	.byte	0x16
	.byte	0xd
	.4byte	0x8a
	.4byte	0x8a
	.byte	0x9
	.byte	0
	.byte	0x2
	.4byte	0x6a
	.byte	0xa
	.4byte	.LASF16
	.byte	0x2
	.byte	0x23
	.byte	0x6
	.4byte	.LFB318
	.4byte	.LFE318-.LFB318
	.byte	0x1
	.byte	0x9c
	.4byte	0xc7
	.byte	0xb
	.string	"j"
	.byte	0x2
	.byte	0x25
	.byte	0x6
	.4byte	0x6a
	.byte	0xc
	.string	"tmp"
	.byte	0x2
	.byte	0x83
	.byte	0x7
	.4byte	0x8a
	.byte	0x1
	.byte	0x5a
	.byte	0xd
	.4byte	.LVL5
	.4byte	0x78
	.byte	0
	.byte	0xe
	.4byte	.LASF17
	.byte	0x1
	.byte	0x1a
	.byte	0x6
	.4byte	.LFB317
	.4byte	.LFE317-.LFB317
	.byte	0x1
	.byte	0x9c
	.4byte	0x118
	.byte	0xf
	.string	"p"
	.byte	0x1
	.byte	0x1a
	.byte	0x18
	.4byte	0x118
	.4byte	.LLST0
	.byte	0x3
	.4byte	0x129
	.4byte	.LBB10
	.4byte	.LLRL1
	.byte	0x1d
	.byte	0x10
	.4byte	0x136
	.4byte	.LLST2
	.byte	0x3
	.4byte	0x129
	.4byte	.LBB12
	.4byte	.LLRL3
	.byte	0x15
	.byte	0x4
	.4byte	0x136
	.byte	0
	.byte	0
	.byte	0
	.byte	0x2
	.4byte	0x124
	.byte	0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF11
	.byte	0x11
	.4byte	0x11d
	.byte	0x12
	.4byte	.LASF13
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x1
	.4byte	0x141
	.byte	0x13
	.string	"c"
	.byte	0x1
	.byte	0x12
	.byte	0x13
	.4byte	0x11d
	.byte	0
	.byte	0x14
	.4byte	0x129
	.4byte	.LFB316
	.4byte	.LFE316-.LFB316
	.byte	0x1
	.byte	0x9c
	.byte	0x15
	.4byte	0x136
	.byte	0x1
	.byte	0x5a
	.byte	0x16
	.4byte	0x129
	.4byte	.LBB4
	.4byte	.LBE4-.LBB4
	.byte	0x1
	.byte	0x15
	.byte	0x3
	.byte	0x4
	.4byte	0x136
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0xf
	.byte	0
	.byte	0xb
	.byte	0x21
	.byte	0x4
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x52
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x58
	.byte	0x21
	.byte	0x1
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0x21
	.byte	0x3
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0x1f
	.byte	0x1b
	.byte	0x1f
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x3c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xd
	.byte	0x48
	.byte	0
	.byte	0x7d
	.byte	0x1
	.byte	0x7f
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x10
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x11
	.byte	0x26
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x12
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x20
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x13
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x14
	.byte	0x2e
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0x15
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x16
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.4byte	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.Ldebug_loc0:
.LLST0:
	.byte	0x7
	.4byte	.LVL1
	.4byte	.LVL2
	.byte	0x1
	.byte	0x5a
	.byte	0x7
	.4byte	.LVL2
	.4byte	.LFE317
	.byte	0x1
	.byte	0x5a
	.byte	0
.LLST2:
	.byte	0x7
	.4byte	.LVL2
	.4byte	.LVL3
	.byte	0x1
	.byte	0x5c
	.byte	0x7
	.4byte	.LVL4
	.4byte	.LFE317
	.byte	0x1
	.byte	0x5c
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB318
	.4byte	.LFE318-.LFB318
	.4byte	0
	.4byte	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x4
	.byte	0
	.4byte	0
.LLRL1:
	.byte	0x6
	.4byte	.LBB10
	.4byte	.LBE10
	.byte	0x6
	.4byte	.LBB18
	.4byte	.LBE18
	.byte	0x6
	.4byte	.LBB19
	.4byte	.LBE19
	.byte	0
.LLRL3:
	.byte	0x6
	.4byte	.LBB12
	.4byte	.LBE12
	.byte	0x6
	.4byte	.LBB15
	.4byte	.LBE15
	.byte	0
.LLRL4:
	.byte	0x6
	.4byte	.Ltext0
	.4byte	.Letext0
	.byte	0x6
	.4byte	.LFB318
	.4byte	.LFE318
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF12:
	.string	"matmul"
.LASF14:
	.string	"GNU C17 12.1.0 -mabi=ilp32 -mtune=rocket -misa-spec=2.2 -march=rv32i -g -O2 -ffreestanding"
.LASF6:
	.string	"unsigned char"
.LASF8:
	.string	"long unsigned int"
.LASF7:
	.string	"short unsigned int"
.LASF13:
	.string	"putchar"
.LASF16:
	.string	"main"
.LASF10:
	.string	"unsigned int"
.LASF9:
	.string	"long long unsigned int"
.LASF5:
	.string	"long long int"
.LASF11:
	.string	"char"
.LASF17:
	.string	"print"
.LASF3:
	.string	"short int"
.LASF15:
	.string	"uint32_t"
.LASF4:
	.string	"long int"
.LASF2:
	.string	"signed char"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"counter_la_mm.c"
.LASF1:
	.string	"/home/ubuntu/Desktop/caravel-soc_fpga-lab/lab-sdram/testbench/counter_la_mm"
	.ident	"GCC: (g1ea978e3066) 12.1.0"
