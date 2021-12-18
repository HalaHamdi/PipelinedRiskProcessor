
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity writeback_mux is
port(
alu_result, immediate_value, in_port_value, memory_data: IN std_logic_vector(15 downto 0);
mem_to_reg, port_read, ldm: IN std_logic;
writeback_mux_out: OUT std_logic_vector(15 downto 0)
);
end entity writeback_mux;

architecture arch1 of writeback_mux is
begin
writeback_mux_out <= 
	alu_result when mem_to_reg='0' and port_read='0' and ldm='0' else
	immediate_value when mem_to_reg='0' and port_read='0' and ldm='1' else
	in_port_value when mem_to_reg='0' and port_read='1' and ldm='0' else
	memory_data when mem_to_reg='1' and port_read='0' and ldm='0' else
	(others => 'Z');
	
end arch1;