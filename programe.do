vsim -gui work.integration
add wave -position end sim:/integration/*
add wave -position 47  sim:/integration/execute_stage/aluflagsout
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/reset 1 0
mem load -filltype value -filldata 100 -fillradix symbolic /integration/fetch_stahe/Memory/ram(0)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/fetch_stahe/Memory/ram(1)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/fetch_stahe/Memory/ram(2)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/fetch_stahe/Memory/ram(3)
mem load -filltype value -filldata {0011100100000001 } -fillradix symbolic /integration/fetch_stahe/Memory/ram(4)
mem load -filltype value -filldata 11 -fillradix symbolic /integration/fetch_stahe/Memory/ram(5)
mem load -filltype value -filldata 0011100000000010 -fillradix symbolic /integration/fetch_stahe/Memory/ram(6)
mem load -filltype value -filldata 1111111111111111 -fillradix symbolic /integration/fetch_stahe/Memory/ram(7)
mem load -filltype value -filldata 0011100101000011 -fillradix symbolic /integration/fetch_stahe/Memory/ram(8)
mem load -filltype value -filldata 11 -fillradix symbolic /integration/fetch_stahe/Memory/ram(9)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/fetch_stahe/Memory/ram(10)
mem load -filltype value -filldata 0001100110000100 -fillradix symbolic /integration/fetch_stahe/Memory/ram(11)
mem load -filltype value -filldata 0010000111100100 -fillradix symbolic /integration/fetch_stahe/Memory/ram(12)
mem load -filltype value -filldata 0010100111100100 -fillradix symbolic /integration/fetch_stahe/Memory/ram(13)
mem load -filltype value -filldata 0000011000000000 -fillradix symbolic /integration/fetch_stahe/Memory/ram(14)
mem load -filltype value -filldata 0 -fillradix symbolic /integration/fetch_stahe/Memory/ram(15)

run
force -freeze sim:/integration/reset 0 0