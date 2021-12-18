
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity writeback_buffer is
port(
rst, clk:IN std_logic;

empty_sp_exception_in, invalid_address_exception_in: IN std_logic;
writeback_in, ldm_in, port_read_in, mem_to_reg_in: IN std_logic;

addr_Rsrc1_in, addr_Rsrc2_in, addr_Rdst_in: IN std_logic_vector(2 downto 0);

memory_data_in, alu_result_in, immediate_value_in: IN std_logic_vector(15 downto 0);
pc_in: IN std_logic_vector(31 downto 0);


empty_sp_exception_out, invalid_address_exception_out: OUT std_logic;
writeback_out, ldm_out, port_read_out, mem_to_reg_out: OUT std_logic;

addr_Rsrc1_out, addr_Rsrc2_out, addr_Rdst_out: OUT std_logic_vector(2 downto 0);

memory_data_out, alu_result_out, immediate_value_out: OUT std_logic_vector(15 downto 0);
pc_out: OUT std_logic_vector(31 downto 0)
);
end entity writeback_buffer;

architecture arch1 of writeback_buffer is
begin
process(clk, rst)
begin
if (rst = '1') then
	empty_sp_exception_out <= '0';
	invalid_address_exception_out <= '0';
	writeback_out <= '0';
	ldm_out <= '0';
	port_read_out <= '0';
	mem_to_reg_out <= '0';

	addr_Rsrc1_out <= (others => '0');
	addr_Rsrc2_out <= (others => '0');
	addr_Rdst_out <= (others => '0');

	memory_data_out <= (others => '0');
	alu_result_out <= (others => '0');
	immediate_value_out <= (others => '0');
	pc_out <= (others => '0');
elsif (rising_edge(clk)) then
	empty_sp_exception_out <= empty_sp_exception_in;
	invalid_address_exception_out <= invalid_address_exception_in;
	writeback_out <= writeback_in;
	ldm_out <= ldm_in;
	port_read_out <= port_read_in;
	mem_to_reg_out <= mem_to_reg_in;

	addr_Rsrc1_out <= addr_Rsrc1_in;
	addr_Rsrc2_out <= addr_Rsrc2_in;
	addr_Rdst_out <= addr_Rdst_in;

	memory_data_out <= memory_data_in;
	alu_result_out <= alu_result_in;
	immediate_value_out <= immediate_value_in;
	pc_out <= pc_in;
end if;
end process;
end arch1;