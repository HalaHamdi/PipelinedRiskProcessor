vsim -gui work.integration

add wave -position end  sim:/integration/PC
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/reset
add wave -position end  sim:/integration/execute_stage/alu/flags
add wave -position end  sim:/integration/execute_stage/out_reg_q
add wave -position end  sim:/integration/inport_val
add wave -position insertpoint  sim:/integration/decode_stage/register_file/reg_out

force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/reset 1 0
mem load -infile output.mem -format bin /integration/fetch_stahe/Memory/ram

run

force -freeze sim:/integration/reset 0 0
force -freeze sim:/integration/inport_val 16#5 0
run
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