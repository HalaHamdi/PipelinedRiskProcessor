
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.config.all;

entity update_stack is
port(
rst: In std_logic;
old_sp: IN std_logic_vector(31 downto 0);
stack, int: IN std_logic_vector(1 downto 0);
Clk, call, rti, ret: IN std_logic;

new_sp: OUT std_logic_vector(31 downto 0)
);
end entity update_stack;

architecture update_stack_imp of update_stack is
begin
process (Clk) is
variable updated_sp_value: integer;
begin
	if(rst = '1') then
		new_sp <= INITIAL_SP; -- intial sp value is at the very end of the memory
	elsif (falling_edge(Clk)) then
		if (call = '1' or int /= "00") then
		updated_sp_value := to_integer(unsigned(old_sp)) - 2;

		elsif (rti = '1' or ret = '1') then
		updated_sp_value := to_integer(unsigned(old_sp)) + 2;
			if (updated_sp_value > DATA_MEMORY_SIZE) then
			updated_sp_value:= to_integer(unsigned(old_sp));
			end if;

		elsif (stack = "01") then -- push
		updated_sp_value := to_integer(unsigned(old_sp)) - 1;

		elsif (stack = "10") then -- pop
		updated_sp_value := to_integer(unsigned(old_sp)) + 1;
			if (updated_sp_value > DATA_MEMORY_SIZE) then
			updated_sp_value:= to_integer(unsigned(old_sp));
			end if;
		else
		updated_sp_value:= to_integer(unsigned(old_sp));
		end if;
	new_sp <= std_logic_vector(to_unsigned(updated_sp_value,32));
	end if;
end process;
end update_stack_imp;