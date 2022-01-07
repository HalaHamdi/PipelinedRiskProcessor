Library ieee;
use ieee.std_logic_1164.all;


ENTITY EXMux2 IS
	PORT(fu_sig1:IN std_logic_vector(2 DOWNTO 0);
	     src1,buff3_alu,buff4_alu,buff3_imm,buff4_imm,in_port:IN std_logic_vector(15 DOWNTO 0);
	     alu_operand1:OUT std_logic_vector (15 DOWNTO 0));
END ENTITY EXMux2;


ARCHITECTURE EXMux2 OF EXMux2 IS 
BEGIN
-- 000 : In_port
-- 001 : buff3_imm
-- 010 : buff4_imm
-- 011 : buff3_alu
-- 100 : buff4_alu
-- 111 : normal_src_value

alu_operand1 <= in_port WHEN fu_sig1 = "000"
		ELSE buff3_imm WHEN fu_sig1 = "001"
		ELSE buff4_imm WHEN fu_sig1 = "010"
		ELSE buff3_alu WHEN fu_sig1 = "011"
		ELSE buff4_alu WHEN fu_sig1 = "100"
		ELSE src1;
END EXMux2;