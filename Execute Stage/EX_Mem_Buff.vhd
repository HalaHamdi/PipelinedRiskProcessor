LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY ExMemBuff IS
	PORT(clk,rst:IN std_logic;
	     src1add_in,scr2add_in,destadd_in:IN std_logic_vector(2 DOWNTO 0);
	     aluout_in,scr1_in,immediate_in:IN std_logic_vector (15 DOWNTO 0);
	     pc_in:IN std_logic_vector (31 DOWNTO 0);
		 
		 writeback_in, ldm_in, port_read_in, mem_to_reg_in: IN std_logic;
		 
		 writeback_out, ldm_out, port_read_out, mem_to_reg_out: OUT std_logic;
		 
		 src1add_out,scr2add_out,destadd_out:OUT std_logic_vector(2 DOWNTO 0);
	     aluout_out,scr1_out,immediate_out:OUT std_logic_vector (15 DOWNTO 0);
	     pc_out:OUT std_logic_vector (31 DOWNTO 0);
		 
		 );
END ENTITY ExMemBuff ;

ARCHITECTURE ExMemBuff OF ExMemBuff IS 
signal  src1addS,scr2addS,destaddS :std_logic_vector(2 DOWNTO 0);
signal  aluoutS,scr1S,immediateS :std_logic_vector (15 DOWNTO 0);
signal  pcS :std_logic_vector (31 DOWNTO 0);

--read anytime and write only at rising edge
BEGIN
	
	PROCESS(clk)
	Variable  src1addV,scr2addV,destaddV :std_logic_vector(2 DOWNTO 0);
	Variable  aluoutV,scr1V,immediateV :std_logic_vector (15 DOWNTO 0);
	Variable  pcV :std_logic_vector (31 DOWNTO 0);
	BEGIN
		IF (rst='1') THEN
			src1add_in <=(OTHERS=>'0');
			scr2addV:=(OTHERS=>'0');
			destaddV:=(OTHERS=>'0');
			aluoutV:=(OTHERS=>'0');
			scr1V:=(OTHERS=>'0');
			immediateV:=(OTHERS=>'0');
			pcV:=(OTHERS=>'0');
			writeback_out <= (others => '0'); 
			ldm_out <= (others => '0');
			port_read_out <= (others=>'0');
			mem_to_reg_out <= (others=>'0');
		ELSIF(rising_edge(clk)) THEN
			src1addV:=src1add;
			scr2addV:=scr2add;
			destaddV:=destadd;
			aluoutV:=aluout;
			scr1V:=scr1;
			immediateV:=immediate;
			pcV:=pc;
			writeback_out <= writeback_in; 
			ldm_out <= ldm_in;
			port_read_out <= port_read_in;
			mem_to_reg_out <= mem_to_reg_in;
		END IF;
		
			src1addS<=src1addV;
			scr2addS<=scr2addV;
			destaddS<=destaddV;
			aluoutS<=aluoutV;
			scr1S<=scr1V;
			immediateS<=immediateV;
			pcS<=pcV;
			
	END PROCESS;

src1add<=src1addS;
scr2add<=scr2addS;
destadd<=destaddS;
aluout<=aluoutS;
scr1<=scr1S;
immediate<=immediateS;
pc<=pcS;

END ExMemBuff;