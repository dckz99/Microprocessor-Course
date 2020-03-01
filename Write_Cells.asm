#include p18f87k22.inc
	
	global Write_Cell, Write_Cells_Setup
	global number_name
	global sudoku_x, sudoku_y
	global Write_Cursor
	

	extern Set_GLCD_Cursor_X, Set_GLCD_Cursor_Y
	extern Write_Block, Read_Block
	extern cursor_x, cursor_y
	extern sudoku_brdplayer
	
	
Storage	code    
Y_Table_PM  data .3,.9,.15,.23,.29,.35,.43,.49,.55
	    ; y adress (on GLCD) of left side pixel of 5x5 sudoku cell
	    ; for sudoku columns 0-8
	    constant    Y_Table_length = 9
	    
X_Table_PM  data .0,.1,.1,.2,.3,.4,.5,.6,.6, .5,.5,.1,.1,.3,.5,.5,.5,.1, .3,.1,.7,.7,.5,.3,.3,.1,.7
	    ; x adress (row on GLCD) of top part of 5x5 sudoku cell
	    ; how many pixel rows are there of 5x5 shape in this upper row
	    ; upoccupied pixel rows above 5x5 cell in upper row
	    ; for suduko rows 0-8, 0-8, 0-8
	    constant    X_Table_length = 27
	    
X_UMask_Table_PM  data 0x07,0xC1,0x7F, 0x7F,0x1F,0x07, 0x07,0xC1,0x7F
	    ; data masks for upper part of 5x5 cells
	    ; for suduko rows 0-8
	    constant    X_UMask_Table_length = 9
	    
X_LMask_Table_PM  data 0xFF,0xFF,0xF0, 0xF0,0xFC,0xFF, 0xFF,0xFF,0xF0
	    ; data masks for lower part of 5x5 cells
	    ; for suduko rows 0-8
	    constant    X_LMask_Table_length = 9
	    

Shapes_PM1   data   0x00,0x00,0x00,0x00,0x00, 0x00,0x12,0x1F,0x10,0x00, 0x1D,0x15,0x15,0x15,0x17
Shapes_PM2   data   0x11,0x11,0x15,0x15,0x1F, 0x07,0x04,0x04,0x04,0x1F, 0x17,0x15,0x15,0x15,0x1D
Shapes_PM3   data   0x1F,0x15,0x15,0x15,0x1D, 0x01,0x01,0x19,0x05,0x03, 0x1F,0x15,0x15,0x15,0x1F
Shapes_PM4   data   0x17,0x15,0x15,0x15,0x1F, 0x1F,0x1F,0x1F,0x1F,0x1F
   ; 5 bytes of storage for shape paterns for each digit 0-9 and one solid block
	    constant	Shape_Table1_length = .15
	    constant	Shape_Table2_length = .15
	    constant	Shape_Table3_length = .15
	    constant	Shape_Table4_length = .10
   
Write_Cells_RAM400	udata	0x400    ; reserve data anywhere in RAM (here at 0x400)
Y_Table		res Y_Table_length    ; reserve 9 bytes for Column Look Up Table
X_Table		res X_Table_length	; reserve 27 bytes for Row Look Up Table
X_UMask_Table	res X_UMask_Table_length ; Mask storage
X_LMask_Table	res X_LMask_Table_length ; Mask storage

Write_Cells_RAM500	udata	0x500    ; reserve data anywhere in RAM (here at 0x400)
Shapes_Table	res Shape_Table1_length + Shape_Table2_length + Shape_Table3_length + Shape_Table4_length
	
acs0	    udata_acs
number_name res 1   ; Variables to be accessed from external programs
sudoku_x    res 1   ; sudoku coordinate of cell
sudoku_y    res 1   ; sudoku coordinate of cell
w_input	    res 1
 
Reading_Counter	res 1	
tlp_x		res 1	; x-pixel coordinate value of top left of 5x5 cell
tlp_y		res 1	; y-pixel coordinate value of top left of 5x5 cell
mask		res 1
rotate_counter	res 1
	
read_data	res 5
shifted_shape	res 5
	
counter		res 1
	

Main	code
 
Write_Cells_Setup
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Read In Y Look Up Table From PM to RAM
	
	lfsr	FSR0, Y_Table	; Load FSR0 with address in RAM	
	movlw	upper(Y_Table_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(Y_Table_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(Y_Table_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	Y_Table_length	; bytes to read
	movwf 	Reading_Counter	; counter register
Yrdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	Yrdlp		; keep going until finished	
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Read In X Look Up Table From PM to RAM
	
	lfsr	FSR0, X_Table	; Load FSR0 with address in RAM	
	movlw	upper(X_Table_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(X_Table_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(X_Table_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	X_Table_length	; bytes to read
	movwf 	Reading_Counter	; our counter register
Xrdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	Xrdlp		; keep going until finished	
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Read in Data Mask Tables From PM to RAM
	
	lfsr	FSR0, X_UMask_Table	; Load FSR0 with address in RAM	
	movlw	upper(X_UMask_Table_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(X_UMask_Table_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(X_UMask_Table_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	X_UMask_Table_length	; bytes to read
	movwf 	Reading_Counter	; our counter register
UMrdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	UMrdlp		; keep going until finished	
	
	lfsr	FSR0, X_LMask_Table	; Load FSR0 with address in RAM	
	movlw	upper(X_LMask_Table_PM)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(X_LMask_Table_PM)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(X_LMask_Table_PM)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	X_LMask_Table_length	; bytes to read
	movwf 	Reading_Counter	; our counter register
LMrdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	LMrdlp		; keep going until finished	

	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Read In Shape Look Up Table From PM to RAM
	
	lfsr	FSR0, Shapes_Table	; Load FSR0 with address in RAM	
	movlw	upper(Shapes_PM1)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(Shapes_PM1)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(Shapes_PM1)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	Shape_Table1_length	; bytes to read
	movwf 	Reading_Counter	; our counter register
S1rdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	S1rdlp		; keep going until finished
	
	movlw	upper(Shapes_PM2)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(Shapes_PM2)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(Shapes_PM2)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	Shape_Table2_length	; bytes to read
	movwf 	Reading_Counter	; our counter register
S2rdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	S2rdlp		; keep going until finished	
	
	movlw	upper(Shapes_PM3)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(Shapes_PM3)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(Shapes_PM3)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	Shape_Table3_length	; bytes to read
	movwf 	Reading_Counter	; our counter register
S3rdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	S3rdlp		; keep going until finished	
	
	movlw	upper(Shapes_PM4)	; address of data in PM
	movwf	TBLPTRU		; load upper bits to TBLPTRU
	movlw	high(Shapes_PM4)	; address of data in PM
	movwf	TBLPTRH		; load high byte to TBLPTRH
	movlw	low(Shapes_PM4)	; address of data in PM
	movwf	TBLPTRL		; load low byte to TBLPTRL
	movlw	Shape_Table4_length	; bytes to read
	movwf 	Reading_Counter	; our counter register
S4rdlp 	tblrd*+			; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0; move data from TABLAT to (FSR0), inc FSR0	
	tblrd*+	
	decfsz	Reading_Counter	; count down to zero
	bra	S4rdlp		; keep going until finished	
	
	return
	
Write_Cursor
	
	movff	cursor_x, sudoku_x
	movff	cursor_y, sudoku_y
	
	movwf	w_input
	
	movlw	0xFF
	cpfseq	w_input
	bra	wrt_true_val	;write true cursor value
	bra	wrt_solid_block	;passed value on w is 0xFF - write solid block
	
wrt_true_val	;find true value of cursor cell by indexing suduko board
	
	lfsr	FSR0, sudoku_brdplayer
	
	movlw	0x09
	mulwf	cursor_x
	movf    cursor_y, w
	addwf   PRODL, w ;find index position of cursor cell within suduko
	
	movff	PLUSW0, number_name ;find cursor value
	
	call	Write_Cell
	
	return
	
wrt_solid_block	;draw current cell as a solid block
	
	movlw	0x0A		;10th c
	movwf	number_name
	
	call	Write_Cell
	
	return
	
	
	
Write_Cell
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Index Look Up Table - For Top Section
	
	movf	sudoku_y, w	; Index y-look up table with sudoku_y 
	lfsr	FSR0, Y_Table	; to find tlp_y
	movff	PLUSW0, tlp_y
	
	movf	sudoku_x, w	; Index x-look up table with sudoku_x 
	lfsr	FSR0, X_Table	; to find tlp_x
	movff	PLUSW0, tlp_x
	lfsr	FSR0, X_UMask_Table	; to find upper mask
	movff	PLUSW0, mask
	
	lfsr	FSR0, X_Table
	movf	sudoku_x, w	; Index x-look up table with sudoku_x 
	addlw	.18		; Access Same Row, Third column of look up table
	movff	PLUSW0, rotate_counter	; Rotate Right Counter 
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~Read in and Rotate 5x5 Shape - For Top Section
	
	call	Read_in_Shape
	
trtlp	movlw	0x05
	movwf	counter		; Column Counter
	lfsr	FSR1, shifted_shape
tsslp	addlw	0x00		; Clear Carry Bit
	rlcf	POSTINC1, f	; Rotate through carry
	decfsz	counter
	bra	tsslp
	decfsz	rotate_counter	; At least 1 rotation is always requiered
	bra	trtlp		; Shifted Shape Data now stored at shifted_shape
	
	call	Read_and_Replace_GLCD_Chunk
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Index Look Up Table - For Bottom Section
	

	lfsr	FSR0, X_Table
	movf	sudoku_x, w	; Index x-look up table with sudoku_x 
	addlw	.9		; Access Same Rowa, 2nd column of look up table
	movff	PLUSW0, rotate_counter	; Rotate Right Counter 
	
	movlw	0x05
	cpfseq	rotate_counter
	bra	draw_bottom	; Exit if Bottom Section isn't Needed
	return
	
draw_bottom
	
	movf	sudoku_x, w	; Index x-look up table with sudoku_x 
	lfsr	FSR0, X_LMask_Table	; to find lower mask
	movff	PLUSW0, mask
	
	incf	tlp_x, f	; Move to Next Row
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~Read in and Rotate 5x5 Shape - For Top Section
	
	call	Read_in_Shape
	
brtlp	movlw	0x05
	movwf	counter		; Column Counter
	lfsr	FSR1, shifted_shape
bsslp	addlw	0x00		; Clear Carry Bit
	rrcf	POSTINC1, f	; Rotate through carry
	decfsz	counter
	bra	bsslp
	decfsz	rotate_counter	; At least 1 rotation is always requiered
	bra	brtlp		; Shifted Shape Data now stored at shifted_shape
	
	call	Read_and_Replace_GLCD_Chunk
	
	
	return
	
	
Read_in_Shape
	movlw	0x05
	movwf	counter		    ; Shape is 5 long
	lfsr	FSR1, shifted_shape ; Destination
	lfsr	FSR0, Shapes_Table  ; Source - up-table
	movlw	0x05
	mulwf	number_name
	movf	PRODL, w	; Create Index for Begining of Relevant Shape
idlp	movff	PLUSW0, POSTINC1
	addlw	0x01
	decfsz	counter
	bra	idlp		; Shape is read into shifted_shape
	
	return
	
Read_and_Replace_GLCD_Chunk
	
	movf	tlp_x, w
	call	Set_GLCD_Cursor_X
	movf	tlp_y, w
	call	Set_GLCD_Cursor_Y	; Move GLCD_Cursor to Target Cell
	lfsr	FSR2, read_data
	movlw	0x05		; Target Cell is of Length 5
	call	Read_Block	; Read Current State of Target Cell to read_data
	
	movlw	0x05
	movwf	counter
	lfsr	FSR2, read_data
	lfsr	FSR1, shifted_shape
	lfsr	FSR0, read_data
cmlp	movf	mask, w
	andwf	POSTINC0, f		; Apply Mask to Data
	movf	POSTINC1, w
	addwf	POSTINC2, f	; Add in shape data 
	decfsz	counter
	bra	cmlp		; Upper shape data is now at read_data and ready
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Write Data to GLCD - For Top Section	
	
	movf	tlp_y, w
	call	Set_GLCD_Cursor_Y	; Move GLCD_Cursor to Target Cell
	lfsr	FSR2, read_data
	movlw	0x05		; Target Cell is of Length 5
	call	Write_Block	; Read Current State of Target Cell to read_data
	
	return

	end