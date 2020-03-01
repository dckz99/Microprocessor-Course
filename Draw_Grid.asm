#include p18f87k22.inc
	
	global Draw_Grid
	
	extern Set_GLCD_Cursor_X, Set_GLCD_Cursor_Y
	extern Send_Data
	
    
acs0	    udata_acs   ; reserve data space in access ram
current_row	    res 1
vert_lin_pattern    res 1
horz_lin_pattern    res 1
block_count	    res 1    
internal_block_count res 1

	
grid	code
 
Draw_Grid   ; Draw Empty Suduko Grid
	
	movlw	0x00
	movwf	current_row
	movlw	b'11111110'
	movwf	vert_lin_pattern
	movlw	b'00000010'
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	movlw	0x01
	movwf	current_row
	movlw	0xFF
	movwf	vert_lin_pattern
	movlw	0x00
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	movlw	0x02
	movwf	current_row
	movlw	0xFF
	movwf	vert_lin_pattern
	movlw	b'00100000'
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	movlw	0x03
	movwf	current_row
	movlw	0xFF
	movwf	vert_lin_pattern
	movlw	0x00
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	movlw	0x04
	movwf	current_row
	movlw	0xFF
	movwf	vert_lin_pattern
	movlw	0x00
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	movlw	0x05
	movwf	current_row
	movlw	0xFF
	movwf	vert_lin_pattern
	movlw	b'00000010'
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	movlw	0x06
	movwf	current_row
	movlw	0xFF
	movwf	vert_lin_pattern
	movlw	0x00
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	movlw	0x07
	movwf	current_row
	movlw	b'00111111'
	movwf	vert_lin_pattern
	movlw	b'00100000'
	movwf	horz_lin_pattern
	call	Draw_Grid_Row
	
	return
	

Draw_Grid_Row
	
	movf	current_row, w	; Set Cursor
	call	Set_GLCD_Cursor_X
	movlw	0x00
	call	Set_GLCD_Cursor_Y
	
	movlw	0x00	
	call	Send_Data	; Draw Padding
	
	movlw	0x03
	movwf	block_count	; Set Counter
	
blp	movf	vert_lin_pattern, w	
	call	Send_Data		; Draw Verticle Grid Line
	
	movlw	0x13
	movwf	internal_block_count	; Set Counter
	
bilp	movf	horz_lin_pattern, w
	call	Send_Data		; Draw Horizontal Grid Line
	decfsz	internal_block_count
	bra	bilp
	
	decfsz	block_count
	bra	blp
	
	movf	vert_lin_pattern, w	
	call	Send_Data
	
	movlw	0x00	
	call	Send_Data	; Draw Padding
	movlw	0x00	
	call	Send_Data	; Draw Padding
	
	return
	
	end