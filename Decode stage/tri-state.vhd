LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY tri_state is
    PORT(
        A : IN std_logic_vector(15 downto 0);
        B : OUT std_logic_vector(15 downto 0);
        en : IN std_logic
    );
END tri_state;

ARCHITECTURE my_tri_state of tri_state is
    BEGIN
        B <= A WHEN en ='1'  ELSE (others => 'Z');
END my_tri_state;

