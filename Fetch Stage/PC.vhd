LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity PC is
    port (
        clk    : in  std_logic;
        data   : in  std_logic_vector(31 Downto 0);
        output : out std_logic_vector(31 Downto 0)
    );
end entity;

architecture PC_arch of PC is

begin

    process (clk) is
    begin
        if falling_edge(clk) then
            output <= data;
        end if;
    end process;

end architecture;