
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity update_stack is
port(
old_sp: IN std_logic_vector(31 downto 0);
stack: IN std_logic_vector(1 downto 0);
Clk, call, rti, ret, int: IN std_logic;

new_sp: OUT std_logic_vector(31 downto 0);
empty_sp_exception: OUT std_logic
);
end entity update_stack;

architecture update_stack_imp of update_stack is
begin
process (Clk) is
variable updated_sp_value: integer;
begin
if (falling_edge(Clk)) then
	empty_sp_exception <= '0';
	if (call = '1' or int = '1') then
	updated_sp_value := to_integer(unsigned(old_sp)) - 2;

	elsif (rti = '1' or ret = '1') then
	updated_sp_value := to_integer(unsigned(old_sp)) + 2;
		if (updated_sp_value > 524288) then
		empty_sp_exception <= '1';
		updated_sp_value:= to_integer(unsigned(old_sp));
		end if;

	elsif (stack = "01") then
	updated_sp_value := to_integer(unsigned(old_sp)) - 1;

	elsif (stack = "10") then
	updated_sp_value := to_integer(unsigned(old_sp)) + 1;
		if (updated_sp_value > 524288) then
		empty_sp_exception <= '1';
		updated_sp_value:= to_integer(unsigned(old_sp));
		end if;
	else
	updated_sp_value:= to_integer(unsigned(old_sp));
	end if;
new_sp <= std_logic_vector(to_unsigned(updated_sp_value,32));
end if;
end process;
end update_stack_imp;