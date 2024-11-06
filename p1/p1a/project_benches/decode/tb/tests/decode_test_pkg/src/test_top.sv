class test_top extends uvm_test;

   `uvm_component_utils(test_top)
  
  decode_in_random_sequence random_sequence_inst;
  decode_in_configuration m_cfg;
  decode_in_agent m_agt;

   virtual decode_in_if d_vif;
   
   function new(string name ="test_top", uvm_component parent = null);
      super.new(name,parent);
   endfunction

  virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);

     random_sequence_inst = decode_in_random_sequence::type_id::create("random_sequence_inst", this);
     m_cfg = decode_in_configuration::type_id::create ("m_cfg", this);
     m_agt = decode_in_agent::type_id::create ("m_agt", this);

     uvm_config_db#(decode_in_configuration)::set(null,"*","m_cfg",m_cfg);
     `uvm_info("TEST_TOP", "INFO: Build Phase Completed Successfully", UVM_MEDIUM)

  endfunction

  virtual task run_phase(uvm_phase phase);
     
     phase.raise_objection(this,"Objection raised by test_top");
     repeat(25) random_sequence_inst.start(m_agt.seq_handle);
     phase.drop_objection(this, "Objection dropped by test-top");

  endtask
 
endclass


