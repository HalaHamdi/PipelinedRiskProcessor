LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


entity Integration is
    port (
        clk   : in std_logic;
        reset : in std_logic
    );
end entity;

architecture rtl of Integration is
    -- Fetch Output
    signal instruction : std_logic_vector(31 downto 0);
    signal PC : std_logic_vector(31 downto 0);

    -- Decode Output
    signal family : STD_LOGIC_VECTOR(1 downto 0);
    signal call_sig_D_D , memread_sig_D , memwrite_sig_D , alusrc_sig_D , pc_to_stack_sig_D , ldm_sig_D , memtoreg_sig_D
     , regwrite_sig_D , portread_sig_D , portwrite_sig_D
    , mem_to_pc_sig_D , rti_sig_D , ret_sig_D :  STD_LOGIC;
    signal stack_sig_D :  STD_LOGIC_VECTOR(1 downto 0) ;
    signal aluop_sig_D :  STD_LOGIC_VECTOR(2 downto 0) ;
    signal Rsrc1_sig_D , Rsrc2_sig_D  :  STD_LOGIC_VECTOR(15 downto 0);
    signal PC_D : std_logic_vector(31 downto 0);
    signal offset_D: STD_LOGIC_VECTOR(15 downto 0);
    signal Rsrc1_addr_D , Rsrc2_addr_D :  STD_LOGIC_VECTOR(2 downto 0);
    signal Rdst_D : STD_LOGIC_VECTOR(2 downto 0);
    
    -- Excute Output
    signal writeback_sig_E, ldm_sig_E, port_read_sig_E, mem_to_reg_sig_E,pc_to_stack_sig_E,mem_write_sig_E,mem_read_sig_E,rti_sig_E,int_sig_E,ret_sig_E,call_sig_E: std_logic;
	signal stack_sig_E: std_logic_vector(1 DOWNTO 0);
	signal src1add_E,scr2add_E,destadd_E: std_logic_vector(2 DOWNTO 0);
	signal aluout_E,scr1_E,immediate_E: std_logic_vector (15 DOWNTO 0);
	signal pc_E: std_logic_vector (31 DOWNTO 0);

    -- Memory Output
    signal empty_sp_exception_M, invalid_address_exception_M: std_logic;
    signal writeback_sig_M, ldm_sig_M, port_read_sig_M, mem_to_reg_sig_M: std_logic;
    signal addr_Rsrc1_M, addr_Rsrc2_M, addr_Rdst_M: std_logic_vector(2 downto 0);
    signal memory_data_M, alu_result_M, immediate_value_M: std_logic_vector(15 downto 0);
    signal pc_M: std_logic_vector(31 downto 0);

    -- WriteBack Output
    signal immediate_value_W, alu_result_W, writeback_mux_W: std_logic_vector(15 downto 0);
    signal writeback_sig_W, port_read_sig_W, ldm_sig_W: std_logic;
    signal addr_Rdst_W: std_logic_vector(2 downto 0);
    signal empty_sp_exception_W, invalid_address_exception_W: std_logic;
begin

    fetch_stahe: entity work.Fetch port map(clk, reset, instruction, PC);
    decode_stage: entity work.decode_stage port map(instruction(10 Downto 9),
                                      instruction(13 Downto 11), instruction(2 downto 0), instruction(5 downto 3), instruction(8 downto 6), addr_Rdst_W,
                                      writeback_mux_W,
                                      instruction(31 Downto 16),
                                      PC,
                                      clk, reset, writeback_sig_W,
                                      family,
                                      call_sig_D_D , memread_sig_D , memwrite_sig_D , alusrc_sig_D , pc_to_stack_sig_D , ldm_sig_D , memtoreg_sig_D
                                    , regwrite_sig_D , portread_sig_D , portwrite_sig_D
                                    , mem_to_pc_sig_D , rti_sig_D , ret_sig_D,
                                    stack_sig_D, aluop_sig_D,
                                    PC_D,
                                    Rsrc1_sig_D , Rsrc2_sig_D, offset_D,
                                    Rsrc1_addr_D , Rsrc2_addr_D,
                                    Rdst_D);
    execute_stage: entity work.ExStage port map(clk, reset, alusrc_sig_D,
                                    aluop_sig_D,
                                    stack_sig_D,
                                    offset_D, Rsrc1_sig_D , Rsrc2_sig_D,
                                    regwrite_sig_D,
                                    ldm_sig_D, portread_sig_D, memtoreg_sig_D, pc_to_stack_sig_D, memwrite_sig_D, memread_sig_D, rti_sig_D, '0', --int_signal
                                    ret_sig_D, call_sig_D_D,
                                    Rsrc1_addr_D , Rsrc2_addr_D, Rdst_D,
                                    PC_D,
                                    writeback_sig_E, ldm_sig_E, port_read_sig_E, mem_to_reg_sig_E,pc_to_stack_sig_E,mem_write_sig_E,mem_read_sig_E,rti_sig_E,int_sig_E,ret_sig_E,call_sig_E,
                                    stack_sig_E,
                                    src1add_E,scr2add_E,destadd_E,
                                    aluout_E,scr1_E,immediate_E,
                                    pc_E
                                    );
    memory_stage: entity work.memory_stage port map(reset, clk,
                                    writeback_sig_E, ldm_sig_E, port_read_sig_E, mem_to_reg_sig_E,
                                    pc_to_stack_sig_E,mem_read_sig_E, mem_write_sig_E,
                                    rti_sig_E,ret_sig_E,int_sig_E,call_sig_E,
                                    src1add_E,scr2add_E,destadd_E,
                                    aluout_E,immediate_E,scr1_E,
                                    pc_E,
                                    empty_sp_exception_M, invalid_address_exception_M,
                                    writeback_sig_M, ldm_sig_M, port_read_sig_M, mem_to_reg_sig_M,
                                    addr_Rsrc1_M, addr_Rsrc2_M, addr_Rdst_M,
                                    memory_data_M, alu_result_M, immediate_value_M,
                                    pc_M
                                    );
    writeback_stage: entity work.writeback_stage port map(reset, clk,
                                    empty_sp_exception_M, invalid_address_exception_M,
                                    writeback_sig_M, ldm_sig_M, port_read_sig_M, mem_to_reg_sig_M,
                                    addr_Rsrc1_M, addr_Rsrc2_M, addr_Rdst_M,
                                    memory_data_M, alu_result_M, immediate_value_M,
                                    pc_M,
                                    immediate_value_W, alu_result_W, writeback_mux_W,
                                    writeback_sig_W, port_read_sig_W, ldm_sig_W,
                                    addr_Rdst_W,
                                    empty_sp_exception_W, invalid_address_exception_W
                                    );
end architecture;