vsim -gui work.fetch

add wave -position end sim:/fetch/*
mem load -filltype value -filldata 0 -fillradix symbolic /fetch/Memory/ram(0)
mem load -filltype value -filldata 10 -fillradix symbolic /fetch/Memory/ram(0)
mem load -filltype value -filldata 0 -fillradix symbolic /fetch/Memory/ram(1)
mem load -filltype value -filldata 0010011000000000 -fillradix symbolic /fetch/Memory/ram(2)
mem load -filltype value -filldata 0000011000000000 -fillradix symbolic /fetch/Memory/ram(3)
mem load -filltype value -filldata 0 -fillradix symbolic /fetch/Memory/ram(4)
force -freeze sim:/fetch/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/fetch/reset 1 0

run 