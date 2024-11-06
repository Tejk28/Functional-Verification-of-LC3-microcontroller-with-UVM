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
class inst_mem_responder_br_ld_sequence 
	extends inst_mem_responder_sequence;
	bit[2:0] dest_reg = 0;
	
	`uvm_object_utils( inst_mem_responder_br_ld_sequence )
	
	// pragma uvmf custom class_item_additional begin
	// pragma uvmf custom class_item_additional end
	
	function new(string name = "inst_mem_responder_br_ld_sequence");
	  super.new(name);
	endfunction
	
	task body();


		int j;
		int k;
		`uvm_info("BR_JMP_LD_SEQ",$sformatf("Running Branch and Jump instructions"),UVM_HIGH)
		`uvm_info("BR_JMP_LD_SEQ",$sformatf("Initialising the registers::"),UVM_HIGH)
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
		
		`uvm_info("BR_JMP_LD_SEQ",$sformatf("Now Running Branch and JUMP::"),UVM_HIGH)
		
		repeat(100) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			j = req.instr_dout[8:0]; 
			`uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LD};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j; 
			`uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end

		repeat(100) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			j = req.instr_dout[5:0] + req.instr_dout[8:6]; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LDR};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end

		repeat(100) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			j = req.instr_dout[8:0]; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LDI};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end
		repeat(100) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			j = req.instr_dout[8:0]; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LEA};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end
		repeat(100) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {JMP};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			j = req.instr_dout[8:6]; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LDR};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:6] = j; 
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end
		repeat(100) begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {JMP};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LD, LDR, LDI , LEA};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end

		for(int i = 0 ; i < 8 ; i++)begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {ST, STR, STI};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			j = req.instr_dout[8:0];
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j;
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LD, LDR, LDI , LEA};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j;
			k = req.instr_dout[11:9];
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {AND, ADD, NOT};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:6] = k;
			req.instr_dout[3:0] = k;
			req.instr_dout[5] = 0;
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end
		for(int i = 0 ; i < 8 ; i++)begin
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {ST, STR, STI};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			j = req.instr_dout[8:0];
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {BR};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j;
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {LD, LDR, LDI , LEA};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:0] = j;
			k = req.instr_dout[11:9];
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
			req=inst_mem_transaction::type_id::create("req");
			start_item(req);
			if(!req.randomize() with { req.opcode inside {AND, ADD, NOT};}) `uvm_fatal("seq", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
			req.instr_dout[8:6] = k;
			req.instr_dout[5] = 1;
			`uvm_info("seq",$sformatf("processed txn: %s",req.convert2string()),UVM_HIGH)
			finish_item(req);
		end

		`uvm_info("BR_JMP_LD_SEQ",$sformatf("DONE"),UVM_HIGH)
	endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

