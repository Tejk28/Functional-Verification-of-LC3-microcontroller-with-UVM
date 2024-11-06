//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class inst_mem_responder_alu_sequence extends inst_mem_responder_sequence ;

	`uvm_object_utils( inst_mem_responder_alu_sequence )
	
	bit[2:0] dest_reg = 0;
	int j = 0;
	// pragma uvmf custom class_item_additional begin
	// pragma uvmf custom class_item_additional end
	
	function new(string name = "inst_mem_responder_alu_sequence");
	  super.new(name);
	endfunction
	
	task body();

	  `uvm_info("ALU_SEQ",$sformatf("Running ALU instructions"),UVM_LOW)
	  `uvm_info("ALU_SEQ",$sformatf("Initialising the registers::"),UVM_HIGH)
	  req=inst_mem_transaction::type_id::create("req");
	    start_item(req);
	    if(!req.randomize() with {req.opcode == LD;}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = dest_reg;
	    finish_item(req);
	  repeat(8) begin
	    req=inst_mem_transaction::type_id::create("req");
	    start_item(req);
	    if(!req.randomize() with {req.opcode == LD;}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = dest_reg;
	    finish_item(req);
	    dest_reg = dest_reg + 1;
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    // pragma uvmf custom body end
	  end
	
	  `uvm_info("ALU_SEQ",$sformatf("Now ALUs::"),UVM_HIGH)
	
	  repeat(50) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD,NOT,AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    // pragma uvmf custom body end
	  end
	  `uvm_info("ALU_SEQ",$sformatf("DONE"),UVM_HIGH)


	  repeat(10) begin 
	  for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[5] = 1'b1;
	    req.instr_dout[8:6] = i;
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[5] = 1'b0;
	    req.instr_dout[2:0] = i;
	    req.instr_dout[11:9] = i;
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	  end
	  for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[5] = 1'b1;
	    req.instr_dout[8:6] = i;
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[5] = 1'b0;
	    req.instr_dout[2:0] = i;
	    req.instr_dout[11:9] = i;
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	  end
	  for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	  end
	
	  for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	end
	  for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	end
	  for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	end

	for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	end
	
	for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	end
	for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	end
	
	for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD, AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD , AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = i;
	    j = req.instr_dout[11:9];
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD , AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = j;
	    finish_item(req);
	end
	for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD, AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD , AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[2:0] = i;
	    req.instr_dout[5] = 0;
	    j = req.instr_dout[11:9];
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {ADD, AND};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = j;
	    finish_item(req);
	end
	for(int i = 0 ; i < 8 ; i++) begin
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[11:9] = i;
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    j = req.instr_dout[11:9];
	    finish_item(req);
	    `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
	    start_item(req);
	    if(!req.randomize() with {req.opcode inside {NOT};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
	    req.instr_dout[8:6] = j;
	    finish_item(req);
	end

	end
	  `uvm_info("ALU_SEQ",$sformatf("DONE ALU instructions"),UVM_HIGH)

	endtask

endclass
