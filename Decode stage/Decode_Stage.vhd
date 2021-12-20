
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY decode_stage IS
    PORT(
        family_in : IN STD_LOGIC_VECTOR(1 downto 0);
        func , Rsrc1_addr_in , Rsrc2_addr_in , Rdst_addr_in ,Rdst_addr_wb : IN STD_LOGIC_VECTOR(2 downto 0);
        Rdst_data_wb : IN STD_LOGIC_VECTOR(15 downto 0);
        offset_in :  IN STD_LOGIC_VECTOR(15 downto 0);
        pc_in : IN STD_LOGIC_VECTOR(31 downto 0);
        clk ,rst: IN STD_LOGIC;
        family: OUT STD_LOGIC_VECTOR(1 downto 0);
        call , memread , memwrite , alusrc , pc_to_stack , ldm , memtoreg , regwrite , portread , portwrite
        , mem_to_pc , rti , ret : OUT STD_LOGIC;
        stack : OUT STD_LOGIC_VECTOR(1 downto 0) ;
        aluop : OUT STD_LOGIC_VECTOR(2 downto 0) ;
        pc : OUT  STD_LOGIC_VECTOR(31 downto 0);
        Rsrc1 , Rsrc2 ,offset: OUT STD_LOGIC_VECTOR(15 downto 0);
        Rsrc1_addr , Rsrc2_addr : OUT STD_LOGIC_VECTOR(2 downto 0);
        Rdst : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
END decode_stage;

ARCHITECTURE decode_stage_imp OF decode_stage IS
    SIGNAL call_sig , memread_sig , memwrite_sig , alusrc_sig , pc_to_stack_sig , ldm_sig , memtoreg_sig
     , regwrite_sig , portread_sig , portwrite_sig
    , mem_to_pc_sig , rti_sig , ret_sig :  STD_LOGIC ;
    SIGNAL stack_sig :  STD_LOGIC_VECTOR(1 downto 0) ;
    SIGNAL aluop_sig :  STD_LOGIC_VECTOR(2 downto 0) ;
    SIGNAL Rsrc1_sig , Rsrc2_sig  :  STD_LOGIC_VECTOR(15 downto 0);
BEGIN
    control_unit :  entity  work.ControlUnit PORT MAP (family_in , func ,Rsrc1_addr_in ,
    call_sig , memread_sig , memwrite_sig , alusrc_sig , pc_to_stack_sig , ldm_sig , memtoreg_sig
    , regwrite_sig , portread_sig , portwrite_sig
   , mem_to_pc_sig , rti_sig , ret_sig ,stack_sig , aluop_sig
    );
    register_file : entity  work.registerfile PORT MAP (Rsrc1_addr_in , Rsrc2_addr_in,Rdst_addr_wb,
        Rsrc1_sig,Rsrc2_sig , Rdst_data_wb , regwrite_sig , clk , rst
    );
    PROCESS(clk)
	BEGIN
        IF (rising_edge(clk)) THEN
        call <= call_sig;
        memread<= memread_sig;
        memwrite <=  memwrite_sig;
        alusrc <= alusrc_sig;
        pc_to_stack <= pc_to_stack_sig;
        ldm <= ldm_sig;
        memtoreg<= memtoreg_sig;
        regwrite <= regwrite_sig;
        portread <= portread_sig;
        portwrite <= portwrite_sig;
        mem_to_pc <= mem_to_pc_sig;
        rti <= rti_sig;
        ret<= ret_sig;
        stack <= stack_sig;
        aluop <= aluop_sig;
        Rsrc1 <= Rsrc1_sig;
        Rsrc2 <= Rsrc2_sig;
        pc <= pc_in;
        family <= family_in;
        Rsrc1_addr <= Rsrc1_addr_in;
        Rsrc2_addr <= Rsrc2_addr_in;
        offset <= offset_in;
        Rdst <= Rdst_addr_in;
        END IF;
    END PROCESS;
END decode_stage_imp;