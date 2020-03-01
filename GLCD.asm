#include p18f87k22.inc

    global GLCD_Setup, Clear_Board
    global Set_GLCD_Cursor_X, Set_GLCD_Cursor_Y
    global Set_GLCD_Cursor_X_2, Set_GLCD_Cursor_Y_2
    global Test_Write_2, Test_Write
    global Send_Data
    global Write_Block, Read_Block
    global Write_Block_2
    
acs0	    udata_acs   ; reserve data space in access ram
delay_count     res 1	; reserve one byte for counter in the delay 
delay_count1     res 1	
delay_count2     res 1	
test_col_count	res 1
test_row_count	res 1
block_count	res 1
shift_count	res 1
	
	    	; GLCD Control Pins - PORTB
	constant    GLCD_CS1 = 0 ; Notted - select left side
    	constant    GLCD_CS2 = 1 ; Notted - select right side
	constant    GLCD_RS  = 2 ; H - Data / L - Instruction
    	constant    GLCD_RW  = 3 ; H - Read / L - Write
	constant    GLCD_E   = 4 ; Enable Pulse
    	constant    GLCD_RST = 5 ; Reset Pin
	
		; Instruction Protocols for Changing Position
	constant    X_Instr = b'10111000'
	constant    Y_Instr = b'01000000'
	    

glcd	code
 
GLCD_Setup
	
	clrf	TRISB		; Set PORT B and D Out
	clrf	TRISD
	
	clrf	PORTD		; Reset PORT B and D 
	clrf	LATB

	call	Delay
	
	bsf	LATB, GLCD_RST	; Disable Reset
	
	bcf	LATB, GLCD_CS2	; Right Side
	bcf	LATB, GLCD_CS1	; Left Side
	
	call	Delay
	
	movlw	0x3F		; Turn On Instruction
	call	Send_Instr
	
	call	Clear_Board  
	
	movlw	b'11000000'
	call	Send_Instr
	
	bsf	LATB, GLCD_CS2	; Right Side
	bcf	LATB, GLCD_CS1	; Left Side
	
	return
	
Clear_Board ; Clear Every Pixel on Current Side of Board
	clrf	test_row_count	; Row Counter = 0
	
rclrlp	    ; Iterate Over Rows
	movlw	X_Instr		; Format Row Count as Row Command
	iorwf	test_row_count, w
	call	Send_Instr	; Change Row
	
	clrf	test_col_count	; Col Counter = 0
cclrlp	    ; Iterate Over Cols, Nested inside Row Iteration
	movlw	0x00
	call	Send_Data	; Clear Col
	incf	test_col_count, f
	movlw	0x40
	cpfsgt	test_col_count	; Skip if counter > 64
	bra	cclrlp	
	
	incf	test_row_count, f
	movlw	0x8
	cpfseq	test_row_count	; Skip if counter = 8
	bra	rclrlp	
	
	return
	

	
Write_Block ; Write block of length W of data from FSR2 to GLCD
	bsf	LATB, GLCD_RS   ; Data
	bcf	LATB, GLCD_RW  	; Write
	
	movwf	block_count	; Set Number of Columns to Write
	
wblp	movff	POSTINC2, PORTD ; Move FSR2 value to PORTD
	call	E_Pulse		; Enable Pulse
	decfsz	block_count
	bra	wblp
	
	return
	
Write_Block_2 ; Write block of length W of data from FSR2 to right hand GLCD
	
	bcf	LATB, GLCD_CS2	; Right Side
	bsf	LATB, GLCD_CS1	; Left Side
	
	call	Write_Block
	
	bsf	LATB, GLCD_CS2	; Right Side
	bcf	LATB, GLCD_CS1	; Left Side
	
	return
	
Read_Block ; Read block of length W of data from GLCD to FSR2
	setf	TRISD
	
	bsf	LATB, GLCD_RS   ; Data
	bsf	LATB, GLCD_RW  	; Read
	
	movwf	block_count	; Set Number of Columns to Read
	
	call	E_Pulse		; Enter reading mode
	
rblp	bsf	LATB, GLCD_E   	; Enable Pin High
	call	Delay
	
	movff	PORTD, POSTINC2 ; Move Data Value to FSR2
	
	bcf	LATB, GLCD_E    ; Enable Pin Low
	call	Delay
	
	decfsz	block_count
	bra	rblp
	
	clrf	TRISD
	
	return
	
	
Test_Write	; Write Two Numbers to Board
	
	call	Reset_GLCD_Cursor
	
	movlw	0x00
	call	Send_Data
	movlw	b'00111110'
	call	Send_Data
	movlw	b'00101010'
	call	Send_Data
	movlw	b'00101010'
	call	Send_Data
	movlw	b'00101010'
	call	Send_Data
	movlw	b'00111010'
	call	Send_Data
	
	movlw	0x00
	call	Send_Data
	movlw	b'00101110'
	call	Send_Data
	movlw	b'00101010'
	call	Send_Data
	movlw	b'00101010'
	call	Send_Data
	movlw	b'00101010'
	call	Send_Data
	movlw	b'00111110'
	call	Send_Data
	
	movlw	0x00
	call	Send_Data
	
	return
	
Test_Write_2	; Write a Pattern to Every Row on Current Side
	
	clrf	test_row_count	; Counter Initially 0
twtp	
	movlw	Y_Instr		; Reset Y
	call	Send_Instr
	
	movlw	X_Instr		; Format Row Count as Row Command
	iorwf	test_row_count, w
	call	Send_Instr
	
	movlw	0x01
	movwf	test_col_count	  
rplp	movf	test_col_count, w
	call	Send_Data	; Send Counter as Data
	incf	test_col_count, f
	movlw	0x40
	cpfsgt	test_col_count	; Skip if counter > 64
	bra	rplp		 

	incf	test_row_count, f
	movlw	0x8
	cpfseq	test_row_count	; Skip if counter = 8
	bra	twtp	
	return
	
	
Reset_GLCD_Cursor   ; Move GLCD Cursor to top left corner of GLCD
	movlw	b'10111000'
	call	Send_Instr
	movlw	b'01000000'
	call	Send_Instr
	
	return
	
Set_GLCD_Cursor_X			; Move to Row W
	iorlw	X_Instr		; Format W as Row Command
	call	Send_Instr
	return
	
Set_GLCD_Cursor_Y			; Move to Column W
	iorlw	Y_Instr		; Format W as Column Command
	call	Send_Instr
	return
	
Set_GLCD_Cursor_X_2			; Move to Row W
	bcf	LATB, GLCD_CS2	; Right Side
	bsf	LATB, GLCD_CS1	; Left Side
	
	movwf	test_row_count
	movlw	X_Instr		; Format Row Count as Row Command
	iorwf	test_row_count, w
	call	Send_Instr	; Change Row
	
	bsf	LATB, GLCD_CS2	; Right Side
	bcf	LATB, GLCD_CS1	; Left Side
	return
	
Set_GLCD_Cursor_Y_2			; Move to Column W
	bcf	LATB, GLCD_CS2	; Right Side
	bsf	LATB, GLCD_CS1	; Left Side
	
	movwf	test_col_count
	movlw	Y_Instr		; Format Row Count as Row Command
	iorwf	test_col_count, w
	call	Send_Instr	; Change Row
	
	bsf	LATB, GLCD_CS2	; Right Side
	bcf	LATB, GLCD_CS1	; Left Side
	return

Send_Data			; Send WREG as Data
	movwf	PORTD
	bsf	LATB, GLCD_RS   ; Data
	bcf	LATB, GLCD_RW  	; Write
	call	E_Pulse		; Enable Pulse
	return

Send_Instr			; Send WREG as Instruction
	movwf	PORTD		
	bcf	LATB, GLCD_RS	; Instruction
	bcf	LATB, GLCD_RW  	; Write
	call	E_Pulse		; Enable Pulse
	return

E_Pulse
	bsf	LATB, GLCD_E   	; Enable Pin High
	call	Delay
	bcf	LATB, GLCD_E    ; Enable Pin Low
	call	Delay
	return
	
Delay	;   3.4 us Delay
	movlw	b'00010000'	
	movwf	delay_count
dllp1	decfsz	delay_count
	bra	dllp1

;	movlw	0xFF	
;	movwf	delay_count1
;dllp1	
;	movlw	0xFF	
;	movwf	delay_count2
;	
;dllp2	decfsz	delay_count2
;	bra	dllp2
;	
;	decfsz	delay_count1
;	bra	dllp1

	return
	
	end