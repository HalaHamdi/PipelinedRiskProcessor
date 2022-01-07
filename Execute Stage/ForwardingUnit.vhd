Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;


ENTITY FU IS
	PORT(buff3_wb,buff4_wb,buff3_ldm,buff4_ldm,buff3_portr,buff4_portr:IN std_logic;
	     buff2_address_src1,buff2_address_src2,buff3_address_dest,buff4_address_dest:IN std_logic_vector(2 DOWNTO 0);
	     fu_sig1,fu_sig2:OUT std_logic_vector(2 DOWNTO 0));
END ENTITY FU;

ARCHITECTURE FU OF FU IS 
BEGIN

-- 000 : In_port
-- 001 : buff3_imm
-- 010 : buff4_imm
-- 011 : buff3_alu
-- 100 : buff4_alu
-- 111 : normal_src_value
fu_sig1 <= "000" WHEN ((buff2_address_src1 = buff3_address_dest) and buff3_portr = '1' ) or ((buff2_address_src1 = buff4_address_dest ) and buff4_portr='1')
		ELSE "001" WHEN ((buff2_address_src1 = buff3_address_dest) and buff3_ldm = '1' )
		ELSE "010" WHEN ((buff2_address_src1 = buff4_address_dest) and buff4_ldm = '1' )
		ELSE "011" WHEN ((buff2_address_src1 = buff3_address_dest) and buff3_wb = '1' )
		ELSE "100" WHEN ((buff2_address_src1 = buff4_address_dest) and buff4_wb = '1' )
		ELSE "111";

fu_sig2 <= "000" WHEN ((buff2_address_src2 = buff3_address_dest) and buff3_portr = '1' ) or ((buff2_address_src2 = buff4_address_dest ) and buff4_portr='1')
		ELSE "001" WHEN ((buff2_address_src2 = buff3_address_dest) and buff3_ldm = '1' )
		ELSE "010" WHEN ((buff2_address_src2 = buff4_address_dest) and buff4_ldm = '1' )
		ELSE "011" WHEN ((buff2_address_src2 = buff3_address_dest) and buff3_wb = '1' )
		ELSE "100" WHEN ((buff2_address_src2 = buff4_address_dest) and buff4_wb = '1' )
		ELSE "111";
END FU;