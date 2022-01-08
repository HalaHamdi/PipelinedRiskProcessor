vsim -gui work.fetch
add wave -position end sim:/fetch/*
force -freeze sim:/fetch/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetch/reset 1 0
force -freeze sim:/fetch/is_jump 0 0
force -freeze sim:/fetch/jump_add 16#30 0
force -freeze sim:/fetch/mem_to_pc 0 0
force -freeze sim:/fetch/data_mem_out 16#200 0
force -freeze sim:/fetch/sp_exp 0 0
force -freeze sim:/fetch/add_exp 0 0
force -freeze sim:/fetch/buff4_sp_exp 0 0
force -freeze sim:/fetch/buff4_add_exp 0 0
force -freeze sim:/fetch/disable 0 0
force -freeze sim:/fetch/inport_val_in 10#10 0
force -freeze sim:/fetch/inport_val_out 10#10 0
mem load -infile output.mem -format bin /fetch/Memory/ram
run
force -freeze sim:/fetch/reset 0 0
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