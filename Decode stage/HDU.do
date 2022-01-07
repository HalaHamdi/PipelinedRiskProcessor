vsim -gui work.hdu
add wave -position insertpoint  \
sim:/hdu/Rsrc1_addr \
sim:/hdu/Rsrc2_addr \
sim:/hdu/buff2_Rdst_addr \
sim:/hdu/buff2_memread \
sim:/hdu/clear_signals \
sim:/hdu/disable_buff \
sim:/hdu/freeze_pc
force -freeze sim:/hdu/buff2_memread 0 0
force -freeze sim:/hdu/Rsrc1_addr 000 0
force -freeze sim:/hdu/Rsrc2_addr 001 0
force -freeze sim:/hdu/buff2_Rdst_addr 111 0
run
force -freeze sim:/hdu/buff2_memread 1 0
run
force -freeze sim:/hdu/Rsrc1_addr 111 0
force -freeze sim:/hdu/buff2_memread 0 0
run
force -freeze sim:/hdu/buff2_memread 1 0
run
run
force -freeze sim:/hdu/Rsrc1_addr 110 0
run
force -freeze sim:/hdu/Rsrc2_addr 111 0
run
force -freeze sim:/hdu/buff2_Rdst_addr 110 0
run
force -freeze sim:/hdu/buff2_memread 0 0
run
