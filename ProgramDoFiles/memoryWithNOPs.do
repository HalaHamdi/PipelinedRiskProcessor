vsim -gui work.integration

add wave -position end  sim:/integration/PC
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/inport_val
add wave -position end  sim:/integration/epc
add wave -position end  sim:/integration/reset
add wave -position end  sim:/integration/execute_stage/out_reg_q
add wave -position end  sim:/integration/writeback_mux_W
add wave -position end  sim:/integration/memory_stage/sp
add wave -position end  sim:/integration/writeback_stage/empty_sp_exception_out
add wave -position end  sim:/integration/writeback_stage/invalid_address_exception_out
add wave -position end  sim:/integration/stack_sig_E
add wave -position end  sim:/integration/stack_sig_D
add wave -position end  sim:/integration/empty_sp_exception_M
add wave -position end  sim:/integration/invalid_address_exception_M
mem load -infile output.mem -format bin /integration/fetch_stahe/Memory/ram

force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/reset 1 0
run
force -freeze sim:/integration/reset 0 0
run
force -freeze sim:/integration/inport_val 16#19 0
run
force -freeze sim:/integration/inport_val 16#FFFF 0
run
force -freeze sim:/integration/inport_val 16#F320 0
run
run
run
run
run
force -freeze sim:/integration/inport_val 16#10 0

run
run
run
run
run
run
run
run
run
run
run
run
run
run