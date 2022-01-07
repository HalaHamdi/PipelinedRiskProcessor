Library ieee;
use ieee.std_logic_1164.all;


ENTITY EXMux4 IS
	PORT(rti:IN std_logic;
	     alu_flags,flags_reserved:IN std_logic_vector(3 DOWNTO 0);
	     mux4res:OUT std_logic_vector (3 DOWNTO 0));
END ENTITY EXMux4;

ARCHITECTURE EXMux4 OF EXMux4 IS 
BEGIN

mux4res <= alu_flags WHEN rti='0'
	   ELSE flags_reserved;

END EXMux4;