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
    SIGNAL call_sig , memread_sig , memwrite_sig , alusrc_sig , pc_to_stack_sig , ldm_sig , memtoreg_sig
     , regwrite_sig , portread_sig , portwrite_sig
    , mem_to_pc_sig , rti_sig , ret_sig :  STD_LOGIC;
    SIGNAL stack_sig :  STD_LOGIC_VECTOR(1 downto 0) ;
    SIGNAL aluop_sig :  STD_LOGIC_VECTOR(2 downto 0) ;
    SIGNAL Rsrc1_sig , Rsrc2_sig  :  STD_LOGIC_VECTOR(15 downto 0);
    signal PC_D : std_logic_vector(31 downto 0);
    signal offset_D: STD_LOGIC_VECTOR(15 downto 0);
    signal Rsrc1_addr_D , Rsrc2_addr_D :  STD_LOGIC_VECTOR(2 downto 0);
    signal Rdst_D : STD_LOGIC_VECTOR(2 downto 0);
begin

    fetch_stahe: entity work.Fetch port map(clk, reset, instruction, PC);
    decode_stage: entity work.decode_stage port map(instruction(10 Downto 9),
                                      instruction(13 Downto 11), instruction(2 downto 0), instruction(5 downto 3), instruction(8 downto 6), "000",
                                      x"ABCD",
                                      instruction(31 Downto 16),
                                      PC,
                                      clk, reset,'0',
                                      family,
                                      call_sig , memread_sig , memwrite_sig , alusrc_sig , pc_to_stack_sig , ldm_sig , memtoreg_sig
                                    , regwrite_sig , portread_sig , portwrite_sig
                                    , mem_to_pc_sig , rti_sig , ret_sig,
                                    stack_sig, aluop_sig,
                                    PC_D,
                                    Rsrc1_sig , Rsrc2_sig, offset_D,
                                    Rsrc1_addr_D , Rsrc2_addr_D,
                                    Rdst_D);
    

end architecture;