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
    SIGNAL call_sig_D_D , memread_sig_D , memwrite_sig_D , alusrc_sig_D , pc_to_stack_sig_D , ldm_sig_D , memtoreg_sig_D
     , regwrite_sig_D , portread_sig_D , portwrite_sig_D
    , mem_to_pc_sig_D , rti_sig_D , ret_sig_D :  STD_LOGIC;
    SIGNAL stack_sig_D :  STD_LOGIC_VECTOR(1 downto 0) ;
    SIGNAL aluop_sig_D :  STD_LOGIC_VECTOR(2 downto 0) ;
    SIGNAL Rsrc1_sig_D , Rsrc2_sig_D  :  STD_LOGIC_VECTOR(15 downto 0);
    signal PC_D : std_logic_vector(31 downto 0);
    signal offset_D: STD_LOGIC_VECTOR(15 downto 0);
    signal Rsrc1_addr_D , Rsrc2_addr_D :  STD_LOGIC_VECTOR(2 downto 0);
    signal Rdst_D : STD_LOGIC_VECTOR(2 downto 0);

    -- Excute Output
begin

    fetch_stahe: entity work.Fetch port map(clk, reset, instruction, PC);
    decode_stage: entity work.decode_stage port map(instruction(10 Downto 9),
                                      instruction(13 Downto 11), instruction(2 downto 0), instruction(5 downto 3), instruction(8 downto 6), "000",
                                      x"ABCD",
                                      instruction(31 Downto 16),
                                      PC,
                                      clk, reset,'0',
                                      family,
                                      call_sig_D_D , memread_sig_D , memwrite_sig_D , alusrc_sig_D , pc_to_stack_sig_D , ldm_sig_D , memtoreg_sig_D
                                    , regwrite_sig_D , portread_sig_D , portwrite_sig_D
                                    , mem_to_pc_sig_D , rti_sig_D , ret_sig_D,
                                    stack_sig_D, aluop_sig_D,
                                    PC_D,
                                    Rsrc1_sig_D , Rsrc2_sig_D, offset_D,
                                    Rsrc1_addr_D , Rsrc2_addr_D,
                                    Rdst_D);
    

end architecture;