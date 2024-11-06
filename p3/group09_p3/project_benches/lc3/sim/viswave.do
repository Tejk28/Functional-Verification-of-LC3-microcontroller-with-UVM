 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { fetch_env_agent_i }
wave add uvm_test_top.environment.fetch_env.agent_i.agent_i_monitor.txn_stream -radix string -tag F0
wave group fetch_env_agent_i_bus
wave add -group fetch_env_agent_i_bus hdl_top.fetch_env_agent_i_bus.* -radix hexadecimal -tag F0
wave group fetch_env_agent_i_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_env_agent_o }
wave add uvm_test_top.environment.fetch_env.agent_o.agent_o_monitor.txn_stream -radix string -tag F0
wave group fetch_env_agent_o_bus
wave add -group fetch_env_agent_o_bus hdl_top.fetch_env_agent_o_bus.* -radix hexadecimal -tag F0
wave group fetch_env_agent_o_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_dec_agn_in }
wave add uvm_test_top.environment.decode_env.dec_agn_in.dec_agn_in_monitor.txn_stream -radix string -tag F0
wave group decode_env_dec_agn_in_bus
wave add -group decode_env_dec_agn_in_bus hdl_top.decode_env_dec_agn_in_bus.* -radix hexadecimal -tag F0
wave group decode_env_dec_agn_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_dec_agn_out }
wave add uvm_test_top.environment.decode_env.dec_agn_out.dec_agn_out_monitor.txn_stream -radix string -tag F0
wave group decode_env_dec_agn_out_bus
wave add -group decode_env_dec_agn_out_bus hdl_top.decode_env_dec_agn_out_bus.* -radix hexadecimal -tag F0
wave group decode_env_dec_agn_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_agent_in }
wave add uvm_test_top.environment.execute_env.execute_agent_in.execute_agent_in_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_agent_in_bus
wave add -group execute_env_execute_agent_in_bus hdl_top.execute_env_execute_agent_in_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_agent_out }
wave add uvm_test_top.environment.execute_env.execute_agent_out.execute_agent_out_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_agent_out_bus
wave add -group execute_env_execute_agent_out_bus hdl_top.execute_env_execute_agent_out_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_writeback_in }
wave add uvm_test_top.environment.writeback_env.writeback_in.writeback_in_monitor.txn_stream -radix string -tag F0
wave group writeback_env_writeback_in_bus
wave add -group writeback_env_writeback_in_bus hdl_top.writeback_env_writeback_in_bus.* -radix hexadecimal -tag F0
wave group writeback_env_writeback_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_writeback_out }
wave add uvm_test_top.environment.writeback_env.writeback_out.writeback_out_monitor.txn_stream -radix string -tag F0
wave group writeback_env_writeback_out_bus
wave add -group writeback_env_writeback_out_bus hdl_top.writeback_env_writeback_out_bus.* -radix hexadecimal -tag F0
wave group writeback_env_writeback_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_in }
wave add uvm_test_top.environment.memaccess_env.memaccess_in.memaccess_in_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_in_bus
wave add -group memaccess_env_memaccess_in_bus hdl_top.memaccess_env_memaccess_in_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_out }
wave add uvm_test_top.environment.memaccess_env.memaccess_out.memaccess_out_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_out_bus
wave add -group memaccess_env_memaccess_out_bus hdl_top.memaccess_env_memaccess_out_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_control_in_agent_inst }
wave add uvm_test_top.environment.control_env.control_in_agent_inst.control_in_agent_inst_monitor.txn_stream -radix string -tag F0
wave group control_env_control_in_agent_inst_bus
wave add -group control_env_control_in_agent_inst_bus hdl_top.control_env_control_in_agent_inst_bus.* -radix hexadecimal -tag F0
wave group control_env_control_in_agent_inst_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { control_env_control_out_agent_inst }
wave add uvm_test_top.environment.control_env.control_out_agent_inst.control_out_agent_inst_monitor.txn_stream -radix string -tag F0
wave group control_env_control_out_agent_inst_bus
wave add -group control_env_control_out_agent_inst_bus hdl_top.control_env_control_out_agent_inst_bus.* -radix hexadecimal -tag F0
wave group control_env_control_out_agent_inst_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { inst_mem_agent }
wave add uvm_test_top.environment.inst_mem_agent.inst_mem_agent_monitor.txn_stream -radix string -tag F0
wave group inst_mem_agent_bus
wave add -group inst_mem_agent_bus hdl_top.inst_mem_agent_bus.* -radix hexadecimal -tag F0
wave group inst_mem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { data_mem_agent }
wave add uvm_test_top.environment.data_mem_agent.data_mem_agent_monitor.txn_stream -radix string -tag F0
wave group data_mem_agent_bus
wave add -group data_mem_agent_bus hdl_top.data_mem_agent_bus.* -radix hexadecimal -tag F0
wave group data_mem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

