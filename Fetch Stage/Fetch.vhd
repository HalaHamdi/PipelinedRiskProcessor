LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Fetch is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        instruction : out std_logic_vector(31 downto 0);
        PC          : out std_logic_vector(31 downto 0);
        inport_val_in : in std_logic_vector(15 downto 0);
        inport_val_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture Fetch_arch of Fetch is

    signal Buff1_reset  : std_logic;
    signal CU_out       : std_logic_vector(31 downto 0);
    signal mem_out      : std_logic_vector(31 downto 0);
    signal PC_out       : std_logic_vector(31 downto 0);

    signal output       : std_logic_vector(31 downto 0);
    signal PC_prev      : std_logic_vector(31 downto 0);
begin

    CU: entity work.FetchControlUnit    port    map(mem_out(10 Downto 9), 
                                                    mem_out(13 Downto 11),
                                                    reset,
                                                    Buff1_reset,
                                                    PC_out,
                                                    mem_out,
                                                    CU_out);
                                                    
    Memory : entity work.InstructionsMemory port map(clk, PC_out, mem_out);
    Programe_Counter: entity work.PC port map(clk, CU_out, PC_out);
    Buff: entity work.FDBuffer port map(clk, '1', '0', PC_prev, output, reset, 
                                                        PC, instruction, Buff1_reset,
                                                        inport_val_in, inport_val_out);

    output <= "00000000000000000010011000000000" when (reset = '1' or Buff1_reset = '1')
    else mem_out;  
    
    process (clk)
    begin
        if rising_edge(clk) then
            PC_prev <= PC_out;
        end if;
    end process;

end architecture;