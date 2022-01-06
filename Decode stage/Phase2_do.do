vsim -gui work.decode_stage
add wave -position insertpoint  \
sim:/decode_stage/Rdst_addr_in \
sim:/decode_stage/Rdst_addr_wb \
sim:/decode_stage/Rdst_data_wb \
sim:/decode_stage/Rsrc1_addr_in \
sim:/decode_stage/Rsrc2_addr_in \
sim:/decode_stage/buff2_Rdst_addr \
sim:/decode_stage/buff2_memread \
sim:/decode_stage/clk \
sim:/decode_stage/family_in \
sim:/decode_stage/func \
sim:/decode_stage/offset_in \
sim:/decode_stage/pc_in \
sim:/decode_stage/rst \
sim:/decode_stage/write_back \
sim:/decode_stage/Rdst \
sim:/decode_stage/Rsrc1 \
sim:/decode_stage/Rsrc1_addr \
sim:/decode_stage/Rsrc2 \
sim:/decode_stage/Rsrc2_addr \
sim:/decode_stage/aluop \
sim:/decode_stage/alusrc \
sim:/decode_stage/call \
sim:/decode_stage/disable_buff \
sim:/decode_stage/family \
sim:/decode_stage/freeze_pc \
sim:/decode_stage/ldm \
sim:/decode_stage/mem_to_pc \
sim:/decode_stage/memread \
sim:/decode_stage/memtoreg \
sim:/decode_stage/memwrite \
sim:/decode_stage/offset \
sim:/decode_stage/pc \
sim:/decode_stage/pc_to_stack \
sim:/decode_stage/portread \
sim:/decode_stage/portwrite \
sim:/decode_stage/regwrite \
sim:/decode_stage/ret \
sim:/decode_stage/rti \
sim:/decode_stage/stack
noforce sim:/decode_stage/clk
force -freeze sim:/decode_stage/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/decode_stage/family_in 01 0
force -freeze sim:/decode_stage/func 101 0
force -freeze sim:/decode_stage/Rdst_addr_in 100 0
run
run
force -freeze sim:/decode_stage/family_in 00 0
force -freeze sim:/decode_stage/func 100 0
force -freeze sim:/decode_stage/buff2_Rdst_addr 101 0
force -freeze sim:/decode_stage/Rsrc1_addr_in 101 0
force -freeze sim:/decode_stage/Rsrc2_addr_in 111 0
run
run
force -freeze sim:/decode_stage/buff2_memread 1 0
run
run
force -freeze sim:/decode_stage/buff2_memread 0 0
force -freeze sim:/decode_stage/family_in 01 0
force -freeze sim:/decode_stage/func 101 0
run
run
force -freeze sim:/decode_stage/rst 1 0
run
run
