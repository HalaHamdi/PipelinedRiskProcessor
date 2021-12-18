LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY ExMemBuff IS
	PORT(clk,rst:IN std_logic;
	     src1add,scr2add,destadd:INOUT std_logic_vector(2 DOWNTO 0);
	     aluout,scr1,immediate:INOUT std_logic_vector (15 DOWNTO 0);
	     pc:INOUT std_logic_vector (31 DOWNTO 0));
END ENTITY ExMemBuff ;

ARCHITECTURE ExMemBuff OF ExMemBuff IS 
signal  src1addS,scr2addS,destaddS :std_logic_vector(2 DOWNTO 0);
signal  aluoutS,scr1S,immediateS :std_logic_vector (15 DOWNTO 0);
signal  pcS :std_logic_vector (31 DOWNTO 0);

--read anytime and write only at rising edge
BEGIN
	
	PROCESS(clk)
	Variable  src1addV,scr2addV,destaddV :std_logic_vector(2 DOWNTO 0);
	Variable  aluoutV,scr1V,immediateV :std_logic_vector (15 DOWNTO 0);
	Variable  pcV :std_logic_vector (31 DOWNTO 0);
	BEGIN
		IF (rst='1') THEN
			src1addV:=(OTHERS=>'0');
			scr2addV:=(OTHERS=>'0');
			destaddV:=(OTHERS=>'0');
			aluoutV:=(OTHERS=>'0');
			scr1V:=(OTHERS=>'0');
			immediateV:=(OTHERS=>'0');
			pcV:=(OTHERS=>'0');
		ELSIF(rising_edge(clk)) THEN
			src1addV:=src1add;
			scr2addV:=scr2add;
			destaddV:=destadd;
			aluoutV:=aluout;
			scr1V:=scr1;
			immediateV:=immediate;
			pcV:=pc;
		END IF;
		
			src1addS<=src1addV;
			scr2addS<=scr2addV;
			destaddS<=destaddV;
			aluoutS<=aluoutV;
			scr1S<=scr1V;
			immediateS<=immediateV;
			pcS<=pcV;
			
	END PROCESS;

src1add<=src1addS;
scr2add<=scr2addS;
destadd<=destaddS;
aluout<=aluoutS;
scr1<=scr1S;
immediate<=immediateS;
pc<=pcS;

END ExMemBuff;