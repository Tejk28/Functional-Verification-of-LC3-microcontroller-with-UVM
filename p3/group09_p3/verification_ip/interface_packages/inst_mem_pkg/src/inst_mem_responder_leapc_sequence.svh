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
class inst_mem_responder_leapc_sequence extends inst_mem_responder_sequence ;

	`uvm_object_utils( inst_mem_responder_leapc_sequence )
	
	bit[2:0] dest_reg = 0;
	// pragma uvmf custom class_item_additional begin
	// pragma uvmf custom class_item_additional end
	
	function new(string name = "inst_mem_responder_leapc_sequence");
		super.new(name);
	endfunction
	
	task body();
		`uvm_info("LEAPC_SEQ",$sformatf("Running LEA woth PC offsets instructions"),UVM_HIGH)
		`uvm_info("LEAPC_SEQ",$sformatf("Initialising the registers::"),UVM_HIGH)

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
		

		`uvm_info("LEA_SEQ",$sformatf("Now Running Loads ::"),UVM_HIGH)
		
		for(int i = 0 ; i < 512 ; i++) begin
		  req=inst_mem_transaction::type_id::create("req");
		  start_item(req);
		  if(!req.randomize() with {req.opcode inside {LEA};}) `uvm_fatal("SEQ", "inst_mem_random_sequence::body()-inst_mem_transaction randomization failed")
		  req.instr_dout[8:0] = i;
		  finish_item(req);
		  `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
		end
	endtask

endclass
