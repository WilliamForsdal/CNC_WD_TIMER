processor 12F508

; inc files:
; C:\Program Files\Microchip\xc8\v2.32\pic\include

#include <xc.inc>

CONFIG  OSC = IntRC           ; Oscillator Selection bits (internal RC oscillator)
CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled)
CONFIG  CP = OFF              ; Code Protection bit (Code protection off)
CONFIG  MCLRE = OFF           ; GP3/MCLR Pin Function Select bit (GP3/MCLR pin function is MCLR)

; User guide chapter 4.2: delta means 2 bytes per memory address (14 bit opcodes for PIC12F683)
; this psect just holds the reset vector
psect rstVector, delta=2
reset_vector:
    goto main

psect code, delta=2
main:
    ; clear T0CS bit of OPTION reg to enable it as a GPIO
    movlw       0b11011111
    option      
    ; init gpio
    movlw       0b111000 ; 0, 1, and 2 are outputs
    tris        GPIO
    goto        main_loop

main_loop:
    bsf         GPIO, 2

    bcf         GPIO, 2
    
    goto        main_loop


; need to specify END directive to fix warning: "warning: (528) no start record; entry point defaults to zero"
end reset_vector
