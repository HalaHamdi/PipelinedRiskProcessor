LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY registerfile is
    PORT(
        Rsrc1_addr , Rsrc2_addr , Rdst_addr  : IN STD_LOGIC_VECTOR(2 downto 0);
        Rsrc1 , Rsrc2  : OUT STD_LOGIC_VECTOR(15 downto 0);
        Rdst_data : IN STD_LOGIC_VECTOR(15 downto 0);
        wb: IN std_logic;
        clk , rst : IN std_logic
    );
END registerfile;

ARCHITECTURE registerfile_imp of registerfile is
    -- Writing and reading signals
    SIGNAL reg_enable : std_logic_vector(7 downto 0);
    SIGNAL tri_state_src1 : std_logic_vector (7 downto 0);
    SIGNAL tri_state_src2 : std_logic_vector (7 downto 0);
    -- Array of Signals to connect the output of registers to Tri-state buffers
    type out_arr is array (0 to 7) of std_logic_vector(15 downto 0);
    SIGNAl reg_out : out_arr ;

    BEGIN 
    -- Writing and Reading Decoders
    enable_read : entity  work.decoder PORT MAP (wb , Rdst_addr , reg_enable);
    enable_write_src1: entity  work.decoder PORT MAP ('1' , Rsrc1_addr , tri_state_src1);
    enable_write_src2: entity  work.decoder PORT MAP ('1' , Rsrc2_addr , tri_state_src2);
    -- Generate 8 registers with Tri-state buffers for every out databus
    loop0: FOR i IN 0 TO 7 GENERATE
    regx: entity  work.reg PORT MAP (clk , rst , reg_enable(i),Rdst_data,reg_out(i));
    tri_src1x : entity  work.tri_state PORT MAP (reg_out(i) , Rsrc1,tri_state_src1(i));
    tri_src2x : entity  work.tri_state PORT MAP (reg_out(i) , Rsrc2,tri_state_src2(i));
    END GENERATE;
END registerfile_imp;