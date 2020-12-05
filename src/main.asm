; ----------------------------------------------------------------------
; WLADX 
; ----------------------------------------------------------------------
.memorymap
    defaultslot 0
    slotsize $8000
    slot 0 $0000
.endme

.rombankmap
    bankstotal 1
    banksize $8000
    banks 1
.endro
; ----------------------------------------------------------------------

; ----------------------------------------------------------------------
; SDSC TAG HEADER
; ----------------------------------------------------------------------
.sdsctag 1.10, "Sample Program", "Sample Program for SEGA Master System", "Kentosama"
; ----------------------------------------------------------------------

.bank 0 slot 0                      ; Set the bank 0 at slot 0
.org $0000                          ; Program begin
    di                              ; Disable interrupt
    im 1                            ; Set interrupt mode to 1
    ld sp, $dff0                    ; Stack pile start at $dff0
    jp Main                         ; Jump to the main subroutine

.org $0066                          ; Pause
    retn                            ; Return

; ----------------------------------------------------------------------
; MAIN PROGRAM
; ----------------------------------------------------------------------
Main:
-:  jr -                            ; Main loop
