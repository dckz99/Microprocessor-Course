    #include p18f87k22.inc
    
	global write_correct, write_wrong
	global write_title, write_credit

	extern Set_GLCD_Cursor_X_2, Set_GLCD_Cursor_Y_2
	extern Write_Block_2
	
	
Storage	code    
C_PM data 0x38,0x44,0x44,0x28
	constant    C_length = 4
O_PM data 0x38,0x44,0x44,0x38
	constant    O_length = 4
R_PM data 0x7C,0x14,0x34,0x48
	constant    R_length = 4
E_PM data 0x7C,0x54,0x54,0x44
	constant    E_length = 4
T_PM data 0x04,0x04,0x7C,0x04,0x04
	constant    T_length = 5
	
E_Mark_PM data 0x5C
	constant    E_Mark_length = 1
	
W_PM data 0x7C,0x20,0x10,0x20,0x7C
	constant    W_length = 5
N_PM data 0x7C,0x08,0x10,0x7C
	constant    N_length = 4
G_PM data 0x38,0x44,0x54,0x30
	constant    G_length = 4

S_PM data 0x48,0x54,0x54,0x24
	constant    S_length = 4
U_PM data 0x3C,0x40,0x40,0x3C
	constant    U_length = 4
D_PM data 0x7C,0x44,0x44,0x38
	constant    D_length = 4
K_PM data 0x7C,0x10,0x28,0x44
	constant    K_length = 4
	
J_PM data 0x20,0x40,0x40,0x3C
	constant    J_length = 4
A_PM data 0x78,0x14,0x14,0x78
	constant    A_length = 4
	
and_PM data 0x10,0x10,0x00,0x38,0x08,0x30,0x00,0x10,0x10
	constant    and_length = 9
	
left_brace_PM data 0x10,0x10,0x10,0xF0
	constant    left_brace_length = 4
right_brace_PM data 0xF0,0x10,0x10,0x10
	constant    right_brace_length = 4
	
vars	udata_acs    ; reserve data anywhere in RAM (here at 0x400)
counter res 1
	
Write_Message_RAM300	udata	0x300    ; reserve data anywhere in RAM (here at 0x400)
row_message	res .64
	
Main	code
	
write_title
	movlw	0x00
	call	Set_GLCD_Cursor_X_2
	movlw	0x00
	call	Set_GLCD_Cursor_Y_2
	
	lfsr	2, row_message
	movlw	.12
	call	w_padding
	
	call	write_left_brace
	call	write_s
	call	write_u
	call	write_d
	call	write_o
	call	write_k
	call	write_u
	call	write_right_brace
	
	movlw	.13
	call	w_padding
	
	lfsr	2, row_message
	movlw	.64
	call	Write_Block_2
	
	movlw	0x01
	call	Set_GLCD_Cursor_X_2
	movlw	0x00
	call	Set_GLCD_Cursor_Y_2
	
	lfsr	2, row_message
	movlw	.15
	call	w_padding
	
	movlw	.33
	movwf	counter
	movlw	b'00000001'
ullp	movwf	POSTINC2
	decfsz	counter
	bra	ullp
	
	movlw	.16
	call	w_padding
	
	lfsr	2, row_message
	movlw	.64
	call	Write_Block_2
	
	return
	
write_credit
	
	movlw	0x07
	call	Set_GLCD_Cursor_X_2
	movlw	0x00
	call	Set_GLCD_Cursor_Y_2
	
	lfsr	2, row_message
	movlw	.10
	call	w_padding
	
	call	write_j
	call	write_a
	call	write_c
	call	write_and
	call	write_d
	call	write_a
	call	write_k
	
	movlw	.10
	call	w_padding
	
	return
	
write_correct
	movlw	0x03
	call	Set_GLCD_Cursor_X_2
	movlw	0x00
	call	Set_GLCD_Cursor_Y_2
	
	lfsr	2, row_message
	
	movlw	.13
	call	w_padding
	
	call	write_c
	call	write_o
	call	write_r
	call	write_r
	call	write_e
	call	write_c
	call	write_t
	call	write_e_mark
	
	movlw	.12
	call	w_padding
	
	lfsr	2, row_message
	movlw	.64
	call	Write_Block_2
	
	return

	
write_wrong
	
	movlw	0x03
	call	Set_GLCD_Cursor_X_2
	movlw	0x00
	call	Set_GLCD_Cursor_Y_2
	
	lfsr	2, row_message
	
	movlw	.18
	call	w_padding

	call	write_w
	call	write_r
	call	write_o
	call	write_n
	call	write_g
	call	write_e_mark
	
	movlw	.17
	call	w_padding
	
	lfsr	2, row_message
	movlw	.64
	call	Write_Block_2
	
	return
	
w_padding   ; Pad FSP2 with W number of 0x00 bytes
	movwf	counter
wplp
	movlw	0x00
	movwf	POSTINC2
	decfsz	counter
	bra	wplp
	return
	
load_letter
	movwf 	counter	; our counter register
lllp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC2; move data from TABLAT to (FSR2), inc FSR2
	tblrd*+	
	decfsz	counter	; count down to zero
	bra	lllp		; keep going until finished
	return

	
write_c
	movlw	upper(C_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(C_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(C_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	C_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return

write_o	
	movlw	upper(O_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(O_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(O_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	O_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_r
	movlw	upper(R_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(R_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(R_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	R_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_e
	
	movlw	upper(E_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(E_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(E_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	E_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_t
	
	movlw	upper(T_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(T_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(T_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	T_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return

write_e_mark
	
	movlw	0x00
	movwf	POSTINC2
	
	movlw	upper(E_Mark_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(E_Mark_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(E_Mark_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	E_Mark_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	

write_w
	movlw	upper(W_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(W_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(W_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	W_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_n
	movlw	upper(N_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(N_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(N_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	N_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return

write_g
	movlw	upper(G_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(G_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(G_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	G_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_s
	movlw	upper(S_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(S_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(S_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	S_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_u
	movlw	upper(U_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(U_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(U_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	U_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_d
	movlw	upper(D_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(D_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(D_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	D_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_k
	movlw	upper(K_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(K_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(K_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	K_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_j
	movlw	upper(J_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(J_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(J_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	J_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_a
	movlw	upper(A_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(A_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(A_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	A_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_left_brace
	movlw	upper(left_brace_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(left_brace_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(left_brace_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	left_brace_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_right_brace
	movlw	upper(right_brace_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(right_brace_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(right_brace_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	right_brace_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	
write_and
	movlw	upper(and_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(and_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(and_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	and_length	; bytes to read
	call	load_letter
	
	movlw	0x00
	movwf	POSTINC2
	
	return
	end