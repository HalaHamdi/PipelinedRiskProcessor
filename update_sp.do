vsim -gui work.update_stack

add wave -position end  sim:/update_stack/Clk
add wave -position end  sim:/update_stack/call
add wave -position end  sim:/update_stack/empty_sp_exception
add wave -position end  sim:/update_stack/int
add wave -position end  sim:/update_stack/new_sp
add wave -position end  sim:/update_stack/old_sp
add wave -position end  sim:/update_stack/ret
add wave -position end  sim:/update_stack/rti
add wave -position end  sim:/update_stack/stack

force -freeze sim:/update_stack/ret 0 0
force -freeze sim:/update_stack/rti 0 0
force -freeze sim:/update_stack/Clk 1 0, 0 {50 ps} -r 100

force -freeze sim:/update_stack/old_sp 10#16 0
force -freeze sim:/update_stack/stack 10#1 0
force -freeze sim:/update_stack/call 1 0
force -freeze sim:/update_stack/int 0 0
run

force -freeze sim:/update_stack/old_sp 10#16 0
force -freeze sim:/update_stack/call 0 0
force -freeze sim:/update_stack/int 0 0
run

force -freeze sim:/update_stack/old_sp 10#16 0
force -freeze sim:/update_stack/call 0 0
force -freeze sim:/update_stack/int 1 0
run

force -freeze sim:/update_stack/old_sp 10#16 0
force -freeze sim:/update_stack/stack 10#2 0
force -freeze sim:/update_stack/int 0 0
force -freeze sim:/update_stack/call 0 0
force -freeze sim:/update_stack/rti 1 0
force -freeze sim:/update_stack/ret 0 0
run

force -freeze sim:/update_stack/old_sp 10#16 0
force -freeze sim:/update_stack/ret 0 0
force -freeze sim:/update_stack/rti 0 0
run

force -freeze sim:/update_stack/old_sp 10#16 0
force -freeze sim:/update_stack/rti 0 0
force -freeze sim:/update_stack/ret 1 0
run

force -freeze sim:/update_stack/ret 0 0
force -freeze sim:/update_stack/rti 0 0
force -freeze sim:/update_stack/old_sp 10#524288 0
run

force -freeze sim:/update_stack/old_sp 10#7 0
force -freeze sim:/update_stack/ret 0 0
force -freeze sim:/update_stack/rti 0 0
run

force -freeze sim:/update_stack/old_sp 10#524287 0
force -freeze sim:/update_stack/rti 0 0
force -freeze sim:/update_stack/ret 1 0
run

force -freeze sim:/update_stack/old_sp 10#524286 0
force -freeze sim:/update_stack/rti 0 0
force -freeze sim:/update_stack/ret 1 0
run

force -freeze sim:/update_stack/old_sp 10#524287 0
force -freeze sim:/update_stack/ret 0 0
force -freeze sim:/update_stack/rti 1 0
run