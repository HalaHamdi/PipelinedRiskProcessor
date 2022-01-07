vsim -gui work.integration

add wave -position end  sim:/integration/PC
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/reset
add wave -position end  sim:/integration/execute_stage/alu/flags
add wave -position end  sim:/integration/execute_stage/out_reg_q
add wave -position end  sim:/integration/inport_val

force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/reset 1 0
mem load -infile output.mem -format bin /integration/fetch_stahe/Memory/ram

run
force -freeze sim:/integration/reset 0 0
run
run
run
run
run
force -freeze sim:/integration/inport_val 16#5 0
run
force -freeze sim:/integration/inport_val 16#10 0
run
run
add wave -position end  sim:/integration/execute_stage/out_reg_q
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
run
run
run