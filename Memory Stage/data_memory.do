vsim -gui work.data_memory

add wave -position end  sim:/data_memory/Clk
add wave -position end  sim:/data_memory/address
add wave -position end  sim:/data_memory/data_in
add wave -position end  sim:/data_memory/data_out
add wave -position end  sim:/data_memory/mem
add wave -position end  sim:/data_memory/mem_read
add wave -position end  sim:/data_memory/mem_write
add wave -position end  sim:/data_memory/pc_to_stack

force -freeze sim:/data_memory/Clk 0 0, 1 {50 ps} -r 100

force -freeze sim:/data_memory/address 10#16 0
force -freeze sim:/data_memory/mem_read 0 0
force -freeze sim:/data_memory/mem_write 1 0
force -freeze sim:/data_memory/pc_to_stack 1 0
force -freeze sim:/data_memory/data_in 16#FFFFAAAA 0
run

force -freeze sim:/data_memory/mem_write 1 0
force -freeze sim:/data_memory/pc_to_stack 0 0
force -freeze sim:/data_memory/address 10#16 0
force -freeze sim:/data_memory/data_in 16#FFFF 0
run

force -freeze sim:/data_memory/data_in 16#0000 0
force -freeze sim:/data_memory/mem_write 0 0
run

force -freeze sim:/data_memory/mem_read 1 0
force -freeze sim:/data_memory/address 10#16 0
run

force -freeze sim:/data_memory/address 10#17 0
force -freeze sim:/data_memory/mem_read 1 0
run

force -freeze sim:/data_memory/mem_read 0 0
run