#include p18f87k22.inc
    
    global  Create_Board, Create_Empty_Board
    
    extern Draw_Grid
    extern Write_Cell
    extern number_name
    extern sudoku_y, sudoku_x
    extern sudoku_brdplayer, sudoku_brdsolution
    extern sudoku_brdfixedp
    
    constant board_length = .81

Storage	code    
	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Board 1 Solutions
no1s_row0  data  .1,.9,.8, .7,.5,.6, .4,.3,.2
no1s_row1  data  .3,.2,.6, .1,.9,.4, .8,.5,.7
no1s_row2  data  .5,.4,.7, .3,.2,.8, .1,.6,.9
	
no1s_row3  data  .2,.6,.9, .5,.1,.7, .3,.8,.4
no1s_row4  data  .7,.1,.3, .4,.8,.9, .5,.2,.6
no1s_row5  data  .4,.8,.5, .6,.3,.2, .7,.9,.1
	
no1s_row6  data  .9,.3,.2, .8,.4,.1, .6,.7,.5
no1s_row7  data  .6,.5,.4, .9,.7,.3, .2,.1,.8
no1s_row8  data  .8,.7,.1, .2,.6,.5, .9,.4,.3
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Board 1 Fixed Points
no1h_row0  data  .1,.0,.1, .0,.0,.1, .1,.0,.0
no1h_row1  data  .0,.0,.1, .0,.1,.0, .1,.0,.1
no1h_row2  data  .1,.0,.0, .0,.0,.0, .0,.0,.0
	
no1h_row3  data  .1,.1,.1, .1,.0,.0, .0,.1,.0
no1h_row4  data  .0,.0,.0, .1,.0,.1, .0,.0,.0
no1h_row5  data  .0,.1,.0, .0,.0,.1, .1,.1,.1
	
no1h_row6  data  .0,.0,.0, .0,.0,.0, .0,.0,.1
no1h_row7  data  .1,.0,.1, .0,.1,.0, .1,.0,.0
no1h_row8  data  .0,.0,.1, .1,.0,.0, .1,.0,.1

	
vars	udata_acs   
counter res 1
 
main	code
	
Create_Board
	call	Draw_Grid
	
	lfsr	FSR0, sudoku_brdsolution	; Load FSR0 with address in RAM
	lfsr	FSR1, sudoku_brdfixedp	; Load FSR0 with address in RAM
	
	call	Read_in_Board_1
	
	movlw	0x00
	movwf	sudoku_x
	movwf	sudoku_y

fillout_lp
	lfsr	0, sudoku_brdsolution	; Load FSR0 with address in RAM
	lfsr	1, sudoku_brdfixedp	; Load FSR0 with address in RAM
	lfsr	2, sudoku_brdplayer	; Load FSR0 with address in RAM
	
	movlw	0x09
	mulwf	sudoku_x
	movf    sudoku_y, w
	addwf   PRODL, w ;find index position of cursor cell within suduko
	movwf	counter
	tstfsz	counter
	bra	cheeselp
	bra	pass_cheeselp
	
cheeselp
	movf	POSTINC0, w
	movf	POSTINC1, w
	movf	POSTINC2, w
	decfsz	counter
	bra	cheeselp
	
pass_cheeselp
	
	tstfsz	POSTINC1
	bra	write_hint
	bra	write_no_hint

write_hint
	movf	POSTINC0, w
	movwf	POSTINC2
	movwf	number_name
	call	Write_Cell
	bra	iterate
	
write_no_hint
	movlw	0x00
	movwf	POSTINC2
	movf	POSTINC0, w
	bra	iterate

iterate
	incf	sudoku_y, f
	movlw	0x09
	cpfseq	sudoku_y
	bra	fillout_lp
	
	clrf	sudoku_y
	incf	sudoku_x, f
	movlw	0x09
	cpfseq	sudoku_x
	bra	fillout_lp
	
	return

Read_in_Board_1
	movlw	upper(no1s_row0)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row0)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row0)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row1)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row1)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row1)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row2)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row2)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row2)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row3)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row3)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row3)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row4)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row4)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row4)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row5)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row5)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row5)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row6)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row6)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row6)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row7)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row7)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row7)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	movlw	upper(no1s_row8)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1s_row8)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1s_row8)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read0
	
	movlw	upper(no1h_row0)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row0)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row0)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row1)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row1)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row1)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row2)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row2)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row2)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row3)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row3)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row3)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row4)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row4)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row4)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row5)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row5)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row5)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row6)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row6)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row6)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row7)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row7)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row7)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	movlw	upper(no1h_row8)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(no1h_row8)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(no1h_row8)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	call	nine_byte_read1
	
	return
	
	
nine_byte_read0
	movlw	0x9	; bytes to read
	movwf 	counter	; counter register
rd0lp 
	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0
	tblrd*+	
	decfsz	counter	; count down to zero
	bra	rd0lp		; keep going until finished
	
	return

nine_byte_read1
	movlw	0x9	; bytes to read
	movwf 	counter	; counter register
rd1lp 
	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC1; move data from TABLAT to (FSR0), inc FSR0
	tblrd*+	
	decfsz	counter	; count down to zero
	bra	rd1lp		; keep going until finished
	
	return
	
Create_Empty_Board
	call	Draw_Grid
	
	lfsr	0, sudoku_brdplayer
	movlw	board_length
	movwf	counter
	movlw	0x00
pllp
	movwf	POSTINC0
	decfsz	counter
	bra	pllp
	
	lfsr	0, sudoku_brdsolution
	movlw	board_length
	movwf	counter
	movlw	0x00
sllp
	movwf	POSTINC0
	decfsz	counter
	bra	sllp
	
	lfsr	0, sudoku_brdfixedp
	movlw	board_length
	movwf	counter
	movlw	0x00
fplp
	movwf	POSTINC0
	decfsz	counter
	bra	fplp
	
	return
    end


