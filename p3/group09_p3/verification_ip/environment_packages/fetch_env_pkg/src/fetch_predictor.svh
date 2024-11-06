//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
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
//   analysis_export receives transactions of type  fetch_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  ap broadcasts transactions of type fetch_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import lc3_prediction_pkg::*;

class fetch_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( fetch_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))

  bit[15:0] gold_pc = 16'h3000;
  bit[15:0] gold_npc = 16'h3001;
  bit [15:0] receivedpc;
  bit [15:0] receivednpc;


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_analysis_export #(fetch_in_transaction, fetch_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) analysis_export;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(fetch_out_transaction) ap;


  // Transaction variable for predicted values to be sent out ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef fetch_out_transaction ap_output_transaction_t;
  ap_output_transaction_t ap_output_transaction;
  // Code for sending output transaction out through ap
  // ap.write(ap_output_transaction);

  // Define transaction handles for debug visibility 
  fetch_in_transaction analysis_export_debug;
  bit a;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
    //`uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    analysis_export = new("analysis_export", this);
    ap =new("ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_analysis_export
  // Transactions received through analysis_export initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_analysis_export(fetch_in_transaction t);
    // pragma uvmf custom analysis_export_predictor begin
    //analysis_export_debug = t;
    //`uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    //ap_output_transaction = ap_output_transaction_t::type_id::create("ap_output_transaction");
    bit temp;
    fetch_out_transaction thistrans_out;
    thistrans_out = new();
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    `uvm_info("PRED", "Transaction Received through analysis_export", UVM_MEDIUM)
    temp = fetch_model(t.enable_updatePC, t.enable_fetch, t.br_taken, t.taddr, receivednpc, receivedpc, thistrans_out.instrmem_rd);
    thistrans_out.pc = gold_pc;
    thistrans_out.npc = gold_npc;
    gold_pc = receivedpc;
    gold_npc = receivednpc;
    // Code for sending output transaction out through ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    ap.write(thistrans_out);
    // pragma uvmf custom analysis_export_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

