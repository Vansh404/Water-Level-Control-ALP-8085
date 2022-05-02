;delay subroutine to check time elapsed, here a delay of 5s is provided
JMP loop0
delay: MVI D, 9
Loop2: LXI B, 65535
Loop1: DCX B 
 MOV A, C 
ORA B 
JNZ Loop1 
DCR D 
JNZ Loop2 
RET 

loop0: IN 02 ;Read for Probe B
CPI 01
JNZ loop0
CALL delay
MVI A,01
OUT 03 ; Read for Probe A by switching Mux
IN 02
loop1: CPI 01
JNZ loop1
IN 03
CPI 01 ; compare if Probe A is triggered at approx 5s delay, if yes sound alarm
JZ alarm2
alarm2: MVI A,01
OUT 10
MVI A, 162
STA 2000 ; A2 is stored to memory as an indicator that Alarm 2 has been sounded
JMP motor
motor: MVI A,220
LDA 1001 ;Outpur hex DC to memory location to indicate the start of a motor to pump out the water
HLT