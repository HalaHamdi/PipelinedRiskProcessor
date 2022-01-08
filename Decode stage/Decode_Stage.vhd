
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY decode_stage IS
    PORT(
        family_in : IN STD_LOGIC_VECTOR(1 downto 0);
        func , Rsrc1_addr_in , Rsrc2_addr_in , Rdst_addr_in ,Rdst_addr_wb : IN STD_LOGIC_VECTOR(2 downto 0);
        Rdst_data_wb : IN STD_LOGIC_VECTOR(15 downto 0);
        offset_in :  IN STD_LOGIC_VECTOR(15 downto 0);
        pc_in : IN STD_LOGIC_VECTOR(31 downto 0);
        clk ,rst, write_back: IN STD_LOGIC;
        family: OUT STD_LOGIC_VECTOR(1 downto 0);
        call , memread , memwrite , alusrc , pc_to_stack , ldm , memtoreg , regwrite , portread , portwrite
        , mem_to_pc , rti , ret : OUT STD_LOGIC;
        stack : OUT STD_LOGIC_VECTOR(1 downto 0) ;
        aluop : OUT STD_LOGIC_VECTOR(2 downto 0) ;
        pc : OUT  STD_LOGIC_VECTOR(31 downto 0);
        Rsrc1 , Rsrc2 ,offset: OUT STD_LOGIC_VECTOR(15 downto 0);
        Rsrc1_addr , Rsrc2_addr : OUT STD_LOGIC_VECTOR(2 downto 0);
        Rdst : OUT STD_LOGIC_VECTOR(2 downto 0);
        -- Second Phase Signals
        buff2_Rdst_addr : IN STD_LOGIC_VECTOR(2 downto 0) ;
        buff2_memread : IN STD_LOGIC ;
        freeze_pc , disable_buff  : OUT STD_LOGIC;
        inport_val_in: IN STD_LOGIC_VECTOR(15 downto 0);
        inport_val_out: OUT STD_LOGIC_VECTOR(15 downto 0);
        -- Third Integration Signals
        exception_stack , exception_invalid : IN STD_LOGIC ;
        int_in :IN  STD_LOGIC_VECTOR(1 downto 0) ;
        int_out :OUT  STD_LOGIC_VECTOR(1 downto 0) ;
        func_out : out STD_LOGIC_VECTOR(2 downto 0)
    );
END decode_stage;

ARCHITECTURE decode_stage_imp OF decode_stage IS
    SIGNAL call_sig , memread_sig , memwrite_sig , alusrc_sig , pc_to_stack_sig , ldm_sig , memtoreg_sig
     , regwrite_sig , portread_sig , portwrite_sig
    , mem_to_pc_sig , rti_sig , ret_sig , clear_sig :  STD_LOGIC ;
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
        Rsrc1_sig,Rsrc2_sig , Rdst_data_wb , write_back , clk , rst
    );
    hdu: entity work.HDU PORT MAP (clk, Rsrc1_addr_in ,Rsrc2_addr_in,buff2_Rdst_addr,buff2_memread, freeze_pc , disable_buff , clear_sig );
    PROCESS(clk , clear_sig)
	BEGIN
        if(clear_sig = '1') THEN
            call <= '0';
            memread<='0';
            memwrite <=  '0';
            alusrc <= '0';
            pc_to_stack <= '0';
            ldm <= '0';
            memtoreg<= '0';
            regwrite <= '0';
            portread <= '0';
            portwrite <= '0';
            mem_to_pc <= '0';
            rti <= '0';
            ret<= '0';
            stack <= "00";
            aluop <= "011";
        elsif (rising_edge(clk)) THEN
            if ( rst = '1' OR exception_stack = '1' OR exception_invalid = '1') then
                call <= '0';
                memread<='0';
                memwrite <=  '0';
                alusrc <= '0';
                pc_to_stack <= '0';
                ldm <= '0';
                memtoreg<= '0';
                regwrite <= '0';
                portread <= '0';
                portwrite <= '0';
                mem_to_pc <= '0';
                rti <= '0';
                ret<= '0';
                stack <= "00";
                aluop <= "011";
            else 
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
            END if;
            Rsrc1 <= Rsrc1_sig;
            Rsrc2 <= Rsrc2_sig;
            pc <= pc_in;
            family <= family_in;
            Rsrc1_addr <= Rsrc1_addr_in;
            Rsrc2_addr <= Rsrc2_addr_in;
            offset <= offset_in;
            Rdst <= Rdst_addr_in;
            inport_val_out <= inport_val_in;
            int_out <= int_in;
            func_out <= func;
        END IF;
    END PROCESS;
END decode_stage_imp;