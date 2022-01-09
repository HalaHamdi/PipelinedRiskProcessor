vsim -gui work.integration
add wave -position insertpoint  \
sim:/integration/fetch_stahe/is_jump \
sim:/integration/fetch_stahe/jump_add
add wave -position end  sim:/integration/PC
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/epc
add wave -position end  sim:/integration/empty_sp_exception_M

add wave -position end  sim:/integration/inport_val
add wave -position end  sim:/integration/invalid_address_exception_M
add wave -position end  sim:/integration/reset

add wave -position end  sim:/integration/fetch_stahe/instruction
add wave -position end  sim:/integration/fetch_stahe/disable
add wave -position end  sim:/integration/flags
add wave -position end  sim:/integration/memory_stage/sp
add wave -position insertpoint  sim:/integration/decode_stage/register_file/reg_out
add wave -position insertpoint  sim:/integration/decode_stage/hdu/buff2_memread \sim:/integration/decode_stage/hdu/buff2_Rdst_addr \sim:/integration/decode_stage/hdu/clear_signals \sim:/integration/decode_stage/hdu/clk \sim:/integration/decode_stage/hdu/disable_buff \sim:/integration/decode_stage/hdu/freeze_pc \sim:/integration/decode_stage/hdu/Rsrc1_addr \sim:/integration/decode_stage/hdu/Rsrc2_addr

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
add wave -position 1  sim:/integration/inport_val_F
force -freeze sim:/integration/inport_val_F 16#700 0
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