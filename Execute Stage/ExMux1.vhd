Library ieee;
use ieee.std_logic_1164.all;


ENTITY EXMux1 IS
	PORT(alusrc:IN std_logic;
	     immediate,src2:IN std_logic_vector(15 DOWNTO 0);
	     mux1res:OUT std_logic_vector (15 DOWNTO 0));
END ENTITY EXMux1;


ARCHITECTURE EXMux1 OF EXMux1 IS 

--should this be working on the rising edge? 
--if yes then this is synchronous or asynchronous?

BEGIN
mux1res <= immediate WHEN alusrc='0'
	ELSE src2;
END EXMux1;