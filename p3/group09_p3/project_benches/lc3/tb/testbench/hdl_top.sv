//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//
import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;
`timescale 1ns/1ns
module hdl_top;


  // pragma attribute hdl_top partition_module_xrtl
// pragma uvmf custom clock_generator begin
  bit clk;

  // Instantiate a clk driver
  // tbx clkgen
  initial begin
    clk = 0;
    #10;
    forever begin
      clk = ~clk;
      #5;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1;
    #43;
    rst =  0;
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactiinstrmem_rd_ions onto the bus, _if.


  fetch_in_if  fetch_env_agent_i_bus(
     // pragma uvmf custom fetch_env_agent_i_bus_connections begin
     .clock(clk), .reset(rst), .enable_updatePC(DUT.enable_updatePC), .enable_fetch(DUT.enable_fetch), .taddr(DUT.pcout), .br_taken(DUT.br_taken)
     // pragma uvmf custom fetch_env_agent_i_bus_connections end
     );
  fetch_out_if  fetch_env_agent_o_bus(
     // pragma uvmf custom fetch_env_agent_o_bus_connections begin
	.clock(clk), .reset(rst), .npc(DUT.npc_out_fetch), .pc(DUT.pc), .instrmem_rd(DUT.instrmem_rd), .enable_fetch(DUT.enable_fetch), .enable_updatePC(DUT.enable_updatePC)
     // pragma uvmf custom fetch_env_agent_o_bus_connections end
     );
  decode_in_if  decode_env_my_decode_agent_bus(
     // pragma uvmf custom decode_env_my_decode_agent_bus_connections begin
                        .clock(clk),
                        .reset(rst),
                        .npc_in(DUT.npc_out_fetch),
                        .enable_decode(DUT.enable_decode),
                        .dout(DUT.Instr_dout),
                        .psr(DUT.psr)
     // pragma uvmf custom decode_env_my_decode_agent_bus_connections end
     );
  decode_out_if  decode_env_my_out_decode_agent_bus(
     // pragma uvmf custom decode_env_my_out_decode_agent_bus_connections begin
                        .clock(clk),
                        .reset(rst),
                        .W_Control(DUT.W_Control),
                        .Mem_Control(DUT.Mem_Control),
                        .E_Control(DUT.E_Control),
                        .enable_decode(DUT.enable_decode),
                        .IR(DUT.IR),
                        .npc_out(DUT.npc_out_dec)
     // pragma uvmf custom decode_env_my_out_decode_agent_bus_connections end
     );
  execute_in_if  execute_env_execute_agent_in_bus(
     // pragma uvmf custom execute_env_execute_agent_in_bus_connections begin
				    .clock(clk) ,
				    .reset(rst) ,
				    .enable_execute(DUT.enable_execute) ,
				    .W_Control_in(DUT.W_Control),
				    .Mem_Control_in(DUT.Mem_Control),
				    .E_Control(DUT.E_Control),
				    .IR(DUT.IR),
				    .npc(DUT.npc_out_dec),
				    .VSR1(DUT.VSR1),
				    .VSR2(DUT.VSR2),
				    .Mem_Bypass_Val(DUT.memout),
				    .bypass_alu_1(DUT.bypass_alu_1),
				    .bypass_alu_2(DUT.bypass_alu_2),
				    .bypass_mem_1(DUT.bypass_mem_1),
				    .bypass_mem_2(DUT.bypass_mem_2));
     // pragma uvmf custom execute_env_execute_agent_in_bus_connections end
  execute_out_if  execute_env_execute_agent_out_bus(
     // pragma uvmf custom execute_env_execute_agent_out_bus_connections begin
				      .clock(clk) ,
				      .reset(rst) ,
				      .enable_execute(DUT.enable_execute) ,
				      .aluout(DUT.aluout),
		    		      .pcout(DUT.pcout),
		    		      .W_Control_out(DUT.W_Control_out),
		    		      .Mem_Control_out(DUT.Mem_Control_out),
		    		      .NZP(DUT.NZP),
		    		      .IR_Exec(DUT.IR_Exec),
		    		      .sr1(DUT.sr1),
		    		      .sr2(DUT.sr2),
		    		      .dr(DUT.dr),
		    		      .M_Data(DUT.M_Data));
     // pragma uvmf custom execute_env_execute_agent_out_bus_connections end
  writeback_in_if  writeback_env_writeback_in_bus(
     // pragma uvmf custom writeback_env_writeback_in_bus_connections begin
                    .clock(clk),
                    .reset(rst),
                    .enable_writeback(DUT.enable_writeback),
                    .aluout(DUT.aluout),
                    .W_Control_in(DUT.W_Control_out),
                    .memout(DUT.memout),
                    .pcout(DUT.pcout),
                    .npc(DUT.npc_out_dec),
                    .sr1(DUT.sr1),
                    .sr2(DUT.sr2),
                    .dr(DUT.dr)
     // pragma uvmf custom writeback_env_writeback_in_bus_connections end
     );
  writeback_out_if  writeback_env_writeback_out_bus(
     // pragma uvmf custom writeback_env_writeback_out_bus_connections begin
                    .clock(clk),
                    .reset(rst),
                    .VSR1(DUT.VSR1),
                    .VSR2(DUT.VSR2),
                    .psr(DUT.psr),
                    .enable_writeback(DUT.enable_writeback)
     // pragma uvmf custom writeback_env_writeback_out_bus_connections end
     );
  memaccess_in_if  memaccess_env_memaccess_in_bus(
     // pragma uvmf custom memaccess_env_memaccess_in_bus_connections begin
     .clock(clk), .reset(rst),.mem_state(DUT.mem_state),.M_Data(DUT.M_Data),.M_Addr(DUT.pcout),.DMem_dout(DUT.Data_dout),.M_Control(DUT.Mem_Control_out)
     // pragma uvmf custom memaccess_env_memaccess_in_bus_connections end
     );
  memaccess_out_if  memaccess_env_memaccess_out_bus(
     // pragma uvmf custom memaccess_env_memaccess_out_bus_connections begin
     .clock(clk), .reset(rst),.DMem_addr(DUT.Data_addr),.DMem_rd(DUT.Data_rd),.DMem_din(DUT.Data_din),.memout(DUT.memout) , .mem_state(DUT.mem_state)
     // pragma uvmf custom memaccess_env_memaccess_out_bus_connections end
     );
  control_in_if  control_env_control_in_agent_inst_bus(
     // pragma uvmf custom control_env_control_in_agent_inst_bus_connections begin
                                      .clock(clk),
                                      .reset(rst),
                                      .complete_data(DUT.complete_data),
                                      .complete_instr(DUT.complete_instr),
                                      .IR(DUT.IR),
                                      .NZP(DUT.NZP),
                                      .psr(DUT.psr),
                                      .IR_Exec(DUT.IR_Exec),
                                      .IMem_dout(DUT.Instr_dout)
     // pragma uvmf custom control_env_control_in_agent_inst_bus_connections end
     );
  control_out_if  control_env_control_out_agent_inst_bus(
     // pragma uvmf custom control_env_control_out_agent_inst_bus_connections begin
                                       .clock(clk),
                                       .reset(rst),
                                       .enable_updatePC(DUT.enable_updatePC),
                                       .enable_fetch(DUT.enable_fetch),
                                       .enable_decode(DUT.enable_decode),
                                       .enable_execute(DUT.enable_execute),
                                       .enable_writeback(DUT.enable_writeback),
                                       .br_taken(DUT.br_taken),
                                       .bypass_alu_1(DUT.bypass_alu_1),
                                       .bypass_alu_2(DUT.bypass_alu_2),
                                       .bypass_mem_1(DUT.bypass_mem_1),
                                       .bypass_mem_2(DUT.bypass_mem_2),
                                       .mem_state(DUT.mem_state)
     // pragma uvmf custom control_env_control_out_agent_inst_bus_connections end
     );
  inst_mem_if  inst_mem_agent_bus(
     // pragma uvmf custom inst_mem_agent_bus_connections begin
     .clock(clk), .reset(rst), .PC(DUT.pc), .instrmem_rd(DUT.instrmem_rd), .instr_dout(DUT.Instr_dout), .complete_instr(DUT.complete_instr)
     // pragma uvmf custom inst_mem_agent_bus_connections end
     );
  data_mem_if  data_mem_agent_bus(
     // pragma uvmf custom data_mem_agent_bus_connections begin
     .clock(clk), .reset(rst), .Data_dout(DUT.Data_dout), .Data_din(DUT.Data_din), .Data_rd(DUT.Data_rd), .Data_addr(DUT.Data_addr), .complete_data(DUT.complete_data)
     // pragma uvmf custom data_mem_agent_bus_connections end
     );
  fetch_in_monitor_bfm  fetch_env_agent_i_mon_bfm(fetch_env_agent_i_bus.monitor_port);
  fetch_out_monitor_bfm  fetch_env_agent_o_mon_bfm(fetch_env_agent_o_bus.monitor_port);
  decode_in_monitor_bfm  decode_env_my_decode_agent_mon_bfm(decode_env_my_decode_agent_bus.monitor_port);
  decode_out_monitor_bfm  decode_env_my_out_decode_agent_mon_bfm(decode_env_my_out_decode_agent_bus.monitor_port);
  execute_in_monitor_bfm  execute_env_execute_agent_in_mon_bfm(execute_env_execute_agent_in_bus.monitor_port);
  execute_out_monitor_bfm  execute_env_execute_agent_out_mon_bfm(execute_env_execute_agent_out_bus.monitor_port);
  writeback_in_monitor_bfm  writeback_env_writeback_in_mon_bfm(writeback_env_writeback_in_bus.monitor_port);
  writeback_out_monitor_bfm  writeback_env_writeback_out_mon_bfm(writeback_env_writeback_out_bus.monitor_port);
  memaccess_in_monitor_bfm  memaccess_env_memaccess_in_mon_bfm(memaccess_env_memaccess_in_bus.monitor_port);
  memaccess_out_monitor_bfm  memaccess_env_memaccess_out_mon_bfm(memaccess_env_memaccess_out_bus.monitor_port);
  control_in_monitor_bfm  control_env_control_in_agent_inst_mon_bfm(control_env_control_in_agent_inst_bus.monitor_port);
  control_out_monitor_bfm  control_env_control_out_agent_inst_mon_bfm(control_env_control_out_agent_inst_bus.monitor_port);
  inst_mem_monitor_bfm  inst_mem_agent_mon_bfm(inst_mem_agent_bus.monitor_port);
  data_mem_monitor_bfm  data_mem_agent_mon_bfm(data_mem_agent_bus.monitor_port);
  inst_mem_driver_bfm  inst_mem_agent_drv_bfm(inst_mem_agent_bus.responder_port);
  data_mem_driver_bfm  data_mem_agent_drv_bfm(data_mem_agent_bus.responder_port);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
//   verilog_dut         dut_verilog(   .clk(clk), .rst(rst), .in_signal(vhdl_to_verilog_signal), .out_signal(verilog_to_vhdl_signal));
//   vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));
  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual fetch_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_agent_i_BFM , fetch_env_agent_i_mon_bfm );
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_agent_o_BFM , fetch_env_agent_o_mon_bfm );
    uvm_config_db #( virtual decode_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_my_decode_agent_BFM , decode_env_my_decode_agent_mon_bfm );
    uvm_config_db #( virtual decode_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_my_out_decode_agent_BFM , decode_env_my_out_decode_agent_mon_bfm );
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_agent_in_BFM , execute_env_execute_agent_in_mon_bfm );
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_agent_out_BFM , execute_env_execute_agent_out_mon_bfm );
    uvm_config_db #( virtual writeback_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_in_BFM , writeback_env_writeback_in_mon_bfm );
    uvm_config_db #( virtual writeback_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_out_BFM , writeback_env_writeback_out_mon_bfm );
    uvm_config_db #( virtual memaccess_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_in_BFM , memaccess_env_memaccess_in_mon_bfm );
    uvm_config_db #( virtual memaccess_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_out_BFM , memaccess_env_memaccess_out_mon_bfm );
    uvm_config_db #( virtual control_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_control_in_agent_inst_BFM , control_env_control_in_agent_inst_mon_bfm );
    uvm_config_db #( virtual control_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , control_env_control_out_agent_inst_BFM , control_env_control_out_agent_inst_mon_bfm );
    uvm_config_db #( virtual inst_mem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , inst_mem_agent_BFM , inst_mem_agent_mon_bfm );
    uvm_config_db #( virtual data_mem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , data_mem_agent_BFM , data_mem_agent_mon_bfm );
    uvm_config_db #( virtual inst_mem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , inst_mem_agent_BFM , inst_mem_agent_drv_bfm  );
    uvm_config_db #( virtual data_mem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , data_mem_agent_BFM , data_mem_agent_drv_bfm  );
  end

  LC3 DUT (	.clock(clk),
  		.reset(rst),
  		.pc(inst_mem_agent_bus.PC) ,
		.instrmem_rd(inst_mem_agent_bus.instrmem_rd),
		.Instr_dout(inst_mem_agent_bus.instr_dout),
		.Data_addr(data_mem_agent_bus.Data_addr),
		.complete_instr(inst_mem_agent_bus.complete_instr),
		.complete_data(data_mem_agent_bus.complete_data),
		.Data_din(data_mem_agent_bus.Data_din),
		.Data_dout(data_mem_agent_bus.Data_dout),
		.Data_rd(data_mem_agent_bus.Data_rd));

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end
