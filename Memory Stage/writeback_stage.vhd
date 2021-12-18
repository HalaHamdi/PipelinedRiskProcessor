
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity writeback_stage is
port(
rst, clk:IN std_logic;

empty_sp_exception_in, invalid_address_exception_in: IN std_logic;
writeback_in, ldm_in, port_read_in, mem_to_reg_in: IN std_logic;

addr_Rsrc1_in, addr_Rsrc2_in, addr_Rdst_in: IN std_logic_vector(2 downto 0);

memory_data_in, alu_result_in, immediate_value_in: IN std_logic_vector(15 downto 0);
pc_in: IN std_logic_vector(31 downto 0);

immediate_value_out, alu_result_out, writeback_mux_out: OUT std_logic_vector(15 downto 0);
writeback_out, port_read_out, ldm_out: OUT std_logic;
addr_Rdst_out: OUT std_logic_vector(2 downto 0);
empty_sp_exception_out, invalid_address_exception_out: OUT std_logic
);
end entity writeback_stage;

architecture arch1 of writeback_stage is
signal buff_empty_sp_exception,buff_invalid_address_exception: std_logic;
signal buff_writeback,buff_ldm,buff_port_read,buff_mem_to_reg: std_logic;
signal buff_addr_Rsrc1,buff_addr_Rsrc2,buff_addr_Rdst: std_logic_vector(2 downto 0);
signal buff_memory_data,buff_alu_result,buff_immediate_value: std_logic_vector(15 downto 0);
signal buff_pc: std_logic_vector(31 downto 0);

signal in_port_val: std_logic_vector(15 downto 0);
begin

in_port_val <= (others => '1');

writeback_buffer_label: entity work.writeback_buffer port map (
rst=>rst,
clk=>clk,
empty_sp_exception_in=>empty_sp_exception_in,
invalid_address_exception_in=>invalid_address_exception_in,
writeback_in=>writeback_in,
ldm_in=>ldm_in,
port_read_in=>port_read_in,
mem_to_reg_in=>mem_to_reg_in,
addr_Rsrc1_in=>addr_Rsrc1_in,
addr_Rsrc2_in=>addr_Rsrc2_in,
addr_Rdst_in=>addr_Rdst_in,
memory_data_in=>memory_data_in,
alu_result_in=>alu_result_in,
immediate_value_in=>immediate_value_in,
pc_in=>pc_in,

empty_sp_exception_out=>buff_empty_sp_exception,
invalid_address_exception_out=>buff_invalid_address_exception,
writeback_out=>buff_writeback,
ldm_out=>buff_ldm,
port_read_out=>buff_port_read,
mem_to_reg_out=>buff_mem_to_reg,
addr_Rsrc1_out=>buff_addr_Rsrc1,
addr_Rsrc2_out=>buff_addr_Rsrc2,
addr_Rdst_out=>buff_addr_Rdst,
memory_data_out=>buff_memory_data,
alu_result_out=>buff_alu_result,
immediate_value_out=>buff_immediate_value,
pc_out=>buff_pc
);

writeback_mux_label: entity work.writeback_mux port map (
alu_result=>buff_alu_result,
immediate_value=>buff_immediate_value,
memory_data=>buff_memory_data,
mem_to_reg=>buff_mem_to_reg,
port_read=>buff_port_read,
ldm=>buff_ldm,
in_port_value=>in_port_val,

writeback_mux_out=>writeback_mux_out
);

immediate_value_out <= buff_immediate_value;
alu_result_out <= buff_alu_result;
writeback_out <= buff_writeback;
port_read_out <= buff_port_read;
ldm_out <= buff_ldm;
addr_Rdst_out <= buff_addr_Rdst;
empty_sp_exception_out <= buff_empty_sp_exception;
invalid_address_exception_out <= buff_invalid_address_exception;

end arch1;