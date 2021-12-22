
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity memory_stage is
port(
    rst, clk:IN std_logic;

    writeback_in, ldm_in, port_read_in, mem_to_reg_in: IN std_logic;
    pc_to_stack_in, mem_read_in, mem_write_in, rti_in, ret_in, int_in, call_in: IN std_logic;
    addr_Rsrc1_in, addr_Rsrc2_in, addr_Rdst_in: IN std_logic_vector(2 downto 0);

    alu_result_in, immediate_value_in, rsrc1_data_in: IN std_logic_vector(15 downto 0);
    pc_in: IN std_logic_vector(31 downto 0);

    empty_sp_exception_out, invalid_address_exception_out: OUT std_logic;
    writeback_out, ldm_out, port_read_out, mem_to_reg_out: OUT std_logic;

    addr_Rsrc1_out, addr_Rsrc2_out, addr_Rdst_out: OUT std_logic_vector(2 downto 0);

    memory_data_out, alu_result_out, immediate_value_out: OUT std_logic_vector(15 downto 0);
    pc_out: OUT std_logic_vector(31 downto 0)

);
end entity memory_stage;

architecture memory_imp1 of memory_stage is
begin
    empty_sp_exception_out <= '0';
    invalid_address_exception_out <= '0';
    writeback_out <= writeback_in;
    ldm_out <= ldm_in;
    port_read_out <= port_read_in;
    mem_to_reg_out <= mem_to_reg_in;
    addr_Rsrc1_out <= addr_Rsrc1_in;
    addr_Rsrc2_out <= addr_Rsrc2_in;
    addr_Rdst_out <= addr_Rdst_in;
    memory_data_out <= x"ABCD";
    alu_result_out <= alu_result_in;
    immediate_value_out <= immediate_value_in;
    pc_out <= pc_in;
end memory_imp1;