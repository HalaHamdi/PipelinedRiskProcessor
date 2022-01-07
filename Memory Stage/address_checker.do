vsim -gui work.address_checker

add wave -position end  sim:/address_checker/address
add wave -position end  sim:/address_checker/invalid_address_exception

force -freeze sim:/address_checker/address 16#FEFF 0
run
force -freeze sim:/address_checker/address 16#FF00 0
run
force -freeze sim:/address_checker/address 16#FF01 0
run
force -freeze sim:/address_checker/address 16#FF10 0
run
force -freeze sim:/address_checker/address 16#FFFF 0
run
force -freeze sim:/address_checker/address 16#FEEE 0
run
force -freeze sim:/address_checker/address 16#1 0
run
