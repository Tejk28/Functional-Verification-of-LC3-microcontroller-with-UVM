 

onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider fetch_env_agent_i 
add wave -noupdate /uvm_root/uvm_test_top/environment.fetch_env/agent_i/agent_i_monitor/txn_stream
add wave -noupdate -group fetch_env_agent_i_bus /hdl_top/fetch_env_agent_i_bus/*
add wave -noupdate -divider fetch_env_agent_o 
add wave -noupdate /uvm_root/uvm_test_top/environment.fetch_env/agent_o/agent_o_monitor/txn_stream
add wave -noupdate -group fetch_env_agent_o_bus /hdl_top/fetch_env_agent_o_bus/*
add wave -noupdate -divider decode_env_dec_agn_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.decode_env/dec_agn_in/dec_agn_in_monitor/txn_stream
add wave -noupdate -group decode_env_dec_agn_in_bus /hdl_top/decode_env_dec_agn_in_bus/*
add wave -noupdate -divider decode_env_dec_agn_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.decode_env/dec_agn_out/dec_agn_out_monitor/txn_stream
add wave -noupdate -group decode_env_dec_agn_out_bus /hdl_top/decode_env_dec_agn_out_bus/*
add wave -noupdate -divider execute_env_execute_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.execute_env/execute_agent_in/execute_agent_in_monitor/txn_stream
add wave -noupdate -group execute_env_execute_agent_in_bus /hdl_top/execute_env_execute_agent_in_bus/*
add wave -noupdate -divider execute_env_execute_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.execute_env/execute_agent_out/execute_agent_out_monitor/txn_stream
add wave -noupdate -group execute_env_execute_agent_out_bus /hdl_top/execute_env_execute_agent_out_bus/*
add wave -noupdate -divider writeback_env_writeback_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.writeback_env/writeback_in/writeback_in_monitor/txn_stream
add wave -noupdate -group writeback_env_writeback_in_bus /hdl_top/writeback_env_writeback_in_bus/*
add wave -noupdate -divider writeback_env_writeback_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.writeback_env/writeback_out/writeback_out_monitor/txn_stream
add wave -noupdate -group writeback_env_writeback_out_bus /hdl_top/writeback_env_writeback_out_bus/*
add wave -noupdate -divider memaccess_env_memaccess_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.memaccess_env/memaccess_in/memaccess_in_monitor/txn_stream
add wave -noupdate -group memaccess_env_memaccess_in_bus /hdl_top/memaccess_env_memaccess_in_bus/*
add wave -noupdate -divider memaccess_env_memaccess_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.memaccess_env/memaccess_out/memaccess_out_monitor/txn_stream
add wave -noupdate -group memaccess_env_memaccess_out_bus /hdl_top/memaccess_env_memaccess_out_bus/*
add wave -noupdate -divider control_env_control_in_agent_inst 
add wave -noupdate /uvm_root/uvm_test_top/environment.control_env/control_in_agent_inst/control_in_agent_inst_monitor/txn_stream
add wave -noupdate -group control_env_control_in_agent_inst_bus /hdl_top/control_env_control_in_agent_inst_bus/*
add wave -noupdate -divider control_env_control_out_agent_inst 
add wave -noupdate /uvm_root/uvm_test_top/environment.control_env/control_out_agent_inst/control_out_agent_inst_monitor/txn_stream
add wave -noupdate -group control_env_control_out_agent_inst_bus /hdl_top/control_env_control_out_agent_inst_bus/*
add wave -noupdate -divider inst_mem_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment/inst_mem_agent/inst_mem_agent_monitor/txn_stream
add wave -noupdate -group inst_mem_agent_bus /hdl_top/inst_mem_agent_bus/*
add wave -noupdate -divider data_mem_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment/data_mem_agent/data_mem_agent_monitor/txn_stream
add wave -noupdate -group data_mem_agent_bus /hdl_top/data_mem_agent_bus/*



TreeUpdate [SetDefaultTree]
quietly wave cursor active 0
configure wave -namecolwidth 472
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {27 ns} {168 ns}

