//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class fetch_environment  extends uvmf_environment_base #(
    .CONFIG_T( fetch_env_configuration 
  ));
  `uvm_component_utils( fetch_environment )





  typedef fetch_in_agent  agent_i_t;
  agent_i_t agent_i;

  typedef fetch_out_agent  agent_o_t;
  agent_o_t agent_o;




  typedef fetch_predictor #(
                .CONFIG_T(CONFIG_T)
                ) pred_t;
  pred_t pred;

  typedef uvmf_in_order_race_scoreboard #(.T(fetch_out_transaction))  sb_t;
  sb_t sb;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(fetch_env_configuration)) fetch_vsqr_t;
  fetch_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    agent_i = agent_i_t::type_id::create("agent_i",this);
    agent_o = agent_o_t::type_id::create("agent_o",this);
    pred = pred_t::type_id::create("pred",this);
    pred.configuration = configuration;
    sb = sb_t::type_id::create("sb",this);

    vsqr = fetch_vsqr_t::type_id::create("vsqr", this);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    agent_i.monitored_ap.connect(pred.analysis_export);
    pred.ap.connect(sb.expected_analysis_export);
    agent_o.monitored_ap.connect(sb.actual_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

