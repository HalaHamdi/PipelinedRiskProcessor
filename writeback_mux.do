vsim -gui work.writeback_mux

add wave -position end  sim:/writeback_mux/alu_result
add wave -position end  sim:/writeback_mux/immediate_value
add wave -position end  sim:/writeback_mux/in_port_value
add wave -position end  sim:/writeback_mux/ldm
add wave -position end  sim:/writeback_mux/memory_data
add wave -position end  sim:/writeback_mux/mem_to_reg
add wave -position end  sim:/writeback_mux/port_read
add wave -position end  sim:/writeback_mux/writeback_mux_out

force -freeze sim:/writeback_mux/alu_result 10#16 0
force -freeze sim:/writeback_mux/immediate_value 10#17 0
force -freeze sim:/writeback_mux/in_port_value 10#18 0
force -freeze sim:/writeback_mux/memory_data 10#19 0
force -freeze sim:/writeback_mux/mem_to_reg 0 0
force -freeze sim:/writeback_mux/port_read 0 0
force -freeze sim:/writeback_mux/ldm 0 0
run

force -freeze sim:/writeback_mux/ldm 1 0
run

force -freeze sim:/writeback_mux/ldm 0 0
force -freeze sim:/writeback_mux/port_read 1 0
run

force -freeze sim:/writeback_mux/port_read 0 0
force -freeze sim:/writeback_mux/mem_to_reg 1 0
run

force -freeze sim:/writeback_mux/mem_to_reg 0 0
run

#an invalid case, this should never happen in any instruction
force -freeze sim:/writeback_mux/mem_to_reg 1 0
force -freeze sim:/writeback_mux/port_read 1 0
run