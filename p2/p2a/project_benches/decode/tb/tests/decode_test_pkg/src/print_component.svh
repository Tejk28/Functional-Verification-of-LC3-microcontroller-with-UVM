class print_component extends uvm_component;
  `uvm_component_utils(print_component);

  uvm_analysis_imp_d_in_bus#(decode_in_transaction, print_component) d_in_bus_exp;
  uvm_analysis_imp_d_out_bus#(decode_out_transaction, print_component) d_out_bus_exp;

  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    d_in_bus_exp = new("d_in_bus_exp",this);
    d_out_bus_exp = new("d_out_bus_exp",this);
  endfunction

  function void write_d_in_bus(decode_in_transaction t);
    `uvm_info("PRINT_COMPONENT","Decode In Transaction Recevied", UVM_MEDIUM);
    t.print();
  endfunction

  function void write_d_out_bus(decode_out_transaction t);
    `uvm_info("PRINT_COMPONENT","Decode Out Transaction Recevied", UVM_MEDIUM);
    t.print();

  endfunction
  
endclass
