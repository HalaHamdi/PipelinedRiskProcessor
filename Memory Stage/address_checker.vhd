
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.config.all;

entity address_checker is
port(
    address: IN std_logic_vector(15 downto 0);
    mem_read, mem_write: IN std_logic; -- indicates that this address is a real address, not another alu op
    stack: IN std_logic_vector(1 downto 0);
    invalid_address_exception: Out std_logic
);
end entity address_checker;

architecture address_checker_v1 of address_checker is
begin
    -- CHECK: invalidity in address, only arrise when we are reading or writing something to memory
    -- but not related to stack.
    invalid_address_exception <= '1' when 
        (to_integer(unsigned(address)) > INVALID_ADDRESS_START 
         and (mem_read = '1' or mem_write = '1') and stack = "00")
         else '0';
end address_checker_v1;
