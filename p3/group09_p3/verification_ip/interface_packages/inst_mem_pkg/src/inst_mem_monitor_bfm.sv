//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the inst_mem signal monitoring.
//      It is accessed by the uvm inst_mem monitor through a virtual
//      interface handle in the inst_mem configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type inst_mem_if.
//
//     Input signals from the inst_mem_if are assigned to an internal input
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
//                   blocks until an operation on the inst_mem bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import inst_mem_pkg_hdl::*;
`include "src/inst_mem_macros.svh"


interface inst_mem_monitor_bfm 
  ( inst_mem_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute inst_mem_monitor_bfm partition_interface_xif                                  

  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`inst_mem_MONITOR_STRUCT
  inst_mem_monitor_s inst_mem_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `inst_mem_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri [15:0] PC_i;
  tri  instrmem_rd_i;
  tri [15:0] instr_dout_i;
  tri  complete_instr_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign PC_i = bus.PC;
  assign instrmem_rd_i = bus.instrmem_rd;
  assign instr_dout_i = bus.instr_dout;
  assign complete_instr_i = bus.complete_instr;

  // Proxy handle to UVM monitor
  inst_mem_pkg::inst_mem_monitor  proxy;
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
  // pragma uvmf custom reset_condition begin
    wait ( reset_i == 0 ) ;                                                              
    @(posedge clock_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
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
      do_monitor( inst_mem_monitor_struct );
                                                                 
 
      proxy.notify_transaction( inst_mem_monitor_struct );
 
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
    function void configure(inst_mem_configuration_s inst_mem_configuration_arg); // pragma tbx xtf  
    initiator_responder = inst_mem_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output inst_mem_monitor_s inst_mem_monitor_struct);
    //
    // Available struct members:
    //     //    inst_mem_monitor_struct.opcode
    //     //    inst_mem_monitor_struct.sr1
    //     //    inst_mem_monitor_struct.sr2
    //     //    inst_mem_monitor_struct.dr
    //     //    inst_mem_monitor_struct.mode
    //     //    inst_mem_monitor_struct.baser
    //     //    inst_mem_monitor_struct.pcoffset9
    //     //    inst_mem_monitor_struct.pcoffset6
    //     //    inst_mem_monitor_struct.imm5
    //     //    inst_mem_monitor_struct.nzp
    //     //    inst_mem_monitor_struct.PC
    //     //    inst_mem_monitor_struct.instrmem_rd
    //     //    inst_mem_monitor_struct.instr_dout
    //     //    inst_mem_monitor_struct.complete_instr
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal == 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      inst_mem_monitor_struct.xyz = PC_i;  //    [15:0] 
    //      inst_mem_monitor_struct.xyz = instrmem_rd_i;  //     
    //      inst_mem_monitor_struct.xyz = instr_dout_i;  //    [15:0] 
    //      inst_mem_monitor_struct.xyz = complete_instr_i;  //     
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
    //@(posedge clock_i);
    //@(posedge clock_i);
    //@(posedge clock_i);
    //@(posedge clock_i);
    inst_mem_monitor_struct.PC 			   = PC_i;  //    [15:0] 
    inst_mem_monitor_struct.instrmem_rd    = instrmem_rd_i;  //     
    inst_mem_monitor_struct.instr_dout	   = instr_dout_i;  //    [15:0] 
    inst_mem_monitor_struct.complete_instr = complete_instr_i;  //     
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

