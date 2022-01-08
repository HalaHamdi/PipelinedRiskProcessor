LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Fetch is
    port (
        clk         : in std_logic;
        reset       : in std_logic;

        is_jump     : In std_logic;
        jump_add    : In std_logic_vector  (15 DOWNTO 0);

        mem_to_pc   : In std_logic;
        data_mem_out: In std_logic_vector  (31 DOWNTO 0);

        sp_exp      : In std_logic;
        add_exp     : In std_logic;

        buff4_sp_exp : In std_logic;
        buff4_add_exp : In std_logic;

        disable : In std_logic;

        instruction : out std_logic_vector(31 downto 0);
        PC          : out std_logic_vector(31 downto 0);
        int_out     : out std_logic_vector(1 downto 0);

        inport_val_in : in std_logic_vector(15 downto 0);
        inport_val_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture Fetch_arch of Fetch is

    signal Buff1_reset  : std_logic;
    signal buff1_int    : std_logic_vector(1 downto 0);
    signal CU_out       : std_logic_vector(31 downto 0);
    signal mem_out      : std_logic_vector(31 downto 0);
    signal PC_out       : std_logic_vector(31 downto 0);

    signal output       : std_logic_vector(31 downto 0);
    signal PC_prev      : std_logic_vector(31 downto 0);
    signal int          : std_logic_vector(1 downto 0);
    signal state : std_logic_vector(1 downto 0) := "00";
begin

    CU: entity work.FetchControlUnit    port    map(mem_out(10 Downto 9), 
                                                    mem_out(13 Downto 11),
                                                    reset,
                                                    Buff1_reset,
                                                    PC_out,

                                                    is_jump,
                                                    jump_add,
                                                    mem_to_pc,
                                                    data_mem_out,
                                                    int,
                                                    sp_exp,
                                                    add_exp,

                                                    buff1_int,
                                                    buff4_sp_exp,
                                                    buff4_add_exp,
                                                    disable,

                                                    mem_out,
                                                    CU_out);
                                                    
    Memory : entity work.InstructionsMemory port map(clk, PC_out, mem_out);
    Programe_Counter: entity work.PC port map(clk, CU_out, PC_out);
    Buff: entity work.FDBuffer port map(clk, '1', '0', PC_prev, output, reset, 
                                                        PC, instruction, Buff1_reset,
                                                        inport_val_in, inport_val_out,
                                                        int, buff1_int);

    output <= "00000000000000000000110000000000" when (reset = '1' or Buff1_reset = '1' or 
                                                        sp_exp = '1' or add_exp='1' or
                                                        buff1_int = "01" or buff1_int ="10" or
                                                        buff4_sp_exp = '1' or buff4_add_exp = '1' or
                                                        state /= "00") 
    else mem_out;
    
    int <=  "01" when mem_out(13 downto 9) = "11011" and mem_out(2 downto 0) = "000" else
            "10" when mem_out(13 downto 9) = "11011" and mem_out(2 downto 0) = "010" else
            "00";

    int_out <= buff1_int;

    process (clk)
    begin
        if rising_edge(clk) then
            PC_prev <= PC_out;
            if mem_out(13 downto 9) = "10111" or mem_out(13 downto 9) = "11111" then
                state <= "11";

            elsif state /= "00" then
                state <= state - 1;
            end if;

        end if;
    end process;

end architecture;