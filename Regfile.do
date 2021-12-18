vsim -gui work.registerfile
add wave -position insertpoint  \
sim:/registerfile/Rdst_addr \
sim:/registerfile/Rdst_data \
sim:/registerfile/Rsrc1 \
sim:/registerfile/Rsrc1_addr \
sim:/registerfile/Rsrc2 \
sim:/registerfile/Rsrc2_addr \
sim:/registerfile/clk \
sim:/registerfile/reg_enable \
sim:/registerfile/reg_out \
sim:/registerfile/rst \
sim:/registerfile/tri_state_src1 \
sim:/registerfile/tri_state_src2 \
sim:/registerfile/wb
force -freeze sim:/registerfile/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/registerfile/wb 1 0
force -freeze sim:/registerfile/Rdst_addr 100 0
force -freeze sim:/registerfile/Rdst_data 1100110010101111 0
noforce sim:/registerfile/Rsrc1
force -freeze sim:/registerfile/Rsrc1_addr 100 0
force -freeze sim:/registerfile/Rsrc2_addr 000 0
run
force -freeze sim:/registerfile/Rdst_data 1111000011110000 0
force -freeze sim:/registerfile/Rdst_addr 110 0
run
force -freeze sim:/registerfile/Rdst_addr 000 0
run
force -freeze sim:/registerfile/wb 0 0
force -freeze sim:/registerfile/Rsrc1_addr 110 0
run