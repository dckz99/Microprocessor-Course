	#include p18f87k22.inc

;	extern	GLCD_Setup, Test_Write
;	extern	Test_Write_2, Clear_Board
;	extern	Draw_Grid
;	
;	extern Write_Cell, Write_Cells_Setup
;	extern number_name
;	extern sudoku_x, sudoku_y
;	
	extern	PadSetup, Give_Input
rst	code	0    ; reset vector
	goto	setup

main	code
	; ******* Programme FLASH read Setup Code ***********************
setup	
;	call	GLCD_Setup
;	call	Draw_Grid
;	call	Write_Cells_Setup
	clrf	PORTH
	clrf	TRISH
	
	call	PadSetup
	goto	start
	
	; ******* Main programme ****************************************
;start 	
;	
;	clrf	sudoku_x
;	
;rlp	
;	movff	sudoku_x, number_name
;	incf	number_name, f
;	clrf	sudoku_y
;	
;clp	call	Write_Cell
;	incf	sudoku_y, f
;	
;	movlw	0x09
;	cpfslt	number_name
;	clrf	number_name
;	incf	number_name, f
;	
;	movlw	0x09
;	cpfseq	sudoku_y
;	bra	clp
;	
;	incf	sudoku_x, f
;	movlw	0x09
;	cpfseq	sudoku_x
;	bra	rlp
	
start
lp	
	NOP
	call	Give_Input
	movwf	PORTH
	NOP
	NOP
	bra	lp
	goto	$		; goto current line in code
  

	end