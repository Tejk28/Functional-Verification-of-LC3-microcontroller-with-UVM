//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This test extends test_top and makes 
//    changes to test_top using the UVM factory type_override:
//
//    Test scenario: 
//      This is a template test that can be used to create future tests.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class st_test extends test_top;

  `uvm_component_utils( st_test );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    super.build_phase(phase);
    inst_mem_responder_sequence::type_id::set_type_override(inst_mem_responder_st_sequence::get_type());
    //set_type_override_by_type(inst_mem_responder_sequence::get_type(), imem_responder_alu_sequence::get_type());
	// Execute the build_phase of test_top AFTER all factory overrides have been created.
    //super.build_phase(phase);
  endfunction

endclass

