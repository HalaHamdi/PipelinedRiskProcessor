# all numbers in hex format
# we always start by reset signal
# this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is empty stack exception handler address
400

.ORG 4  #this is invalid addess exception handler address
450

.ORG 6  #this is int 0
200

.ORG 8  #this is int 2
250

.ORG 200 #this is int 0
AND R0,R0,R0    #N=0,Z=1
OUT R6
RTI          #POP PC and flags restored

.ORG 250 #this is int 2
SETC
AND R0,R0,R0    #N=0,Z=1
OUT R2
RTI          #POP PC and flags restored

.ORG 10
IN R1     #R1=30
IN R2     #R2=50
IN R3     #R3=100
IN R4     #R4=300
Push R4   #sp=FFFFFFFE, M[FFFFFFFF]=300
INT 2     #SP=FFFFFFFC, M[FFFFFFFD]=half next PC,M[FFFFFFFE]=other half next PC
JMP R1 
INC R1	  # this statement shouldn't be executed
 
#check flag fowarding  
.ORG 30
AND R5,R1,R5   #R5=0 , Z = 1
JZ  R2      #Jump taken, Z = 0
SETC        # this statement shouldn't be executed, C-->1

#check on flag updated on jump
.ORG 50
JZ R1      #shouldn't be taken
JC R3      #Jump Not taken

#check destination forwarding
NOT R5     #R5=FFFF, Z= 0, C--> not change, N=1
INT 0      #SP=FFFFFFFC, M[FFFFFFFD]=half next PC,M[FFFFFFFE]=other half next PC
IN  R6     #R6=200, flag no change
JN  R6     #jump taken, N = 0
INC R1     # this statement shouldn't be executed


#check on load use
.ORG 200
SETC      #C-->1
POP R6     #R6=300, SP=FFFFFFFF
Call R6    #SP=FFFFFFFD, M[FFFFFFFE]=half next PC,M[FFFFFFFF]=other half next PC
INC R6	  #R6=401, this statement shouldn't be executed till call returns, C--> 0, N-->0,Z-->0
NOP
NOP


.ORG 300
ADD R6,R3,R6 #R6=400
ADD R1,R1,R2 #R1=80, C->0,N=0, Z=0
RET
SETC           #this shouldnot be executed

.ORG 500
NOP
NOP