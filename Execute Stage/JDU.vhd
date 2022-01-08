Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY JDU IS 
	PORT(family_code:IN std_logic_vector(1 downto 0);
	     function_code:IN std_logic_vector(2 downto 0);
	     flags:IN std_logic_vector(3 downto 0);
	     sig_jump:OUT std_logic);
END ENTITY JDU;


ARCHITECTURE JDU OF JDU IS 
BEGIN	

-- flags(0) : zero flag
-- flags(1) : negative flag
-- flags(2) : carry flag

-- JZ : 000
-- JC : 001
-- JN : 010
-- JMP : 011 

sig_jump <= '1' WHEN ((family_code = "11") and (function_code = "000") and (flags(0) = '1'))
	 ELSE '1' WHEN ((family_code = "11") and (function_code = "001") and (flags(2) = '1'))
	 ELSE '1' WHEN ((family_code = "11") and (function_code = "010") and (flags(1) = '1'))
	 ELSE '1' WHEN ((family_code = "11") and (function_code = "011"))
	 ELSE '0' ;

END JDU; 