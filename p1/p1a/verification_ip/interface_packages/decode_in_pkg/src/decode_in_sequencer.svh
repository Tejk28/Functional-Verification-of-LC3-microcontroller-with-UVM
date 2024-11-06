class decode_in_sequencer extends uvm_sequencer #(decode_in_transaction);

   `uvm_component_utils(decode_in_sequencer) 
    
    //virtual decode_in_random_sequence random_sequence;
    function new (string name = "decode_in_sequencer", uvm_component parent=null);
       super.new(name,parent);
    endfunction


    virtual function void build_phase (uvm_phase phase);
       super.build_phase(phase);
       //if(!uvm_config_db #(virtual decode_in_random_sequence)::get(this, "", "random_sequence", random_sequence))
       //  `uvm_fatal("CFG", "uvm_config_db could not get random sequences for sequencer")
       `uvm_info("Sequencer", "Build Phase compelete for decode_in_sequencer", UVM_MEDIUM)
    endfunction
       
endclass
