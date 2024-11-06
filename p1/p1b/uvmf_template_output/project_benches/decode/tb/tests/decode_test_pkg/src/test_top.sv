class test_top extends uvm_test;

   `uvm_component_utils(test_top)
  
  decode_in_random_sequence random_sequence_inst;
  decode_in_configuration d_in_cfg;
  decode_in_agent d_in_agt;

  decode_out_agent d_out_agt;
  decode_out_configuration d_out_cfg;

  print_component print_component_inst;
  
   //virtual decode_in_if bus;
   
   function new(string name ="test_top", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);

     random_sequence_inst = decode_in_random_sequence::type_id::create("random_sequence_inst", this);
     d_in_cfg = decode_in_configuration::type_id::create ("d_in_cfg", this);
     d_in_agt = decode_in_agent::type_id::create ("d_in_agt", this);
     //Instation of decode out agent & agent config
     d_out_agt = decode_out_agent::type_id::create("d_out_agt", this);
     d_out_cfg = decode_out_configuration::type_id::create("d_out_cfg",this);
     //creating print_component class
     print_component_inst = print_component::type_id::create("print_component_inst",this);

     //uvm_config_db#(decode_in_configuration)::set(null,"*","d_in_cfg",d_in_cfg);
     //decode_out_configuration
     //uvm_config_db#(decode_out_configuration)::set(null,"*","d_out_cfg",d_out_cfg);
     d_in_cfg.initiator_responder=INITIATOR; 
     d_out_cfg.initiator_responder= RESPONDER;
     d_in_cfg.initialize(ACTIVE,"uvm_test_top.d_in_agt","d_in_bus");
     d_out_cfg.initialize(PASSIVE, "uvm_test_top.d_out_agt","d_out_bus");

     `uvm_info("TEST_TOP", "INFO: Build Phase Completed Successfully", UVM_MEDIUM)


  endfunction

  virtual function void connect_phase (uvm_phase phase);
     super.connect_phase(phase);
      d_in_agt.monitored_ap.connect(print_component_inst.d_in_bus_exp);
      d_out_agt.monitored_ap.connect(print_component_inst.d_out_bus_exp);
  endfunction

  virtual task run_phase(uvm_phase phase);
     
     phase.raise_objection(this,"Objection raised by test_top");
     repeat(25) random_sequence_inst.start(d_in_cfg.get_sequencer());
     phase.drop_objection(this, "Objection dropped by test-top");

  endtask
 
endclass


