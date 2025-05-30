	.file	"isr.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/ubuntu/Desktop/lab-wlos_baseline_1/testbench/integrate" "../../firmware/isr.c"
	.align	2
	.globl	isr
	.type	isr, @function
isr:
.LFB321:
	.file 1 "../../firmware/isr.c"
	.loc 1 24 1
	.cfi_startproc
	.loc 1 32 5
.LBB13:
.LBB14:
	.file 2 "../../firmware/irq_vex.h"
	.loc 2 36 2
	.loc 2 37 2
 #APP
# 37 "../../firmware/irq_vex.h" 1
	csrr a4, 4032
# 0 "" 2
.LVL0:
	.loc 2 38 2
 #NO_APP
.LBE14:
.LBE13:
.LBB15:
.LBB16:
	.loc 2 24 2
	.loc 2 25 2
 #APP
# 25 "../../firmware/irq_vex.h" 1
	csrr a5, 3008
# 0 "" 2
.LVL1:
	.loc 2 26 2
 #NO_APP
.LBE16:
.LBE15:
	.loc 1 33 5
	.loc 1 34 5
	.loc 1 35 5
	.loc 1 32 14 is_stmt 0
	and	a5,a5,a4
.LVL2:
	.loc 1 35 15
	andi	a5,a5,4
.LVL3:
	.loc 1 35 8
	beq	a5,zero,.L9
.LBB17:
	.loc 1 36 9 is_stmt 1
.LVL4:
.LBB18:
	.file 3 "../../firmware/csr.h"
	.loc 3 779 2
.LBB19:
.LBB20:
	.file 4 "../../firmware/hw/common.h"
	.loc 4 34 2
.LBE20:
.LBE19:
.LBE18:
.LBE17:
	.loc 1 24 1 is_stmt 0
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s1,4(sp)
.LBB27:
.LBB25:
.LBB23:
.LBB21:
	.loc 4 34 32
	li	a5,-268406784
.LBE21:
.LBE23:
.LBE25:
.LBE27:
	.loc 1 24 1
	sw	ra,12(sp)
	sw	s0,8(sp)
	.cfi_offset 9, -12
	.cfi_offset 1, -4
	.cfi_offset 8, -8
.LBB28:
.LBB26:
.LBB24:
.LBB22:
	.loc 4 34 32
	li	a4,1
	sw	a4,-2032(a5)
.LVL5:
.LBE22:
.LBE24:
.LBE26:
	.loc 1 38 9 is_stmt 1
	.loc 1 38 25 is_stmt 0
	li	a5,805306368
	lw	s1,16(a5)
.LVL6:
	.loc 1 39 9 is_stmt 1
	.loc 1 39 22
	ble	s1,zero,.L1
	.loc 1 39 15 is_stmt 0
	li	s0,0
.LVL7:
.L3:
	.loc 1 40 13 is_stmt 1 discriminator 3
	.loc 1 39 36 is_stmt 0 discriminator 3
	addi	s0,s0,1
.LVL8:
	.loc 1 40 22 discriminator 3
	call	uart_read
.LVL9:
	.loc 1 41 13 is_stmt 1 discriminator 3
	call	uart_write
.LVL10:
	.loc 1 39 36 discriminator 3
	.loc 1 39 22 discriminator 3
	bne	s1,s0,.L3
.LVL11:
.L1:
.LBE28:
	.loc 1 53 1 is_stmt 0
	lw	ra,12(sp)
	.cfi_restore 1
	lw	s0,8(sp)
	.cfi_restore 8
	lw	s1,4(sp)
	.cfi_restore 9
.LVL12:
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
.LVL13:
.L9:
	ret
	.cfi_endproc
.LFE321:
	.size	isr, .-isr
	.globl	counter
	.section	.sdata,"aw"
	.align	2
	.type	counter, @object
	.size	counter, 4
counter:
	.word	-65536
	.text
.Letext0:
	.file 5 "/opt/riscv/lib/gcc/riscv32-unknown-elf/12.1.0/include/stdint-gcc.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x1fa
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0xb
	.4byte	.LASF19
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
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
	.byte	0xc
	.4byte	.LASF20
	.byte	0x5
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
	.byte	0xd
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.byte	0xe
	.4byte	.LASF21
	.byte	0x1
	.byte	0x14
	.byte	0xa
	.4byte	0x50
	.byte	0x5
	.byte	0x3
	.4byte	counter
	.byte	0x3
	.4byte	.LASF11
	.byte	0xd
	.4byte	0x6a
	.4byte	0x9a
	.byte	0x4
	.byte	0
	.byte	0x3
	.4byte	.LASF12
	.byte	0xa
	.4byte	0x6a
	.4byte	0xaa
	.byte	0x4
	.byte	0
	.byte	0xf
	.string	"isr"
	.byte	0x1
	.byte	0x17
	.byte	0x6
	.4byte	.LFB321
	.4byte	.LFE321-.LFB321
	.byte	0x1
	.byte	0x9c
	.4byte	0x187
	.byte	0x5
	.4byte	.LASF13
	.byte	0x20
	.byte	0xe
	.4byte	0x50
	.4byte	.LLST0
	.byte	0x10
	.string	"buf"
	.byte	0x1
	.byte	0x21
	.byte	0x9
	.4byte	0x187
	.byte	0x11
	.string	"i"
	.byte	0x1
	.byte	0x22
	.byte	0x9
	.4byte	0x6a
	.4byte	.LLST1
	.byte	0x12
	.4byte	.LLRL2
	.4byte	0x156
	.byte	0x5
	.4byte	.LASF14
	.byte	0x26
	.byte	0xd
	.4byte	0x6a
	.4byte	.LLST3
	.byte	0x13
	.4byte	0x1c9
	.4byte	.LBB18
	.4byte	.LLRL4
	.byte	0x1
	.byte	0x24
	.byte	0x9
	.4byte	0x143
	.byte	0x2
	.4byte	0x1d7
	.4byte	.LLST5
	.byte	0x14
	.4byte	0x1e3
	.4byte	.LBB19
	.4byte	.LLRL4
	.byte	0x3
	.2byte	0x30b
	.byte	0x2
	.byte	0x2
	.4byte	0x1f4
	.4byte	.LLST6
	.byte	0x2
	.4byte	0x1ec
	.4byte	.LLST5
	.byte	0
	.byte	0
	.byte	0x6
	.4byte	.LVL9
	.4byte	0x9a
	.byte	0x6
	.4byte	.LVL10
	.4byte	0x8a
	.byte	0
	.byte	0x15
	.4byte	0x197
	.4byte	.LBB13
	.4byte	.LBE13-.LBB13
	.byte	0x1
	.byte	0x20
	.byte	0x15
	.4byte	0x170
	.byte	0x7
	.4byte	0x1a5
	.byte	0
	.byte	0x16
	.4byte	0x1b0
	.4byte	.LBB15
	.4byte	.LBE15-.LBB15
	.byte	0x1
	.byte	0x20
	.byte	0x25
	.byte	0x7
	.4byte	0x1be
	.byte	0
	.byte	0
	.byte	0x17
	.4byte	0x6a
	.4byte	0x197
	.byte	0x18
	.4byte	0x71
	.byte	0x3f
	.byte	0
	.byte	0x8
	.4byte	.LASF16
	.byte	0x22
	.4byte	0x71
	.4byte	0x1b0
	.byte	0x9
	.4byte	.LASF15
	.byte	0x24
	.4byte	0x71
	.byte	0
	.byte	0x8
	.4byte	.LASF17
	.byte	0x16
	.4byte	0x71
	.4byte	0x1c9
	.byte	0x9
	.4byte	.LASF18
	.byte	0x18
	.4byte	0x71
	.byte	0
	.byte	0x19
	.4byte	.LASF22
	.byte	0x3
	.2byte	0x30a
	.byte	0x14
	.byte	0x3
	.4byte	0x1e3
	.byte	0x1a
	.string	"v"
	.byte	0x3
	.2byte	0x30a
	.byte	0x39
	.4byte	0x50
	.byte	0
	.byte	0x1b
	.4byte	.LASF23
	.byte	0x4
	.byte	0x20
	.byte	0x14
	.byte	0x3
	.byte	0xa
	.string	"v"
	.byte	0x33
	.4byte	0x5c
	.byte	0xa
	.string	"a"
	.byte	0x44
	.4byte	0x5c
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
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x1
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0xc
	.byte	0x49
	.byte	0x13
	.byte	0x3c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x1
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
	.byte	0x6
	.byte	0x48
	.byte	0
	.byte	0x7d
	.byte	0x1
	.byte	0x7f
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x34
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x1c
	.byte	0x27
	.byte	0x19
	.byte	0x49
	.byte	0x13
	.byte	0x20
	.byte	0x21
	.byte	0x3
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0xf
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0x21
	.byte	0x4
	.byte	0x3b
	.byte	0x21
	.byte	0x20
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xb
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
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xc
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
	.byte	0xd
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
	.byte	0xe
	.byte	0x34
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
	.byte	0x3f
	.byte	0x19
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0x8
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
	.byte	0x10
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
	.byte	0x11
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
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x12
	.byte	0xb
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x13
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x52
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x14
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x52
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0x5
	.byte	0x57
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x15
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
	.byte	0x1
	.byte	0x13
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
	.byte	0x17
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x18
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x19
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0x5
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
	.byte	0x1a
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0x5
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x1b
	.byte	0x2e
	.byte	0x1
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
	.byte	0x6
	.byte	0x7f
	.byte	0
	.byte	0x7e
	.byte	0
	.byte	0x1a
	.byte	0x9f
	.byte	0x7
	.4byte	.LVL2
	.4byte	.LVL3
	.byte	0x1
	.byte	0x5f
	.byte	0
.LLST1:
	.byte	0x7
	.4byte	.LVL1
	.4byte	.LVL7
	.byte	0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x7
	.4byte	.LVL7
	.4byte	.LVL8
	.byte	0x1
	.byte	0x58
	.byte	0x7
	.4byte	.LVL8
	.4byte	.LVL10
	.byte	0x3
	.byte	0x78
	.byte	0x7f
	.byte	0x9f
	.byte	0x7
	.4byte	.LVL10
	.4byte	.LVL11
	.byte	0x1
	.byte	0x58
	.byte	0x7
	.4byte	.LVL13
	.4byte	.LFE321
	.byte	0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LLST3:
	.byte	0x7
	.4byte	.LVL6
	.4byte	.LVL12
	.byte	0x1
	.byte	0x59
	.byte	0
.LLST5:
	.byte	0x7
	.4byte	.LVL4
	.4byte	.LVL5
	.byte	0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LLST6:
	.byte	0x7
	.4byte	.LVL4
	.4byte	.LVL5
	.byte	0x6
	.byte	0x9e
	.byte	0x4
	.4byte	0xf0006810
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
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
.LLRL2:
	.byte	0x6
	.4byte	.LBB17
	.4byte	.LBE17
	.byte	0x6
	.4byte	.LBB27
	.4byte	.LBE27
	.byte	0x6
	.4byte	.LBB28
	.4byte	.LBE28
	.byte	0
.LLRL4:
	.byte	0x6
	.4byte	.LBB18
	.4byte	.LBE18
	.byte	0x6
	.4byte	.LBB25
	.4byte	.LBE25
	.byte	0x6
	.4byte	.LBB26
	.4byte	.LBE26
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF22:
	.string	"user_irq_0_ev_pending_write"
.LASF11:
	.string	"uart_write"
.LASF23:
	.string	"csr_write_simple"
.LASF12:
	.string	"uart_read"
.LASF21:
	.string	"counter"
.LASF19:
	.string	"GNU C17 12.1.0 -mabi=ilp32 -mtune=rocket -misa-spec=2.2 -march=rv32i -g -O2 -ffreestanding"
.LASF6:
	.string	"unsigned char"
.LASF8:
	.string	"long unsigned int"
.LASF7:
	.string	"short unsigned int"
.LASF17:
	.string	"irq_getmask"
.LASF10:
	.string	"unsigned int"
.LASF14:
	.string	"ex_times"
.LASF9:
	.string	"long long unsigned int"
.LASF5:
	.string	"long long int"
.LASF18:
	.string	"mask"
.LASF13:
	.string	"irqs"
.LASF3:
	.string	"short int"
.LASF20:
	.string	"uint32_t"
.LASF4:
	.string	"long int"
.LASF15:
	.string	"pending"
.LASF2:
	.string	"signed char"
.LASF16:
	.string	"irq_pending"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/ubuntu/Desktop/lab-wlos_baseline_1/testbench/integrate"
.LASF0:
	.string	"../../firmware/isr.c"
	.ident	"GCC: (g1ea978e3066) 12.1.0"
