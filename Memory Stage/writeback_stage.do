vsim -gui work.writeback_stage

add wave -position end  sim:/writeback_stage/rst
add wave -position end  sim:/writeback_stage/clk
add wave -position end  sim:/writeback_stage/in_port_val

add wave -position end  sim:/writeback_stage/addr_Rdst_in
add wave -position end  sim:/writeback_stage/buff_addr_Rdst
add wave -position end  sim:/writeback_stage/addr_Rdst_out

add wave -position end  sim:/writeback_stage/addr_Rsrc1_in
add wave -position end  sim:/writeback_stage/buff_addr_Rsrc1

add wave -position end  sim:/writeback_stage/addr_Rsrc2_in
add wave -position end  sim:/writeback_stage/buff_addr_Rsrc2

add wave -position end  sim:/writeback_stage/alu_result_in
add wave -position end  sim:/writeback_stage/buff_alu_result
add wave -position end  sim:/writeback_stage/alu_result_out

add wave -position end  sim:/writeback_stage/immediate_value_in
add wave -position end  sim:/writeback_stage/buff_immediate_value
add wave -position end  sim:/writeback_stage/immediate_value_out

add wave -position end  sim:/writeback_stage/empty_sp_exception_in
add wave -position end  sim:/writeback_stage/buff_empty_sp_exception
add wave -position end  sim:/writeback_stage/empty_sp_exception_out

add wave -position end  sim:/writeback_stage/invalid_address_exception_in
add wave -position end  sim:/writeback_stage/buff_invalid_address_exception
add wave -position end  sim:/writeback_stage/invalid_address_exception_out

add wave -position end  sim:/writeback_stage/mem_to_reg_in
add wave -position end  sim:/writeback_stage/buff_mem_to_reg

add wave -position end  sim:/writeback_stage/memory_data_in
add wave -position end  sim:/writeback_stage/buff_memory_data

add wave -position end  sim:/writeback_stage/ldm_in
add wave -position end  sim:/writeback_stage/buff_ldm
add wave -position end  sim:/writeback_stage/ldm_out

add wave -position end  sim:/writeback_stage/port_read_in
add wave -position end  sim:/writeback_stage/buff_port_read
add wave -position end  sim:/writeback_stage/port_read_out

add wave -position end  sim:/writeback_stage/pc_in
add wave -position end  sim:/writeback_stage/buff_pc

add wave -position end  sim:/writeback_stage/writeback_in
add wave -position end  sim:/writeback_stage/buff_writeback
add wave -position end  sim:/writeback_stage/writeback_out

add wave -position end  sim:/writeback_stage/epc

add wave -position end  sim:/writeback_stage/writeback_mux_out


force -freeze sim:/writeback_stage/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/writeback_stage/rst 1 0
run

#pass the alu result (10#16) to the writeback out mux
force -freeze sim:/writeback_stage/addr_Rdst_in 011 0
force -freeze sim:/writeback_stage/addr_Rsrc1_in 111 0
force -freeze sim:/writeback_stage/addr_Rsrc2_in 101 0
force -freeze sim:/writeback_stage/alu_result_in 16#16 0
force -freeze sim:/writeback_stage/empty_sp_exception_in 0 0
force -freeze sim:/writeback_stage/immediate_value_in 16#17 0
force -freeze sim:/writeback_stage/invalid_address_exception_in 0 0
force -freeze sim:/writeback_stage/ldm_in 0 0
force -freeze sim:/writeback_stage/mem_to_reg_in 0 0
force -freeze sim:/writeback_stage/memory_data_in 16#FFFFAAAA 0
force -freeze sim:/writeback_stage/pc_in 16#BBBBCCCC 0
force -freeze sim:/writeback_stage/port_read_in 0 0
force -freeze sim:/writeback_stage/rst 0 0
force -freeze sim:/writeback_stage/writeback_in 1 0
run

#pass the in port val (16#70) to the writeback out mux
force -freeze sim:/writeback_stage/in_port_val 16#70 0
force -freeze sim:/writeback_stage/port_read_in 1 0
run

#pass the memory data (16#AAAA) to the writeback out mux
force -freeze sim:/writeback_stage/port_read_in 0 0
force -freeze sim:/writeback_stage/mem_to_reg_in 1 0
run

#pass the immediate data (16#17) to the writeback out mux
force -freeze sim:/writeback_stage/mem_to_reg_in 0 0
force -freeze sim:/writeback_stage/ldm_in 1 0
run

#pass the alu result (16#DDDD) to the writeback out mux
force -freeze sim:/writeback_stage/ldm_in 0 0
force -freeze sim:/writeback_stage/alu_result_in 16#DDDD 0
run

#epc should be 16#77778888
force -freeze sim:/writeback_stage/invalid_address_exception_in 1 0
force -freeze sim:/writeback_stage/pc_in 16#77778888 0
run
#epc should be 16#FFFFAAAA
force -freeze sim:/writeback_stage/empty_sp_exception_in 1 0
force -freeze sim:/writeback_stage/invalid_address_exception_in 0 0
force -freeze sim:/writeback_stage/pc_in 16#FFFFAAAA 0
run