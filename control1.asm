;Probe B--> Port 02
; Probe A-->Port 03 
; addr 999-->Probe B recieved y/n
;addr 1000--->Probe A received y/n
; addr 1001--> motor active y/n
; addr 1002--> alarm active y/n

loop0: IN 02 ;Read for Probe B
CPI 01
JNZ loop0
MVI A,187
STA 999 ;uP outputs to locn. 999 as sign that B is triggered
CALL check ; 8085 waits for 5s, if pA is triggered, alarm is sounded

loop1: IN 03 ;after checking for 5s if probe A triggered, the CPU resumes normal checking of Probe A
 CPI 01
JNZ loop1
MVI A,170 ;on recieving probe A, the uP outputs AA to memory as a sign that Probe A is triggered	
STA 1000
JMP motor 
motor: MVI A,172
STA 1001 ;Outpur hex AC to memory location to indicate the start of a motor to pump out the water


;check subroutine to check time elapsed, here a delay of 5s is provided

check: MVI D, 7
Loop2: LXI B, 65535
Loop1: DCX B 
 MOV A, C 
IN 03
CPI 01
JZ alarm
ORA B 
JNZ Loop1 
DCR D 
JNZ Loop2 
RET 

alarm: MVI A,01
OUT 10
MVI A,162
STA 1002
HLT
