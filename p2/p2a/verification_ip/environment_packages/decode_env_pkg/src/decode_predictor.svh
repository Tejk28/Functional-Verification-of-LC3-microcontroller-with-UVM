class decode_predictor extends uvm_subscriber #(decode_in_transaction); 
  
  `uvm_component_utils(decode_predictor)
 
  //Instantiates an analysis_port
  uvm_analysis_port#(decode_out_transaction) scoreboard_ap;
 
  decode_out_transaction decode_out_trans;
  bit d_model; 

  function new(string name, uvm_component parent);
     super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
     //Construct an analysis_port
     scoreboard_ap = new("scoreboard_ap", this);
  endfunction
  
  virtual function void write (decode_in_transaction t);
    `uvm_info("PRED", {"DECODE_IN  DATA:",t.convert2string()}, UVM_MEDIUM)
    
    //construct of output transaction type
    decode_out_trans = decode_out_transaction::type_id::create("decode_out_trans");

    //Call of decode_model function for prediction
    d_model = decode_model(.instr_dout(t.instruction), 
                           .npc_in(t.npc_in), 
                           .ir(decode_out_trans.IR), 
                           .npc_out(decode_out_trans.npc_out), 
                           .e_control(decode_out_trans.E_Control), 
                           .w_control(decode_out_trans.W_Control), 
                           .mem_control(decode_out_trans.Mem_Control)
                          );

    `uvm_info("PRED",{"DECODE_OUT DATA:", decode_out_trans.convert2string()}, UVM_MEDIUM)

    if(d_model == 0)
      scoreboard_ap.write(decode_out_trans);

  endfunction 

endclass
