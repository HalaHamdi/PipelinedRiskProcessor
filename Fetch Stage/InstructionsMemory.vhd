LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionsMemory is
    port (
        clk     : IN std_logic;
        address : IN std_logic_vector  (31 DOWNTO 0);
        dataout : OUT std_logic_vector (31 DOWNTO 0)
    );
end entity;

architecture InstructionsMemory_arch of InstructionsMemory is
    TYPE ram_type IS ARRAY(0 TO 65536) of std_logic_vector(15 DOWNTO 0);
    SIGNAL ram : ram_type;
begin
    PROCESS(clk) IS
    begin
        IF rising_edge(clk) THEN
            dataout <=  ram(to_integer(unsigned(address + 1))) & 
                        ram(to_integer(unsigned(address))); 
        END IF;
    END PROCESS;

    
end InstructionsMemory_arch;