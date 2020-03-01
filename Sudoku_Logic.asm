	#include p18f87k22.inc
		
	global	cursor_x, cursor_y
	global	sudoku_brdplayer, sudoku_brdsolution
	global	sudoku_brdfixedp
	global	update_game
	global	logic_setup
	
	extern Write_Cursor
	
	
reserve code
	
acs0	    udata_acs   ; reserve data space in access ram	
cursor_x    res 1 ;reserve memory space for global cursor variable
cursor_y    res	1
W_in	    res 1 ; reserve memory space variable for W input
UP	    res 1   ;	UP command
DOWN	    res 1   ; DOWN command
RIGHT	    res 1   ; RIGHT command
LEFT	    res 1   ; LEFT command
FIXED	    res 1   ; reserved for testing if cursor fixed
	    
Boards_RAM700	udata	0x700 ;reserve data space for boards in bank 6
sudoku_brdplayer    res .81  ;sudoku board the player is working on  
sudoku_brdfixedp    res .81  ;sudoku board fixed points

Boards_RAM800	udata	0x800 ;reserve data space for boards in bank 6
sudoku_brdsolution  res .81  ;sudoku board full of solutions
    
main	code

logic_setup	; sets values for arrows
    movlw   0x41
    movwf   UP

    movlw   0x43
    movwf   DOWN
    
    movlw   0x42
    movwf   RIGHT
    
    movlw   0x44
    movwf   LEFT
    
    movlw   0x04
    movwf   cursor_x
    movwf   cursor_y
    
    return
    
    
update_game ;	handles arrow and error controls
    movwf   W_in ;  moves w to W_in
    btfsc   W_in, 6 ;	skips next line if bit 6 of W_in is clear
    bra	    arrow_con   ;	branches to arrow control if set
    bra	    curs_fix    ;	branches to cursor fixing if clear
    
arrow_con   ;	arrow command controls
    cpfseq  UP	;   compare wreg to up command
    bra	    Down	; pass branch to down
    bra	    go_up
Down
    cpfseq  DOWN ; compare wreg to down. skip if =
    bra	    Right	
    bra	    go_down
Right
    cpfseq  RIGHT
    bra	    go_left
    bra	    go_right
    
end_return
    movlw   0xFF
    call    Write_Cursor
    return

go_up
    movlw   0x00
    cpfseq  cursor_x ;	check if cursor is at boundary
    bra	    go_up_con
    bra	    end_return
go_up_con
    call    Write_Cursor
    decf    cursor_x, f ; move cursor
    bra	    end_return
    
go_down
    movlw   0x08
    cpfseq  cursor_x ;	check if cursor is at boundary
    bra	    go_down_con
    bra	    end_return
go_down_con
    call    Write_Cursor
    incf    cursor_x, f
    bra	    end_return
    
go_right
    movlw   0x08
    cpfseq  cursor_y ;	check if cursor is at boundary
    bra	    go_right_con
    bra	    end_return
go_right_con
    call    Write_Cursor
    incf    cursor_y, f
    bra	    end_return

go_left
    movlw   0x00
    cpfseq  cursor_y ;	check if cursor is at boundary
    bra	    go_left_con
    bra	    end_return
go_left_con
    call    Write_Cursor
    decf    cursor_y, f
    
    bra	    end_return
    
curs_fix    ;	determining if cursor is fixed or not
    lfsr    0, sudoku_brdfixedp	;   loading fixed position sudoku onto FSR0
    
    movlw   0x09
    mulwf   cursor_x	;   multiply x pos by 9
    
    movf    cursor_y, w
    addwf   PRODL, w	;   offset is now loaded into wreg    
    
    movf    PLUSW0, w
    movwf   FIXED    ;	load TEST location with w
    tstfsz  FIXED    ;	skips if location of cursor in fixed board is 0
    return
    lfsr    0, sudoku_brdplayer	;   loading player board onto FSR0
    
    movlw   0x09
    mulwf   cursor_x
    
    movf    cursor_y, w
    addwf   PRODL, w	;   offset is now loaded into wreg    
    
    movff   W_in, PLUSW0    ;	changing value of cursor cell on player board
    
    call    Write_Cursor	; calling to realise cursor action
    
    
    return  

    end