vsim -gui work.controlunit
add wave -position insertpoint  \
sim:/controlunit/aluop \
sim:/controlunit/alusrc \
sim:/controlunit/call \
sim:/controlunit/family \
sim:/controlunit/func \
sim:/controlunit/ldm \
sim:/controlunit/mem_to_pc \
sim:/controlunit/memread \
sim:/controlunit/memtoreg \
sim:/controlunit/memwrite \
sim:/controlunit/pc_to_stack \
sim:/controlunit/portread \
sim:/controlunit/portwrite \
sim:/controlunit/regwrite \
sim:/controlunit/ret \
sim:/controlunit/rti \
sim:/controlunit/signals \
sim:/controlunit/src1_addr \
sim:/controlunit/stack
force -freeze sim:/controlunit/family 00 0
force -freeze sim:/controlunit/func 000 0
run
force -freeze sim:/controlunit/func 001 0
run
force -freeze sim:/controlunit/func 010 0
run
force -freeze sim:/controlunit/func 011 0
run
force -freeze sim:/controlunit/func 100 0
run
force -freeze sim:/controlunit/func 101 0
run
force -freeze sim:/controlunit/func 110 0
run
force -freeze sim:/controlunit/func 111 0
run
force -freeze sim:/controlunit/family 11 0
force -freeze sim:/controlunit/func 000 0
run
force -freeze sim:/controlunit/func 001 0
run