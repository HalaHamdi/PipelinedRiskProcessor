LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY reg is
    PORT(
        clk,rst,en : IN std_logic ;
        D : IN std_logic_vector(15 downto 0);
        Q : OUT std_logic_vector(15 downto 0)
    );
END reg;


ARCHITECTURE reg_imp OF reg is
    BEGIN
    PROCESS(clk , rst)
    BEGIN
        IF (rst='1') THEN
          Q <= (OTHERS => '0') ;
        ELSIF rising_edge(clk) THEN
          IF (en ='1') THEN
              Q <= D;
          END IF;
        END IF;
    END PROCESS;
END reg_imp;
    


