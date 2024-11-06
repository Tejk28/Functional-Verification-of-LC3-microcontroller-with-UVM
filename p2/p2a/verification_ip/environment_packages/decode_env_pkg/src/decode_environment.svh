class decode_environment extends uvm_env;

  `uvm_component_utils(decode_environment)

  //Instantiates of agents, predictor and scoreboard
  decode_env_configuration configuration;
  decode_in_agent d_in_agt;
  decode_out_agent d_out_agt;
  decode_predictor decode_pred; 
  decode_scoreboard decode_sb;
  
  function new(string name="", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d_in_agt = decode_in_agent::type_id::create("d_in_agt",this);
    //d_in_agt.set_config(configuration.d_in_config);
    d_out_agt = decode_out_agent::type_id::create("d_out_agt",this);
    //d_out_agt.set_config(configuration.d_out_config);
    decode_pred = decode_predictor::type_id::create("decode_pred",this);
    decode_sb = decode_scoreboard::type_id::create("decode_sb",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d_in_agt.monitored_ap.connect(decode_pred.analysis_export);
    decode_pred.scoreboard_ap.connect(decode_sb.expected_ae);
    d_out_agt.monitored_ap.connect(decode_sb.actual_ae); 
  endfunction
endclass
