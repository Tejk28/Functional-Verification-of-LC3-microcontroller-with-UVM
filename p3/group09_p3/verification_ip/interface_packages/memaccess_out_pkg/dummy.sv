//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the memaccess_out signal monitoring.
//      It is accessed by the uvm memaccess_out monitor through a virtual
//      interface handle in the memaccess_out configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type memaccess_out_if.
//
//     Input signals from the memaccess_out_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the memaccess_out bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import memaccess_out_pkg_hdl::*;

`include "src/memaccess_out_macros.svh"

interface memaccess_out_monitor_bfm 
  ( memaccess_out_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute memaccess_out_monitor_bfm partition_interface_xif                                  

  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`memaccess_out_MONITOR_STRUCT
  memaccess_out_monitor_s memaccess_out_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `memaccess_out_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri [15:0] DMem_addr_i;
  tri [15:0] DMem_din_i;
  tri [15:0] memout_i;
  tri  DMem_rd_i;
  tri [1:0] mem_state_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign DMem_addr_i = bus.DMem_addr;
  assign DMem_din_i = bus.DMem_din;
  assign memout_i = bus.memout;
  assign DMem_rd_i = bus.DMem_rd;
  assign mem_state_i = bus.mem_state;
  bit start=0;
  reg [15:0] DMem_addr_tmp;
  reg [15:0] DMem_din_tmp;
  reg [15:0] memout_tmp;
  reg  DMem_rd_tmp;
  reg [1:0]mem_state;

  // Proxy handle to UVM monitor
  memaccess_out_pkg::memaccess_out_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clock_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset();                                                                 
    wait ( reset_i == 0 ) ;                                                              
    @(posedge clock_i) ;                                                                    
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clock_i);  
                                                                   
    repeat (count-1) @(posedge clock_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;                                                                                   
    forever begin                                                                        
      @(posedge clock_i);  
      do_monitor( memaccess_out_monitor_struct );
                                                                 
 
      proxy.notify_transaction( memaccess_out_monitor_struct );
 
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(memaccess_out_configuration_s memaccess_out_configuration_arg); // pragma tbx xtf  
    initiator_responder = memaccess_out_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output memaccess_out_monitor_s memaccess_out_monitor_struct);
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
    //
    // Available struct members:
    //     //    memaccess_out_monitor_struct.DMem_addr
    //     //    memaccess_out_monitor_struct.DMem_din
    //     //    memaccess_out_monitor_struct.memout
    //     //    memaccess_out_monitor_struct.DMem_rd
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal == 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      memaccess_out_monitor_struct.xyz = DMem_addr_i;  //    [15:0] 
    //      memaccess_out_monitor_struct.xyz = DMem_din_i;  //    [15:0] 
    //      memaccess_out_monitor_struct.xyz = memout_i;  //    [15:0] 
    //      memaccess_out_monitor_struct.xyz = DMem_rd_i;  //     
    //      memaccess_out_monitor_struct.xyz = mem_state_i;  //    [1:0] 
    // pragma uvmf custom do_monitor begin
    while(mem_state_i == mem_state) @(posedge clock_i);
	
	if(!start) begin 
	
		start <= 1'b1;
		
		DMem_addr_tmp <= DMem_addr_i;
		DMem_din_tmp <= DMem_din_i;
		memout_tmp <= memout_i;
		DMem_rd_tmp <= DMem_rd_i;
		mem_state <= mem_state_i;
		
		@(posedge clock_i);
		//#1ns;
	end
	
	if(start) begin
	
		DMem_addr_tmp <= DMem_addr_i;
		DMem_din_tmp <= DMem_din_i;
		memout_tmp <= memout_i;
		DMem_rd_tmp <= DMem_rd_i;
		mem_state <= mem_state_i;
		
		memaccess_out_monitor_struct.DMem_addr = DMem_addr_tmp;
		memaccess_out_monitor_struct.DMem_din = DMem_din_tmp;
		memaccess_out_monitor_struct.memout = memout_tmp;
		memaccess_out_monitor_struct.DMem_rd = DMem_rd_tmp;
		
	end
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface
