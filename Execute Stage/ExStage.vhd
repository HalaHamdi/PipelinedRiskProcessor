Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY ExStage IS 
	PORT(alusrc,clk,rst:IN std_logic;
	     aluop:IN std_logic_vector(2 DOWNTO 0);
	     immediate,src1,src2:IN std_logic_vector(15 DOWNTO 0));
END ENTITY ExStage;



ARCHITECTURE ExStage OF ExStage IS 
signal mux1result:std_logic_vector(15 DOWNTO 0);
signal aluout:std_logic_vector(15 DOWNTO 0);
signal aluflagsout:std_logic_vector(3 DOWNTO 0);
signal flags:std_logic_vector(3 DOWNTO 0);
BEGIN
		
mux1: entity work.exmux1 port map (alusrc,immediate,src2,mux1result);
alu:  entity work.alu port map(aluop,src1,mux1result,flags,aluout,aluflagsout);
flagreg:  entity work.flagreg port map('1',clk,rst,aluflagsout,flags);
		
END ExStage; 