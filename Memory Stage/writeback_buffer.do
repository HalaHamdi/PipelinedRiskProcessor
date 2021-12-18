vsim -gui work.writeback_buffer

add wave -position end  sim:/writeback_buffer/addr_Rdst_in
add wave -position end  sim:/writeback_buffer/addr_Rdst_out
add wave -position end  sim:/writeback_buffer/addr_Rsrc1_in
add wave -position end  sim:/writeback_buffer/addr_Rsrc1_out
add wave -position end  sim:/writeback_buffer/addr_Rsrc2_in
add wave -position end  sim:/writeback_buffer/addr_Rsrc2_out
add wave -position end  sim:/writeback_buffer/alu_result_in
add wave -position end  sim:/writeback_buffer/alu_result_out
add wave -position end  sim:/writeback_buffer/clk
add wave -position end  sim:/writeback_buffer/empty_sp_exception_in
add wave -position end  sim:/writeback_buffer/empty_sp_exception_out
add wave -position end  sim:/writeback_buffer/immediate_value_in
add wave -position end  sim:/writeback_buffer/immediate_value_out
add wave -position end  sim:/writeback_buffer/invalid_address_exception_in
add wave -position end  sim:/writeback_buffer/invalid_address_exception_out
add wave -position end  sim:/writeback_buffer/ldm_in
add wave -position end  sim:/writeback_buffer/ldm_out
add wave -position end  sim:/writeback_buffer/mem_to_reg_in
add wave -position end  sim:/writeback_buffer/mem_to_reg_out
add wave -position end  sim:/writeback_buffer/memory_data_in
add wave -position end  sim:/writeback_buffer/memory_data_out
add wave -position end  sim:/writeback_buffer/pc_in
add wave -position end  sim:/writeback_buffer/pc_out
add wave -position end  sim:/writeback_buffer/port_read_in
add wave -position end  sim:/writeback_buffer/port_read_out
add wave -position end  sim:/writeback_buffer/rst
add wave -position end  sim:/writeback_buffer/writeback_in
add wave -position end  sim:/writeback_buffer/writeback_out

force -freeze sim:/writeback_buffer/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/writeback_buffer/rst 0 0
force -freeze sim:/writeback_buffer/addr_Rdst_in 10#3 0
force -freeze sim:/writeback_buffer/addr_Rsrc1_in 10#4 0
force -freeze sim:/writeback_buffer/addr_Rsrc2_in 10#5 0
force -freeze sim:/writeback_buffer/alu_result_in 10#20 0
force -freeze sim:/writeback_buffer/empty_sp_exception_in 1 0
force -freeze sim:/writeback_buffer/immediate_value_in 10#21 0
force -freeze sim:/writeback_buffer/invalid_address_exception_in 0 0
force -freeze sim:/writeback_buffer/ldm_in 0 0
force -freeze sim:/writeback_buffer/mem_to_reg_in 0 0
force -freeze sim:/writeback_buffer/memory_data_in 10#22 0
force -freeze sim:/writeback_buffer/pc_in 10#50 0
force -freeze sim:/writeback_buffer/port_read_in 0 0
force -freeze sim:/writeback_buffer/writeback_in 1 0
run

force -freeze sim:/writeback_buffer/rst 1 0
run

force -freeze sim:/writeback_buffer/rst 0 0
run