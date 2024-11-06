class test_top extends uvm_test;

   `uvm_component_utils(test_top)
  
  decode_in_random_sequence random_sequence_inst;
  decode_environment env_inst;
  decode_env_configuration env_config;
  decode_in_configuration d_in_cfg;
   
   function new(string name ="test_top", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);

     random_sequence_inst = decode_in_random_sequence::type_id::create("random_sequence_inst", this);

     //Create environment 
     env_inst = decode_environment::type_id::create("env_inst",this);

     //Create and call initialize from env configuration
     env_config = decode_env_configuration::type_id::create("env_config",this);
     env_config.initialize(ACTIVE, PASSIVE, "uvm_test_top.env_inst.d_in_agt","uvm_test_top.env_inst.d_out_agt","d_in_bus","d_out_bus");

     `uvm_info("TEST_TOP", "INFO: Build Phase Completed Successfully", UVM_MEDIUM)


  endfunction

  virtual function void connect_phase (uvm_phase phase);
     super.connect_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
     
     phase.raise_objection(this,"Objection raised by test_top");
     repeat(25) random_sequence_inst.start(env_config.d_in_config.get_sequencer());
     phase.drop_objection(this, "Objection dropped by test-top");

  endtask
 
endclass


