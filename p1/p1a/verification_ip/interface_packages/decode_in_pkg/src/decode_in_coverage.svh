class decode_in_coverage extends uvm_subscriber #(decode_in_transaction);
  `uvm_component_utils(decode_in_coverage)

  int transaction_viewing_stream_h;

  function new(string name ="decode_in_coverage", uvm_component parent = null);
    super.new(name,parent);
  endfunction

 // virtual function void start_of_simulation_phase(uvm_phase phase);
 //    transaction_viewing_stream_h = $create_transaction_stream({"..", get_full_name(), ".","txn_stream"}, "TVM");
 //    `uvm_info("Coverage","Start of simulation phase Complete", UVM_MEDIUM)
 // endfunction 

  virtual function void write(T t);
     `uvm_info("COVERAGE",{"Transaction Recieved:", t.convert2string()}, UVM_MEDIUM)
  endfunction
endclass
