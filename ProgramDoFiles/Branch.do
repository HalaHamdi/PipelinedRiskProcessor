vsim -gui work.integration

add wave -position end  sim:/integration/PC
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/epc
add wave -position end  sim:/integration/empty_sp_exception_M

add wave -position 10  sim:/integration/pc_to_stack_sig_D
add wave -position 2  sim:/integration/pc_to_stack_sig_E
add wave -position end  sim:/integration/inport_val
add wave -position end  sim:/integration/invalid_address_exception_M
add wave -position end  sim:/integration/reset
add wave -position end  sim:/integration/fetch_stahe/PC
add wave -position end  sim:/integration/fetch_stahe/add_exp
add wave -position end  sim:/integration/fetch_stahe/buff4_add_exp
add wave -position end  sim:/integration/fetch_stahe/buff4_sp_exp
add wave -position end  sim:/integration/fetch_stahe/data_mem_out
add wave -position end  sim:/integration/fetch_stahe/disable
add wave -position end  sim:/integration/fetch_stahe/inport_val_in
add wave -position end  sim:/integration/fetch_stahe/inport_val_out
add wave -position end  sim:/integration/fetch_stahe/instruction
add wave -position end  sim:/integration/fetch_stahe/int_out
add wave -position end  sim:/integration/fetch_stahe/is_jump
add wave -position end  sim:/integration/fetch_stahe/jump_add
add wave -position end  sim:/integration/fetch_stahe/mem_to_pc
add wave -position end  sim:/integration/fetch_stahe/sp_exp
add wave -position 7  sim:/integration/fetch_stahe/state
add wave -position end  sim:/integration/decode_stage/control_unit/signals
add wave -position end  sim:/integration/flags
add wave -position end  sim:/integration/execute_stage/sig_jump
add wave -position end  sim:/integration/forwarded_src1_E
add wave -position end  sim:/integration/memory_stage/sp
add wave -position end  sim:/integration/memory_stage/call_in
add wave -position end  sim:/integration/memory_stage/int_in
add wave -position end  sim:/integration/memory_stage/rti_in
add wave -position 3  sim:/integration/stack_sig_D
add wave -position 4  sim:/integration/stack_sig_E
add wave -position end  sim:/integration/memory_stage/ret_in
add wave -position 25  sim:/integration/func_D
add wave -position 26  sim:/integration/family

force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/reset 1 0
mem load -infile output.mem -format bin /integration/fetch_stahe/Memory/ram

run
force -freeze sim:/integration/reset 0 0
run

force -freeze sim:/integration/inport_val 16#30 0
run
force -freeze sim:/integration/inport_val 16#50 0
run
force -freeze sim:/integration/inport_val 16#100 0
run
force -freeze sim:/integration/inport_val 16#300 0
run
run
run
run
run
run
run
run
run