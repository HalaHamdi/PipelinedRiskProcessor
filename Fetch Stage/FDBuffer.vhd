LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity FDBuffer is
    port (
        clk             : in std_logic;
        enable          : in std_logic;
        flash           : in std_logic;
        PC_in           : in std_logic_vector(31 Downto 0);
        Instruction_in  : in std_logic_vector(31 Downto 0);
        reset_in        : in std_logic;
        PC_out          : out std_logic_vector(31 Downto 0);
        Instruction_out : out std_logic_vector(31 Downto 0);
        reset_out       : out std_logic;
        inport_val_in   : in std_logic_vector(15 Downto 0);
        inport_val_out   : out std_logic_vector(15 Downto 0)
    );
end entity;

architecture FDBuffer_arch of FDBuffer is

begin

    process (clk)
    begin
        if rising_edge(clk) then
            reset_out <= reset_in;
            if flash = '1' then
                PC_out <= (others => '0');
                Instruction_out  <= (others => '0');

            elsif enable = '1' then 
                PC_out <= PC_in;
                Instruction_out  <= Instruction_in;
                inport_val_out <= inport_val_in;
            end if;

        end if;
    end process;

end architecture;