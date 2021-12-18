
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity data_memory is
port(
data_in: IN std_logic_vector(31 downto 0);
address: IN std_logic_vector(18 downto 0);
Clk, pc_to_stack, mem_read, mem_write: IN std_logic;

data_out: OUT std_logic_vector(31 downto 0)
);
end entity data_memory;

architecture arch1 of data_memory is
TYPE ram_type is Array(0 to 524288) of std_logic_vector(15 downto 0);
signal mem: ram_type:= (others => X"0000");
begin
process (Clk) is
begin
if (rising_edge(Clk)) then
	if (mem_write = '1') then
	mem(to_integer(unsigned(address))) <= data_in(15 downto 0);
		if (pc_to_stack = '1') then
		mem(1+to_integer(unsigned(address))) <= data_in(31 downto 16);
		end if;
	elsif (mem_read = '1') then
	data_out <= mem(1+to_integer(unsigned(address))) & mem(to_integer(unsigned(address)));
	end if;
end if;
end process;
end arch1;