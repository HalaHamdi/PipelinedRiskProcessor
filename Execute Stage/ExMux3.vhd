Library ieee;
use ieee.std_logic_1164.all;


ENTITY EXMux3 IS
	PORT(fu_sig2:IN std_logic_vector(2 DOWNTO 0);
	     mux1_result,buff3_alu,buff4_alu,buff3_imm,buff4_imm,buff3_in_port,buff4_in_port,buff4_mem_val:IN std_logic_vector(15 DOWNTO 0);
	     alu_operand2:OUT std_logic_vector (15 DOWNTO 0));
END ENTITY EXMux3;


ARCHITECTURE EXMux3 OF EXMux3 IS 
BEGIN
-- 000 : In_port_buff3
-- 001 : In_port_buff4
-- 010 : buff3_imm
-- 011 : buff4_imm
-- 100 : buff3_alu
-- 101 : buff4_alu
-- 110 : buff4_memory_value
-- 111 : normal_src_value
alu_operand2 <= buff3_in_port WHEN fu_sig2 = "000"
		ELSE buff4_in_port WHEN fu_sig2 = "001"
		ELSE buff3_imm WHEN fu_sig2 = "010"
		ELSE buff4_imm WHEN fu_sig2 = "011"
		ELSE buff3_alu WHEN fu_sig2 = "100"
		ELSE buff4_alu WHEN fu_sig2 = "101"
		ELSE buff4_mem_val WHEN fu_sig2 = "110"
		ELSE mux1_result;
END EXMux3;