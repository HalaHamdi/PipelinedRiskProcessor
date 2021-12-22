LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY ExMemBuff IS
	PORT(clk,rst:IN std_logic;
	     stack_in:In std_logic_vector(1 DOWNTO 0);
	     src1add_in,scr2add_in,destadd_in:IN std_logic_vector(2 DOWNTO 0);
	     aluout_in,scr1_in,immediate_in:IN std_logic_vector (15 DOWNTO 0);
	     pc_in:IN std_logic_vector (31 DOWNTO 0);
	     writeback_in, ldm_in, port_read_in, mem_to_reg_in,pc_to_stack_in,mem_write_in,mem_read_in,rti_in,int_in,ret_in,call_in: IN std_logic;

	     writeback_out, ldm_out, port_read_out, mem_to_reg_out,pc_to_stack_out,mem_write_out,mem_read_out,rti_out,int_out,ret_out,call_out: OUT std_logic;
	     stack_out:OUT std_logic_vector(1 DOWNTO 0);
	     src1add_out,scr2add_out,destadd_out:OUT std_logic_vector(2 DOWNTO 0);
	     aluout_out,scr1_out,immediate_out:OUT std_logic_vector (15 DOWNTO 0);
	     pc_out:OUT std_logic_vector (31 DOWNTO 0)
		 );
END ENTITY ExMemBuff ;

ARCHITECTURE ExMemBuff OF ExMemBuff IS 


--read anytime and write only at rising edge
BEGIN
	
	PROCESS(clk)
	BEGIN
		IF (rst='1') THEN
			stack_out<="00";
			writeback_out <='0';
			ldm_out<='0';
			port_read_out<='0';
			mem_to_reg_out<='0';
			pc_to_stack_out<='0';
			mem_write_out<='0';
			mem_read_out<='0';
			rti_out<='0';
			int_out<='0';
			ret_out<='0';
			call_out<='0';
			src1add_out<=(OTHERS=>'0');
			scr2add_out<=(OTHERS=>'0');
			destadd_out<=(OTHERS=>'0');
			aluout_out <= (others => '0'); 
			scr1_out <= (others => '0');
			immediate_out <= (others=>'0');
			pc_out <= (others=>'0');
		ELSIF(rising_edge(clk)) THEN
			stack_out<=stack_in;
			writeback_out <= writeback_in; 
			ldm_out <= ldm_in;
			port_read_out <= port_read_in;
			mem_to_reg_out <= mem_to_reg_in;
			pc_to_stack_out<=pc_to_stack_in;
			mem_write_out<=mem_write_in;
			mem_read_out<=mem_read_in;
			rti_out<=rti_in;
			int_out<=int_in;
			ret_out<=ret_in;
			call_out<=call_in;
			src1add_out<=src1add_in;
			scr2add_out<=scr2add_in;
			destadd_out<=destadd_in;
			aluout_out<=aluout_in;
			scr1_out<=scr1_in;
			immediate_out<=immediate_in;
			pc_out<=pc_in;
		END IF;
			
	END PROCESS;

END ExMemBuff;