LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY HDU IS
    PORT(
        clk: in std_logic;
        Rsrc1_addr , Rsrc2_addr , buff2_Rdst_addr : IN STD_LOGIC_VECTOR(2 downto 0) ;
        buff2_memread : IN STD_LOGIC ;
        freeze_pc , disable_buff , clear_signals : OUT STD_LOGIC
    );
END HDU;


ARCHITECTURE HDU_IMP OF HDU IS
BEGIN
    PROCESS(clk)
    BEGIN
    if(rising_edge(clk)) then
        if (buff2_memread = '1') AND ((buff2_Rdst_addr =Rsrc2_addr) OR (buff2_Rdst_addr =Rsrc1_addr)) THEN
            freeze_pc <= '1' ;
            disable_buff <= '1';
            clear_signals <= '1' ;
        else
            freeze_pc <='0' ;
            disable_buff <= '0';
            clear_signals <= '0' ;
        end if;
    end if;
    END PROCESS;
END HDU_IMP;