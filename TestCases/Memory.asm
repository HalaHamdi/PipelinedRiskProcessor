# all numbers in hex format
# we always start by reset signal
# this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
300
#you should ignore empty lines

.ORG 2  #this is empty stack exception handler address
100

.ORG 4  #this is invalid addess exception handler address
150

.ORG 6  #this is int 0
200

.ORG 8  #this is int 2
250

.ORG 100
OUT R1
HLT

.ORG 150
INC R1
OUT R1
HLT

.ORG 300
IN R2        #R2=19 add 19 in R2
IN R3        #R3=FFFF
IN R4        #R4=F320
LDM R1,5     #R1=5
PUSH R1      #SP=FFFFFFFE,M[FFFFFFFF]=5
PUSH R2      #SP=FFFFFFFD,M[FFFFFFFE]=19
POP R1       #SP=FFFFFFFE,R1=19
POP R2       #SP=FFFFFFFF,R2=5
IN R5        #R5= 10, you should run this test case another time and load R5 with FD60
STD R2,200(R5)   #M[210]=5, Exception in the 2nd run
STD R1,201(R5)   #M[212]=19
LDD R3,201(R5)   #R3=19
LDD R4,200(R5)   #R4=5
POP R3  #exception
ADD R1, R2, R3 #should not execute as their is an exception