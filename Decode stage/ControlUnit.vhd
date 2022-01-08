LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ControlUnit IS 
    PORT(
        family : IN STD_LOGIC_VECTOR(1 downto 0) ;
        func : IN STD_LOGIC_VECTOR(2 downto 0) ;
        src1_addr : IN STD_LOGIC_VECTOR(2 downto 0) ;
        call , memread , memwrite , alusrc , pc_to_stack , ldm , memtoreg , regwrite , portread , portwrite
        , mem_to_pc , rti , ret : OUT STD_LOGIC;
        stack : OUT STD_LOGIC_VECTOR(1 downto 0) ;
        aluop : OUT STD_LOGIC_VECTOR(2 downto 0) 
    );
END ControlUnit;

ARCHITECTURE ControlUnit_Imp OF ControlUnit IS 
-- This vector is ordered like the signals is ordered in our excel sheet  alusrc ,aluop , ....  , ret  , call
-- Except there is no INT signal instead the stack signal takes two bits 9-8
-- For exact order see the assignment statements at the end of if block
-- ----------------The Order of Signals --------------
--      alusrc aluop memwrite memread memtoreg regwrite
--      stack2 portread portwrite ldm pcstack memtopc 
--      rti ret call 
SIGNAL  signals : std_logic_vector(17 downto 0);
BEGIN 
PROCESS (family , func)
BEGIN
-- SETC
 if (family = "00") AND (func = "000") then
    signals <= "000000000000000000";
-- NOT
elsif (family = "00") AND (func = "001") then
    signals <= "000100010000000000";
-- INC
elsif (family = "00") AND (func = "010") then
    signals <= "001000010000000000";
-- MOV
elsif (family = "00") AND (func = "011") then
    signals <= "001100010000000000";
-- ADD
elsif (family = "00") AND (func = "100") then
    signals <= "110000010000000000";
-- AND
elsif (family = "00") AND (func = "101") then
    signals <= "110100010000000000";
-- SUB 
elsif (family = "00") AND (func = "110") then
    signals <= "111000010000000000";
-- IADD 
elsif (family = "00") AND (func = "111") then
    signals <= "010000010000000000";
-- NOP
elsif (family = "10") AND (func = "001") then
    signals <= "001100000000000000";
-- HLT
elsif (family = "10") AND (func = "000") then
    signals <= "001100000000000000";
-- OUT
elsif (family = "01") AND (func = "001") then
    signals <= "001100000001000000";
-- IN
elsif (family = "01") AND (func = "000") then
    signals <= "001100010010000000";
-- LDD
elsif (family = "01") AND (func = "010") then 
     signals <= "010001110000000000";
-- STD
elsif (family = "01") AND (func = "011") then 
     signals <= "010010000000000000";
-- PUSH
elsif (family = "01") AND (func = "100") then 
     signals <= "101110000100000000";
-- POP
elsif (family = "01") AND (func = "101") then 
     signals <= "001101111000000000";
-- LDM
elsif (family = "01") AND (func = "110") then 
     signals <= "010000010000100000";
-- JZ
elsif (family = "11") AND (func = "000") then 
     signals <= "001100000000000000";
-- JC
elsif (family = "11") AND (func = "001") then 
     signals <= "001100000000000000";
-- JN
elsif (family = "11") AND (func = "010") then 
     signals <= "001100000000000000";
-- JMP
elsif (family = "11") AND (func = "011") then 
     signals <= "001100000000000000";
-- Call
elsif (family = "11") AND (func = "100") then 
     signals <= "001110000100010001";
-- Ret
elsif (family = "11") AND (func = "101") then 
     signals <= "001101001000001010";
-- INT
elsif (family = "11") AND (func = "110") then 
     signals <= "001110000100011000";
-- RTI
elsif (family = "11") AND (func = "111") then 
     signals <= "001101001000001100";
else
    signals <="001100000000000000";
end if;
end process;
alusrc  <=signals(17);
aluop <= signals(16 downto 14);
memwrite <= signals(13);
memread <= signals(12);
memtoreg <=signals(11);
regwrite <=signals(10);
stack <= signals(9 downto 8);
portread <=signals(7);
portwrite <=signals(6);
ldm <=signals(5);
pc_to_stack <=signals(4);
mem_to_pc <=signals(3);
rti <=signals(2);
ret <=signals(1);
call <= signals(0);

END ControlUnit_Imp;

