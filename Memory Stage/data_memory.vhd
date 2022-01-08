
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;
USE work.config.all;

entity data_memory is
port(
data_in: IN std_logic_vector(31 downto 0);
address: IN std_logic_vector(ADDRESS_SIZE downto 0);
Clk, pc_to_stack, mem_read, mem_write: IN std_logic;
stack: IN std_logic_vector(1 downto 0);
rti, ret: IN std_logic;

data_out: OUT std_logic_vector(31 downto 0)
);
end entity data_memory;

architecture arch1 of data_memory is
TYPE ram_type is Array(0 to DATA_MEMORY_SIZE) of std_logic_vector(15 downto 0);
signal mem: ram_type;
begin
process (Clk) is
variable pc_added_1 : std_logic_vector(31 downto 0);
begin
if (falling_edge(Clk)) then
	if (mem_write = '1') then
	
		if (pc_to_stack = '1') then
			pc_added_1 := data_in + 1;
			mem(to_integer(unsigned(address))-1) <= pc_added_1(15 downto 0);
			mem(to_integer(unsigned(address))) <= pc_added_1(31 downto 16);
		else
			mem(to_integer(unsigned(address))) <= data_in(15 downto 0);
		end if;
	elsif (mem_read = '1') then
		if (rti = '1' or ret = '1') then -- little indian: upper & lower part
			data_out <= mem(2+to_integer(unsigned(address))) & mem(1+to_integer(unsigned(address)));		
		elsif (stack = "10") then --pop intstruction
			-- we care about data in the 1 + address(sp)
			-- upper part is non important, lower part is what we want
			data_out <= mem(to_integer(unsigned(address))) & mem(1+to_integer(unsigned(address)));
		else
			--we care about data in the address itself
			--lower part is what we want
			data_out <= mem(1+to_integer(unsigned(address))) & mem(to_integer(unsigned(address)));
			end if;
	end if;	
end if;
end process;
end arch1;