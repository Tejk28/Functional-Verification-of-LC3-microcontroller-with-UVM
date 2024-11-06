class inst_mem_alu_transaction extends inst_mem_transaction;
	`uvm_object_utils(inst_mem_alu_transaction)

  constraint opcode_c {opcode inside {ADD, AND, NOT};}

  function new( string name = "" );
    super.new( name );
  endfunction

endclass
