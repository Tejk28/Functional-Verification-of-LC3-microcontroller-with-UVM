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

class decode_environment  extends uvmf_environment_base #(
    .CONFIG_T( decode_env_configuration 
  ));
  `uvm_component_utils( decode_environment )





  typedef decode_in_agent  dec_agn_in_t;
  dec_agn_in_t dec_agn_in;

  typedef decode_out_agent  dec_agn_out_t;
  dec_agn_out_t dec_agn_out;




  typedef decode_predictor #(
                .CONFIG_T(CONFIG_T)
                ) dec_pred_t;
  dec_pred_t dec_pred;

  typedef uvmf_in_order_race_scoreboard #(.T(decode_out_transaction))  dec_scrbd_t;
  dec_scrbd_t dec_scrbd;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(decode_env_configuration)) decode_vsqr_t;
  decode_vsqr_t vsqr;

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
    dec_agn_in = dec_agn_in_t::type_id::create("dec_agn_in",this);
    dec_agn_in.set_config(configuration.dec_agn_in_config);
    dec_agn_out = dec_agn_out_t::type_id::create("dec_agn_out",this);
    dec_agn_out.set_config(configuration.dec_agn_out_config);
    dec_pred = dec_pred_t::type_id::create("dec_pred",this);
    dec_pred.configuration = configuration;
    dec_scrbd = dec_scrbd_t::type_id::create("dec_scrbd",this);

    vsqr = decode_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

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
    dec_agn_in.monitored_ap.connect(dec_pred.analysis_export);
    dec_pred.dec_pred_ap.connect(dec_scrbd.expected_analysis_export);
    dec_agn_out.monitored_ap.connect(dec_scrbd.actual_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.decode_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

