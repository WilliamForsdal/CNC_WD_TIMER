processor 12F508

CONFIG OSC   = IntRC       // Oscillator Selection bits (internal RC oscillator)
CONFIG WDT   = ON          // Watchdog Timer Enable bit (WDT enabled)
CONFIG CP    = OFF         // Code Protection bit (Code protection off)
CONFIG MCLRE = ON          // GP3/MCLR Pin Function Select bit (GP3/MCLR pin function is MCLR)

psect rstVector, delta=2
reset_vector:
    goto main


psect main, delta=2
main:
    ; init gpio
    movwf       0b11011
    tris        6
    goto        main_loop

main_loop:
    movlw       0b00000100
    movwf       6
    nop
    nop
    movlw       0
    movwf       6
    nop
    nop
    goto        main_loop


    
; need to specify END directive to fix warning: "warning: (528) no start record; entry point defaults to zero"
end reset_vector
