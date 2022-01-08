Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY ExStage IS 
	PORT(clk,rst,alusrc,sp_exception,invalid_address:IN std_logic;
	     aluop:IN std_logic_vector(2 DOWNTO 0);
	     stack_in,int_in:In std_logic_vector(1 DOWNTO 0);
	     immediate_in,src1_in,src2:IN std_logic_vector(15 DOWNTO 0);
	     writeback_in, ldm_in, port_read_in,port_write, mem_to_reg_in,pc_to_stack_in,mem_write_in,mem_read_in,rti_in,ret_in,call_in: IN std_logic;
	     addr_Rsrc1_in, addr_Rsrc2_in, addr_Rdst_in: IN std_logic_vector(2 downto 0);
	     pc_in: IN std_logic_vector(31 downto 0);
	     buff3_alu,buff4_alu,buff3_imm,buff4_imm,in_port,buff3_in_port,buff4_in_port,buff4_mem_val: IN std_logic_vector(15 DOWNTO 0);
	     buff3_wb,buff4_wb,buff3_ldm,buff4_ldm,buff3_portr,buff4_portr,buff4_mem_read:IN std_logic;
	     buff3_address_dest,buff4_address_dest:IN std_logic_vector(2 DOWNTO 0);
	     mem_to_pc_in: IN std_logic;
		 function_code:IN std_logic_vector(2 downto 0);
	     family_code:IN std_logic_vector(1 downto 0);

	     writeback_out, ldm_out, port_read_out, mem_to_reg_out,pc_to_stack_out,mem_write_out,mem_read_out,rti_out,ret_out,call_out: OUT std_logic;
	     stack_out,int_out:OUT std_logic_vector(1 DOWNTO 0);
	     src1add_out,scr2add_out,destadd_out:OUT std_logic_vector(2 DOWNTO 0);
	     aluout_out,scr2_out,immediate_out,src1_fu:OUT std_logic_vector (15 DOWNTO 0);
	     pc_out:OUT std_logic_vector (31 DOWNTO 0);
		 inport_val_out: OUT std_logic_vector (15 DOWNTO 0);
		 mem_to_pc_out: OUT std_logic;
		 flags_q: OUT std_logic_vector(3 downto 0);
		 sig_jump :OUT std_logic
		 );

END ENTITY ExStage;



ARCHITECTURE ExStage OF ExStage IS 
signal mux1result:std_logic_vector(15 DOWNTO 0);
signal aluout:std_logic_vector(15 DOWNTO 0);
signal aluflagsout:std_logic_vector(3 DOWNTO 0);
signal flags:std_logic_vector(3 DOWNTO 0);
signal alu_operand1:std_logic_vector(15 DOWNTO 0);
signal alu_operand2:std_logic_vector(15 DOWNTO 0);
signal fu_sig1:std_logic_vector(2 DOWNTO 0);
signal fu_sig2:std_logic_vector(2 DOWNTO 0);
signal out_reg_q:std_logic_vector(15 DOWNTO 0);
signal flags_reserved_out:std_logic_vector(3 DOWNTO 0);
signal flags_reg_in:std_logic_vector(3 DOWNTO 0);
signal flag_reserved_reg_enable:std_logic:=int_in(0) or int_in(1);
signal mux3result:std_logic_vector(15 downto 0);
BEGIN		
--mux1: entity work.exmux1 port map (alusrc,immediate_in,src2,mux1result);
mux1: entity work.exmux1 port map (alusrc,immediate_in,mux3result,alu_operand2);

fu: entity work.fu port map (buff3_wb,buff4_wb,buff3_ldm,buff4_ldm,buff3_portr,buff4_portr,buff4_mem_read,
			     addr_Rsrc1_in, addr_Rsrc2_in,buff3_address_dest,buff4_address_dest,
			     fu_sig1,fu_sig2);

mux2: entity work.exmux2 port map (fu_sig1,src1_in,buff3_alu,buff4_alu,buff3_imm,buff4_imm,buff3_in_port,buff4_in_port,buff4_mem_val,alu_operand1);

--mux3: entity work.exmux3 port map (fu_sig2,mux1result,buff3_alu,buff4_alu,buff3_imm,buff4_imm,buff3_in_port,buff4_in_port,buff4_mem_val,alu_operand2);
mux3: entity work.exmux3 port map (fu_sig2,src2,buff3_alu,buff4_alu,buff3_imm,buff4_imm,buff3_in_port,buff4_in_port,buff4_mem_val,mux3result);

out_reg: entity work.OutPortReg port map (port_write,clk,rst,alu_operand1,out_reg_q);
alu: entity work.alu port map(aluop,alu_operand1,alu_operand2,flags,aluout,aluflagsout);
flagreg: entity work.flagreg port map('1',clk,rst,flags_reg_in,flags);
flag_reserved_reg: entity work.flagreg port map(flag_reserved_reg_enable,clk,rst,flags,flags_reserved_out);
mux4: entity work.exmux4 port map (rti_in,aluflagsout,flags_reserved_out,flags_reg_in);

jdu: entity work.jdu port map (family_code,function_code,flags,sig_jump);
buff: entity work.ExMemBuff port map(mem_to_pc_in, clk, rst,sp_exception,invalid_address, 
				     stack_in,int_in,
				     addr_Rsrc1_in, addr_Rsrc2_in, addr_Rdst_in,
				     aluout,mux3result,immediate_in,   --mux3result to be changed if noran needs another thing
				     pc_in,
				     writeback_in, ldm_in, port_read_in, mem_to_reg_in,pc_to_stack_in,mem_write_in,mem_read_in,rti_in,ret_in,call_in,
					 in_port,

				     writeback_out, ldm_out, port_read_out, mem_to_reg_out,pc_to_stack_out,mem_write_out,mem_read_out,rti_out,ret_out,call_out,
				     stack_out,int_out,
				     src1add_out,scr2add_out,destadd_out,
				     aluout_out,scr2_out,immediate_out,
				     pc_out, inport_val_out, mem_to_pc_out
					 );

flags_q <= flags;
src1_fu <= alu_operand1;
	
END ExStage; 