Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY ExStage IS 
	PORT(alusrc,clk,rst:IN std_logic;
	     aluop:IN std_logic_vector(2 DOWNTO 0);
	     stack_in:In std_logic_vector(1 DOWNTO 0);
	     immediate_in,src1_in,src2:IN std_logic_vector(15 DOWNTO 0);
	     writeback_in, ldm_in, port_read_in, mem_to_reg_in,pc_to_stack_in,mem_write_in,mem_read_in,rti_in,int_in,ret_in,call_in: IN std_logic;
	     addr_Rsrc1_in, addr_Rsrc2_in, addr_Rdst_in: IN std_logic_vector(2 downto 0);
	     pc_in: IN std_logic_vector(31 downto 0);

	     writeback_out, ldm_out, port_read_out, mem_to_reg_out,pc_to_stack_out,mem_write_out,mem_read_out,rti_out,int_out,ret_out,call_out: OUT std_logic;
	     stack_out:OUT std_logic_vector(1 DOWNTO 0);
	     src1add_out,scr2add_out,destadd_out:OUT std_logic_vector(2 DOWNTO 0);
	     aluout_out,scr1_out,immediate_out:OUT std_logic_vector (15 DOWNTO 0);
	     pc_out:OUT std_logic_vector (31 DOWNTO 0)
		 );

END ENTITY ExStage;



ARCHITECTURE ExStage OF ExStage IS 
signal mux1result:std_logic_vector(15 DOWNTO 0);
signal aluout:std_logic_vector(15 DOWNTO 0);
signal aluflagsout:std_logic_vector(3 DOWNTO 0);
signal flags:std_logic_vector(3 DOWNTO 0);
 

BEGIN		
mux1: entity work.exmux1 port map (alusrc,immediate_in,src2,mux1result);
alu: entity work.alu port map(aluop,src1_in,mux1result,flags,aluout,aluflagsout);
flagreg: entity work.flagreg port map('1',clk,rst,aluflagsout,flags);
buff: entity work.ExMemBuff port map(clk, rst, 
					 stack_in,
				     addr_Rsrc1_in, addr_Rsrc2_in, addr_Rdst_in,
				     aluout,src1_in,immediate_in,
				     pc_in,
				     writeback_in, ldm_in, port_read_in, mem_to_reg_in,pc_to_stack_in,mem_write_in,mem_read_in,rti_in,int_in,ret_in,call_in,
					 
				     writeback_out, ldm_out, port_read_out, mem_to_reg_out,pc_to_stack_out,mem_write_out,mem_read_out,rti_out,int_out,ret_out,call_out,
				     stack_out,
				     src1add_out,scr2add_out,destadd_out,
				     aluout_out,scr1_out,immediate_out,
				     pc_out
					 );
		
END ExStage; 