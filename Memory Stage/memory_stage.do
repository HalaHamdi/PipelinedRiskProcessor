vsim -gui work.memory_stage

add wave -position end  sim:/memory_stage/addr_Rdst_in
add wave -position end  sim:/memory_stage/addr_Rdst_out
add wave -position end  sim:/memory_stage/addr_Rsrc1_in
add wave -position end  sim:/memory_stage/addr_Rsrc1_out
add wave -position end  sim:/memory_stage/addr_Rsrc2_in
add wave -position end  sim:/memory_stage/addr_Rsrc2_out
add wave -position end  sim:/memory_stage/alu_result_in
add wave -position end  sim:/memory_stage/alu_result_out
add wave -position end  sim:/memory_stage/call_in
add wave -position end  sim:/memory_stage/can_mem_write
add wave -position end  sim:/memory_stage/can_mem_read
add wave -position end  sim:/memory_stage/clk
add wave -position end  sim:/memory_stage/empty_sp_exception_out
add wave -position end  sim:/memory_stage/empty_sp_exception
add wave -position end  sim:/memory_stage/immediate_value_in
add wave -position end  sim:/memory_stage/immediate_value_out
add wave -position end  sim:/memory_stage/int_in
add wave -position end  sim:/memory_stage/invalid_address_exception
add wave -position end  sim:/memory_stage/invalid_address_exception_out
add wave -position end  sim:/memory_stage/ldm_in
add wave -position end  sim:/memory_stage/ldm_out
add wave -position end  sim:/memory_stage/mem_read_in
add wave -position end  sim:/memory_stage/mem_to_reg_in
add wave -position end  sim:/memory_stage/mem_to_reg_out
add wave -position end  sim:/memory_stage/mem_write_in
add wave -position end  sim:/memory_stage/memory_data_out
add wave -position end  sim:/memory_stage/mux_chosen_address
add wave -position end  sim:/memory_stage/mux_chosen_data_in
add wave -position end  sim:/memory_stage/pc_in
add wave -position end  sim:/memory_stage/pc_out
add wave -position end  sim:/memory_stage/pc_to_stack_in
add wave -position end  sim:/memory_stage/port_read_in
add wave -position end  sim:/memory_stage/port_read_out
add wave -position end  sim:/memory_stage/ret_in
add wave -position end  sim:/memory_stage/rsrc1_data_in
add wave -position end  sim:/memory_stage/rst
add wave -position end  sim:/memory_stage/rti_in
add wave -position end  sim:/memory_stage/sp
add wave -position end  sim:/memory_stage/stack_in
add wave -position end  sim:/memory_stage/writeback_in
add wave -position end  sim:/memory_stage/writeback_out
force -freeze sim:/memory_stage/clk 0 0, 1 {50 ps} -r 100

#reset cycle at the beginning
force -freeze sim:/memory_stage/rst 1 0
run

# store value 16 in memory location 4
force -freeze sim:/memory_stage/rst 0 0
force -freeze sim:/memory_stage/addr_Rdst_in 111 0
force -freeze sim:/memory_stage/addr_Rsrc2_in 111 0
force -freeze sim:/memory_stage/addr_Rsrc1_in 111 0
force -freeze sim:/memory_stage/alu_result_in 10#4 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/int_in 00 0
force -freeze sim:/memory_stage/immediate_value_in 16#EEEE 0
force -freeze sim:/memory_stage/ldm_in 0 0
force -freeze sim:/memory_stage/mem_read_in 0 0
force -freeze sim:/memory_stage/mem_to_reg_in 1 0
force -freeze sim:/memory_stage/mem_write_in 1 0
force -freeze sim:/memory_stage/pc_in 16#FFEEAABB 0
force -freeze sim:/memory_stage/pc_to_stack_in 0 0
force -freeze sim:/memory_stage/port_read_in 0 0
force -freeze sim:/memory_stage/ret_in 0 0
force -freeze sim:/memory_stage/rsrc1_data_in 10#16 0
force -freeze sim:/memory_stage/rti_in 0 0
force -freeze sim:/memory_stage/stack_in 00 0
force -freeze sim:/memory_stage/writeback_in 1 0
run

# store value 10 in memory location 5
force -freeze sim:/memory_stage/alu_result_in 16#5 0
force -freeze sim:/memory_stage/rsrc1_data_in 16#A 0
run

# store value 16 in invalid memory location
force -freeze sim:/memory_stage/alu_result_in 16#FF01 0
run

#call instruction, that pushes pc x(FFEEAABB) to stack, and decrement sp by 2
force -freeze sim:/memory_stage/pc_to_stack_in 1 0
force -freeze sim:/memory_stage/stack_in 01 0
force -freeze sim:/memory_stage/call_in 1 0
run
#ret instruction, that pops pc from stack to memory_data_out, and increment sp by 2
force -freeze sim:/memory_stage/stack_in 10 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/ret_in 1 0
force -freeze sim:/memory_stage/pc_to_stack_in 0 0
force -freeze sim:/memory_stage/mem_read_in 1 0
force -freeze sim:/memory_stage/mem_write_in 0 0
run

#ret instruction, that causes a empty sp exception
force -freeze sim:/memory_stage/ret_in 0 0
run
#there shouldn't be any update in sp
run


#another call instruction, that pushes pc x(99887766) to stack, and sp-=2
force -freeze sim:/memory_stage/pc_in 16#99887766 0
force -freeze sim:/memory_stage/pc_to_stack_in 1 0
force -freeze sim:/memory_stage/int_in 00 0
force -freeze sim:/memory_stage/call_in 1 0
force -freeze sim:/memory_stage/stack_in 01 0
force -freeze sim:/memory_stage/mem_read_in 0 0
force -freeze sim:/memory_stage/mem_write_in 1 0
run

#inturrupt instruction, that pushes pc x(11110000) to stack and sp-=2
force -freeze sim:/memory_stage/pc_in 16#11110000 0
force -freeze sim:/memory_stage/pc_to_stack_in 1 0
force -freeze sim:/memory_stage/int_in 01 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/stack_in 01 0
force -freeze sim:/memory_stage/mem_read_in 0 0
force -freeze sim:/memory_stage/mem_write_in 1 0
run


#rti instruction, that popes pc x(11110000) to mem_data_out, and sp+=2
force -freeze sim:/memory_stage/pc_to_stack_in 0 0
force -freeze sim:/memory_stage/int_in 00 0
force -freeze sim:/memory_stage/rti_in 1 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/stack_in 10 0
force -freeze sim:/memory_stage/mem_read_in 1 0
force -freeze sim:/memory_stage/mem_write_in 0 0
run


#push instruction, that pushes value x(7777) to sp, and sp-=1
force -freeze sim:/memory_stage/pc_to_stack_in 0 0
force -freeze sim:/memory_stage/int_in 00 0
force -freeze sim:/memory_stage/rti_in 0 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/stack_in 01 0
force -freeze sim:/memory_stage/mem_read_in 0 0
force -freeze sim:/memory_stage/mem_write_in 1 0
force -freeze sim:/memory_stage/rsrc1_data_in 16#7777 0
run

#pop instruction, that popes value x(7777) to mem_data_out, and sp+=1
force -freeze sim:/memory_stage/pc_to_stack_in 0 0
force -freeze sim:/memory_stage/int_in 00 0
force -freeze sim:/memory_stage/rti_in 0 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/stack_in 10 0
force -freeze sim:/memory_stage/mem_read_in 1 0
force -freeze sim:/memory_stage/mem_write_in 0 0
run
#ret instruction, that pops pc x(99887766) to mem_data_out, and sp+=2
force -freeze sim:/memory_stage/pc_to_stack_in 0 0
force -freeze sim:/memory_stage/int_in 00 0
force -freeze sim:/memory_stage/rti_in 0 0
force -freeze sim:/memory_stage/ret_in 1 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/stack_in 10 0
force -freeze sim:/memory_stage/mem_read_in 1 0
force -freeze sim:/memory_stage/mem_write_in 0 0
run
#pop instruction, that causes empty sp excpetion
force -freeze sim:/memory_stage/pc_to_stack_in 0 0
force -freeze sim:/memory_stage/int_in 00 0
force -freeze sim:/memory_stage/rti_in 0 0
force -freeze sim:/memory_stage/ret_in 0 0
force -freeze sim:/memory_stage/call_in 0 0
force -freeze sim:/memory_stage/stack_in 10 0
force -freeze sim:/memory_stage/mem_read_in 1 0
force -freeze sim:/memory_stage/mem_write_in 0 0
run
#load instruction, that loads value from invalid mem address
force -freeze sim:/memory_stage/alu_result_in 16#FFF2 0
force -freeze sim:/memory_stage/stack_in 00 0
force -freeze sim:/memory_stage/mem_read_in 1 0
force -freeze sim:/memory_stage/mem_write_in 0 0
run
#load instruction, that loads value(16) from address 4
# value(16) should be in the lower 16 bits
force -freeze sim:/memory_stage/alu_result_in 16#4 0
force -freeze sim:/memory_stage/stack_in 00 0
force -freeze sim:/memory_stage/mem_read_in 1 0
force -freeze sim:/memory_stage/mem_write_in 0 0
run