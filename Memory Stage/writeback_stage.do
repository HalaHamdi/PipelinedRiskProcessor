vsim -gui work.writeback_stage

add wave -position end  sim:/writeback_stage/clk
add wave -position end  sim:/writeback_stage/rst
add wave -position end  sim:/writeback_stage/addr_Rdst_in
add wave -position end  sim:/writeback_stage/addr_Rdst_out
add wave -position end  sim:/writeback_stage/addr_Rsrc1_in
add wave -position end  sim:/writeback_stage/addr_Rsrc2_in
add wave -position end  sim:/writeback_stage/alu_result_in
add wave -position end  sim:/writeback_stage/alu_result_out
add wave -position end  sim:/writeback_stage/empty_sp_exception_in
add wave -position end  sim:/writeback_stage/empty_sp_exception_out
add wave -position end  sim:/writeback_stage/immediate_value_in
add wave -position end  sim:/writeback_stage/immediate_value_out
add wave -position end  sim:/writeback_stage/invalid_address_exception_in
add wave -position end  sim:/writeback_stage/invalid_address_exception_out
add wave -position end  sim:/writeback_stage/ldm_in
add wave -position end  sim:/writeback_stage/ldm_out
add wave -position end  sim:/writeback_stage/mem_to_reg_in
add wave -position end  sim:/writeback_stage/memory_data_in
add wave -position end  sim:/writeback_stage/pc_in
add wave -position end  sim:/writeback_stage/port_read_in
add wave -position end  sim:/writeback_stage/port_read_out
add wave -position end  sim:/writeback_stage/writeback_in
add wave -position end  sim:/writeback_stage/writeback_mux_out
add wave -position end  sim:/writeback_stage/writeback_out

force -freeze sim:/writeback_stage/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/writeback_stage/addr_Rdst_in 10#2 0
force -freeze sim:/writeback_stage/addr_Rsrc1_in 10#4 0
force -freeze sim:/writeback_stage/addr_Rsrc2_in 10#6 0
force -freeze sim:/writeback_stage/alu_result_in 10#10 0
force -freeze sim:/writeback_stage/empty_sp_exception_in 0 0
force -freeze sim:/writeback_stage/immediate_value_in 10#11 0
force -freeze sim:/writeback_stage/invalid_address_exception_in 0 0
force -freeze sim:/writeback_stage/ldm_in 0 0
force -freeze sim:/writeback_stage/mem_to_reg_in 0 0
force -freeze sim:/writeback_stage/memory_data_in 10#12 0
force -freeze sim:/writeback_stage/pc_in 10#13 0
force -freeze sim:/writeback_stage/port_read_in 0 0
force -freeze sim:/writeback_stage/writeback_in 1 0
force -freeze sim:/writeback_stage/rst 0 0
run

force -freeze sim:/writeback_stage/ldm_in 1 0
run

force -freeze sim:/writeback_stage/ldm_in 0 0
force -freeze sim:/writeback_stage/port_read_in 1 0
run