LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FetchControlUnit is
    port (
        family        : IN std_logic_vector  (1 DOWNTO 0);
        func          : IN std_logic_vector  (2 DOWNTO 0);
        reset         : In std_logic;
        Buff1_reset   : In std_logic;
        PC            : In std_logic_vector  (31 DOWNTO 0);
        
        is_jump       : In std_logic;
        jump_add      : In std_logic_vector  (15 DOWNTO 0);

        mem_to_pc     : In std_logic;
        mem_out       : In std_logic_vector  (31 DOWNTO 0);

        int           : In std_logic_vector  (1 DOWNTO 0);
        sp_exp        : In std_logic;
        add_exp       : In std_logic;

        buff1_int     : In std_logic_vector (1 downto 0);
        buff4_sp_exp  : In std_logic;
        buff4_add_exp : In std_logic;

        disable       : In std_logic;
        Instruction   : In std_logic_vector  (31 DOWNTO 0);

        --output
        output_cu     : OUT std_logic_vector (31 DOWNTO 0)
    );
end entity;

architecture FetchControlUnit_arch of FetchControlUnit is
    
begin
    output_cu <=
        (others => '0')                         WHEN    reset = '1'         else 
        std_logic_vector(to_unsigned(6, 32))    when    int = "01"          else
        std_logic_vector(to_unsigned(8, 32))    when    int = "10"          else
        std_logic_vector(to_unsigned(2, 32))    when    sp_exp = '1'        else
        std_logic_vector(to_unsigned(4, 32))    when    add_exp = '1'       else
        PC - 1                                  when    disable = '1'       else
        Instruction                             WHEN    Buff1_reset = '1'   or
                                                        buff1_int = "01"    or 
                                                        buff1_int ="10"     or
                                                        buff4_sp_exp = '1'  or
                                                        buff4_add_exp = '1' else
        PC + 2                                  WHEN    (family = "00"      AND
                                                        func = "111")       OR
                                                        (family = "01"      AND
                                                        (func = "010"       OR 
                                                        func = "011"        OR 
                                                        func = "110"))      else
        ((31 downto 16 => '0') & jump_add)      when    is_jump = '1'       else
        mem_out                                 when    mem_to_pc = '1'     else
        PC                                      WHEN    (family = "10"      AND
                                                        func = "000")       else
        PC + 1;    

    
end FetchControlUnit_arch;