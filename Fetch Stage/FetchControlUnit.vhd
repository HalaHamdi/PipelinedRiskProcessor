--  Module:      Fetch Control Unit
--  Version:     1.0
--  Description: Determine the value for PC 
--  Ports:
--      address(Input):  For address to read from
--      clk(Input):      Clock at which memory operates    
--      dataout(Output): The instruction in binary format
    
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FetchControlUnit is
    port (
        family      : IN std_logic_vector  (1 DOWNTO 0);
        func        : IN std_logic_vector  (2 DOWNTO 0);
        reset       : In std_logic;
        Buff1_reset : In std_logic;
        PC          : In std_logic_vector  (31 DOWNTO 0);
        Instruction : In std_logic_vector  (31 DOWNTO 0);
        output      : OUT std_logic_vector (31 DOWNTO 0)
    );
end entity;

architecture FetchControlUnit_arch of FetchControlUnit is
    
begin
    output <=
        (others => '0')     WHEN    reset = '1'                         else 
        Instruction         WHEN    Buff1_reset = '1'                   else      
        PC                  WHEN    (family = "11" AND  func = "000")   else
        PC + 2              WHEN    (family = "00" AND  func = "111")   OR
                                    (family = "01" AND (func = "010"    OR 
                                                        func = "011"    OR 
                                                        func = "110"))  else
        PC + 1;    

    
end FetchControlUnit_arch;