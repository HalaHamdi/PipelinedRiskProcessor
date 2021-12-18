LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY decoder is
    PORT(
        en : IN std_logic;
        S : IN std_logic_vector(2 downto 0);
        A : OUT std_logic_vector(7 downto 0)
    );
END decoder;


ARCHITECTURE my_decoder of decoder is
    BEGIN
        A <= "00000000" WHEN en ='0' ELSE
            "00000001" WHEN S="000" ELSE
            "00000010" WHEN S="001" ELSE
            "00000100" WHEN S="010" ELSE
            "00001000" WHEN S="011" ELSE
            "00010000" WHEN S="100" ELSE
            "00100000" WHEN S="101" ELSE
            "01000000" WHEN S="110" ELSE
            "10000000" WHEN S="111" ELSE
	    "00000000";
END my_decoder;