Library ieee;
use ieee.std_logic_1164.all;


ENTITY EXMux5 IS
	PORT(jump_sig:IN std_logic;
	     mux4res,flags_jdu_out:IN std_logic_vector(3 DOWNTO 0);
	     mux5res:OUT std_logic_vector (3 DOWNTO 0));
END ENTITY EXMux5;

ARCHITECTURE EXMux5 OF EXMux5 IS 
BEGIN

mux5res <= mux4res WHEN jump_sig='0'
	   ELSE flags_jdu_out;

END EXMux5;
