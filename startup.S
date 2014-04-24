/* 割り込みベクタ */

	.section .vector,"ax"
	.thumb
	.align 0

	.long	_main_stack		// MSP default value
	.long	reset_entry + 1		//  1: Reset
	.long	intr_entry + 1		//  2: NMI
	.long	hardfault_entry + 1	//  3: HardFault
	.long	intr_entry + 1		//  4: reserved
	.long	intr_entry + 1		//  5: reserved
	.long	intr_entry + 1		//  6: reserved
	.long	intr_entry + 1		//  7: reserved
	.long	intr_entry + 1		//  8: reserved
	.long	intr_entry + 1		//  9: reserved
	.long	intr_entry + 1		// 10: reserved
	.long	svc_entry + 1		// 11: SVCall
	.long	intr_entry + 1		// 12: reserved
	.long	intr_entry + 1		// 13: reserved
	.long	pendsv_entry + 1	// 14: PendSV
	.long	intr_entry + 1		// 15: SysTick
	.long	intr_entry + 1		// 16: External Interrupt(0)
	.long	intr_entry + 1		// 17: External Interrupt(1)
	.long	intr_entry + 1		// 18: External Interrupt(2)
	.long	intr_entry + 1		// 19: External Interrupt(3)
	.long	intr_entry + 1		// 20: External Interrupt(4)
	.long	intr_entry + 1		// 21: External Interrupt(5)
	.long	intr_entry + 1		// 22: External Interrupt(6)
	.long	intr_entry + 1		// 23: External Interrupt(7)
	.long	intr_entry + 1		// 24: External Interrupt(8)
	.long	intr_entry + 1		// 25: External Interrupt(9)
	.long	intr_entry + 1		// 26: External Interrupt(10)
	.long	intr_entry + 1		// 27: External Interrupt(11)
	.long	intr_entry + 1		// 28: External Interrupt(12)
	.long	intr_entry + 1		// 29: External Interrupt(13)
	.long	intr_entry + 1		// 30: External Interrupt(14)
	.long	intr_entry + 1		// 31: External Interrupt(15)
	.long	intr_entry + 1		// 32: External Interrupt(16)
	.long	intr_entry + 1		// 33: External Interrupt(17)
	.long	intr_entry + 1		// 34: External Interrupt(18)
	.long	intr_entry + 1		// 35: External Interrupt(19)
	.long	intr_entry + 1		// 36: External Interrupt(20)
	.long	intr_entry + 1		// 37: External Interrupt(21)
	.long	intr_entry + 1		// 38: External Interrupt(22)
	.long	intr_entry + 1		// 39: External Interrupt(23)
	.long	intr_entry + 1		// 40: External Interrupt(24)
	.long	intr_entry + 1		// 41: External Interrupt(25)
	.long	intr_entry + 1		// 42: External Interrupt(26)
	.long	intr_entry + 1		// 43: External Interrupt(27)
	.long	intr_entry + 1		// 44: External Interrupt(28)
	.long	intr_entry + 1		// 45: External Interrupt(29)
	.long	intr_entry + 1		// 46: External Interrupt(30)
	.long	intr_entry + 1		// 47: External Interrupt(31)
	.long	intr_entry + 1		// 48: External Interrupt(32)
	.long	intr_entry + 1		// 49: External Interrupt(33)
	.long	intr_entry + 1		// 50: External Interrupt(34)
	.long	intr_entry + 1		// 51: External Interrupt(35)
	.long	intr_entry + 1		// 52: External Interrupt(36)
	.long	intr_entry + 1		// 53: External Interrupt(37)
	.long	intr_entry + 1		// 54: External Interrupt(38)
	.long	intr_entry + 1		// 55: External Interrupt(39)
	.long	intr_entry + 1		// 56: External Interrupt(40)
	.long	intr_entry + 1		// 57: External Interrupt(41)
	.long	intr_entry + 1		// 58: External Interrupt(42)
	.long	intr_entry + 1		// 59: External Interrupt(43)
	.long	intr_entry + 1		// 60: External Interrupt(44)
	.long	intr_entry + 1		// 61: External Interrupt(45)
	.long	intr_entry + 1		// 62: External Interrupt(46)
	.long	intr_entry + 1		// 63: External Interrupt(47)

/* スタートアップ */

	.section .text
	.thumb
	.align 0
	.global reset_entry

reset_entry:
	/* 割り込み禁止 */
	cpsid	if

	/* ボード固有の設定 */
/*	bl	board_setup */

	/* .dataの初期化 */
data_init:
	ldr	r1, =_data_org
	ldr	r2, =_data_start
	ldr	r3, =_data_end
	cmp	r2, r3
	beq	bss_init
data_loop:
	ldrb	r0, [r1]
	add	r1, r1, #1
	strb	r0, [r2]
	add	r2, r2, #1
	cmp	r2, r3
	bne	data_loop

	/* .bssの初期化 */
bss_init:
	mov	r0, #0
	ldr	r2, =__bss_start__
	ldr	r3, =__bss_end__
	cmp	r2, r3
	beq	start_main
bss_loop:
	strb	r0, [r2]
	add	r2, r2, #1
	cmp	r2, r3
	bne	bss_loop

	/* メイン */
start_main:
	mov	r0, #0
	bl	main

	/* 暴走防止用の無限ループ */
die:
	b	die

	/* 各種例外処理 (何もしない) */
intr_entry:
	b	intr_entry

hardfault_entry:
	b	hardfault_entry
	
svc_entry:
	b	svc_entry

pendsv_entry:
	b	pendsv_entry

	.pool
