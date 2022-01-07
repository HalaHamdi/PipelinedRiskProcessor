Library ieee;
Use ieee.std_logic_1164.all;

--Processor constants and configurations
Package config is

Constant ADDRESS_SIZE: integer := 19; -- 19 downto 0 bits [20 bits]
Constant DATA_MEMORY_SIZE: integer := (2**20) - 1; --words
Constant INITIAL_SP: std_logic_vector (31 downto 0):= "00000000000011111111111111111111";
Constant INVALID_ADDRESS_START: integer := 65280;
End config;
