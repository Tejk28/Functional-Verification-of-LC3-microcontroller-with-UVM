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
class inst_mem_responder_branch_sequence 
	extends inst_mem_responder_sequence;
	bit[2:0] dest_reg = 0;
	
	`uvm_object_utils( inst_mem_responder_branch_sequence )
	
	// pragma uvmf custom class_item_additional begin
	// pragma uvmf custom class_item_additional end
	
	function new(string name = "inst_mem_responder_branch_sequence");
	  super.new(name);
	endfunction
	
	task body();


		int j;
		`uvm_info("BR_JMP_SEQ",$sformatf("Running Branch and Jump instructions"),UVM_HIGH)
		`uvm_info("BR_JMP_SEQ",$sformatf("Initialising the registers::"),UVM_HIGH)
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
		end
		
		`uvm_info("BR_JMP_SEQ",$sformatf("Now Running Branch and JUMP::"),UVM_HIGH)
		
		repeat(50) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR, JMP}; }) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			finish_item(req);
			`uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
		end
		
		repeat(100) begin
		for(int i = 1 ; i < 8 ; i++) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[11:9] = i; 
			`uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[11:9] = i; 
			`uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end
		for(int i = 0 ; i < 8 ; i++) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {JMP};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:6] = i; 
			`uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {JMP};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			`uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end
		end

		`uvm_info("BR_JMP_SEQ",$sformatf("DONE"),UVM_HIGH)
	endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

