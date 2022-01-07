Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;


ENTITY ALU IS
	PORT(aluop:IN std_logic_vector(2 DOWNTO 0);
	     src1,src2:IN std_logic_vector(15 DOWNTO 0);
	     inflags:IN std_logic_vector(3 DOWNTO 0);
	     aluout:OUT std_logic_vector (15 DOWNTO 0);
	     flags:OUT std_logic_vector(3 DOWNTO 0));
END ENTITY ALU;




ARCHITECTURE ALU OF ALU IS 

--should this be working on the rising edge? 
--if yes then this is synchronous or asynchronous?
signal result: std_logic_vector(16 DOWNTO 0);
signal one:std_logic_vector(15 DOWNTO 0) :=x"0001";
signal carryflag:std_logic;
signal zeroflag:std_logic;
signal negativeflag:std_logic;
BEGIN
result <= ('0' &not src1) WHEN aluop="001"
	  ELSE std_logic_vector(to_signed(to_integer(unsigned(src1))+to_integer(unsigned(one)),17)) WHEN aluop="010"
	  ELSE ('0' & src1)   WHEN aluop="011"
	  ELSE std_logic_vector(to_signed(to_integer(unsigned(src1))+to_integer(unsigned(src2)),17))WHEN aluop="100"
	  ELSE ('0' & (src1 and src2))WHEN aluop="101"
          ELSE std_logic_vector(to_signed(to_integer(unsigned(src1))-to_integer(unsigned(src2)),17))WHEN aluop="110";
--else what is the default case? or leave it as a latch?
-- In subtracting , src1-src2 or opposite?

--just updating the carry flag if it is arithmetic or shift opertaions
carryflag <='1' WHEN aluop="000"
	   ELSE result(16) WHEN aluop="010"
	   ELSE result(16) WHEN aluop="100" 
	   ELSE result(16) WHEN aluop="110"
	   ELSE inflags(2);

--updating the zero & negative flags  if arithmetic ,shift or logic operations
--all alu family except mov and setc
zeroflag <= inflags(0) WHEN (aluop="000" or aluop="011")
	ELSE '1' WHEN to_integer(signed(result(15 downto 0)))= 0
	ElSE '0' WHEN to_integer(signed(result(15 downto 0)))/= 0;

negativeflag <=inflags(1) WHEN (aluop="000" or aluop="011")
	ELSE '1' WHEN to_integer(signed(result(15 downto 0))) < 0
	ELSE '0' WHEN to_integer(signed(result(15 downto 0))) >= 0; 

flags<='0'& carryflag & negativeflag & zeroflag;
	
aluout<=result(15 DOWNTO 0);

END ALU;