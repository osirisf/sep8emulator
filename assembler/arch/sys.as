#USER STACK
MOV $0x20FF00,SP
#--INSERT IP assuming starting at 0x200000
MOV $0x20,AL
PUSH AL
MOV $0x00,AL
PUSH AL
PUSH AL
#--INSERT FLAG only us=1 and if=1 00110000
MOV $0x30,AL
PUSH AL
EXCHSP
#SYS STACK
MOV $0x00FF00,SP
#LOAD ADDRESS FOR INTERRUPT DESCRIPTOR TABLE
LIDTP 0x010000
#TYPE 0x10 FOR IR0
MOV $0x10,AL
OUT AL,0x0000
#PREPARE STACK FOR IRET
#BUILDING INTERRUPT GATE 0
#SYNTAX %program.as,start_address
%./gates/ig0.as,0x010000
#BUILDING INTERRUPT GATE 10 --> INT FROM DUMMY DEV
%./gates/ig10.as,0x010080
#BUILDING INTERRUPT GATE 11 --> REQ WRITE ON DUMMY RCR
%./gates/ig11.as,0x010088
#BUILDING INTERRUPT GATE 12 --> REQ PROGRAM CONTROL ON DUMMY 
%./gates/ig12.as,0x010090
#BUILDING INTERRUPT GATE 20 --> 
%./gates/ig20.as,0x010100
#--TRYING TO RETURN TO USER
IRET