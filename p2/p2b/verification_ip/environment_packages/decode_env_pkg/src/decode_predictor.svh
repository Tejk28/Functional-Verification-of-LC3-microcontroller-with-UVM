//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   analysis_export receives transactions of type  decode_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  scoreboard_ap broadcasts transactions of type decode_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class decode_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( decode_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_analysis_export #(decode_in_transaction, decode_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) analysis_export;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(decode_out_transaction) scoreboard_ap;


  // Transaction variable for predicted values to be sent out scoreboard_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef decode_out_transaction scoreboard_ap_output_transaction_t;
  scoreboard_ap_output_transaction_t scoreboard_ap_output_transaction;
  // Code for sending output transaction out through scoreboard_ap
  // scoreboard_ap.write(scoreboard_ap_output_transaction);
  bit d_model;
  // Define transaction handles for debug visibility 
  decode_in_transaction analysis_export_debug;


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
    `uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    analysis_export = new("analysis_export", this);
    scoreboard_ap =new("scoreboard_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_analysis_export
  // Transactions received through analysis_export initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_analysis_export(decode_in_transaction t);
    // pragma uvmf custom analysis_export_predictor begin
    analysis_export_debug = t;
    `uvm_info("PRED", "Transaction Received through analysis_export", UVM_MEDIUM)
    `uvm_info("PRED", {"           DECODE_IN Data: ",t.convert2string()}, UVM_MEDIUM)
    // Construct one of each output transaction type.
    scoreboard_ap_output_transaction = scoreboard_ap_output_transaction_t::type_id::create("scoreboard_ap_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  

    //Call of decode_model function for prediction
    d_model = decode_model(.instr_dout(t.instruction), 
                           .npc_in(t.npc_in), 
                           .ir(scoreboard_ap_output_transaction.IR), 
                           .npc_out(scoreboard_ap_output_transaction.npc_out), 
                           .e_control(scoreboard_ap_output_transaction.E_Control), 
                           .w_control(scoreboard_ap_output_transaction.W_Control), 
                           .mem_control(scoreboard_ap_output_transaction.Mem_Control)
                          );

    //`uvm_info("PRED",{"DECODE_OUT DATA:", scoreboard_ap_output_transaction.convert2string()}, UVM_MEDIUM)

    // Code for sending output transaction out through scoreboard_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    if(d_model == 0)
      scoreboard_ap.write(scoreboard_ap_output_transaction);
    // pragma uvmf custom analysis_export_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

