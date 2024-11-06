add wave -noupdate /hdl_top/d_in_bus/clock
add wave -noupdate /hdl_top/d_in_bus/reset
add wave -noupdate /hdl_top/d_in_bus/enable_decode
add wave -noupdate /hdl_top/d_in_bus/dout
add wave -noupdate /hdl_top/d_in_bus/npc_in
add wave -noupdate /hdl_top/d_out_bus/IR
add wave -noupdate /hdl_top/d_out_bus/npc_out
add wave -noupdate /hdl_top/d_out_bus/E_Control
add wave -noupdate /hdl_top/d_out_bus/W_Control
add wave -noupdate /hdl_top/d_out_bus/Mem_Control


add wave -noupdate -expand /uvm_root/uvm_test_top/env_inst/d_in_agt/d_in_agt_monitor/txn_stream
add wave -noupdate -expand /uvm_root/uvm_test_top/env_inst/d_out_agt/d_out_agt_monitor/txn_stream 

