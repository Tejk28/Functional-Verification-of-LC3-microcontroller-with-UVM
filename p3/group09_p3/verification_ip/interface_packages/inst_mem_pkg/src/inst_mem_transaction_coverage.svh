//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records inst_mem transaction information using
//       a covergroup named inst_mem_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class inst_mem_transaction_coverage  extends uvm_subscriber #(.T(inst_mem_transaction ));

  `uvm_component_utils( inst_mem_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup inst_mem_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    //opcode: coverpoint coverage_trans.opcode;
    //sr1: coverpoint coverage_trans.sr1;
    //sr2: coverpoint coverage_trans.sr2;
    //dr: coverpoint coverage_trans.dr;
    //mode: coverpoint coverage_trans.mode;
    //baser: coverpoint coverage_trans.baser;
    //pcoffset9: coverpoint coverage_trans.pcoffset9;
    //pcoffset6: coverpoint coverage_trans.pcoffset6;
    //imm5: coverpoint coverage_trans.imm5;
    //nzp: coverpoint coverage_trans.nzp;
    PC: coverpoint coverage_trans.PC
	{
		bins PC_random = {[0:$]};
	}	
    instrmem_rd: coverpoint coverage_trans.instrmem_rd;
    //instr_dout: coverpoint coverage_trans.instr_dout;
    complete_instr: coverpoint coverage_trans.complete_instr;
    // pragma uvmf custom covergroup end
  endgroup

  covergroup arithematic_operation;               //covergroup for ALU operations
   
    alu_opcode: coverpoint  coverage_trans.instr_dout[15:12]     //coverpoint for covering ALU operations (and,add,not)
    {
        bins op_add= {1};
        bins op_and= {5};
        bins op_not= {9};
    }
    dest_reg: coverpoint  coverage_trans.instr_dout[11:9] iff (( coverage_trans.instr_dout[15:12] == 4'h1) || (  coverage_trans.instr_dout[15:12] == 4'h5) || (  coverage_trans.instr_dout[15:12] == 4'h9));   
    src1_reg: coverpoint  coverage_trans.instr_dout[8:6] iff (( coverage_trans.instr_dout[15:12] == 4'h1) || ( coverage_trans.instr_dout[15:12] == 4'h5) || ( coverage_trans.instr_dout[15:12] == 4'h9));  
    imm_bit: coverpoint  coverage_trans.instr_dout[5] iff (( coverage_trans.instr_dout[15:12] == 4'h1) || ( coverage_trans.instr_dout[15:12] == 4'h5));
    src2_reg: coverpoint  coverage_trans.instr_dout[2:0] iff (( coverage_trans.instr_dout[5] == 0) && (( coverage_trans.instr_dout[15:12] == 4'h1) || ( coverage_trans.instr_dout[15:12] == 4'h5)));

    imm5_field: coverpoint  coverage_trans.instr_dout[4:0] iff (( coverage_trans.instr_dout[5] == 1'b1) && (( coverage_trans.instr_dout[15:12] == 4'h1) || ( coverage_trans.instr_dout[15:12] == 4'h5)))
    {
  		bins zero_to_31= {[0:31]};
    }

  endgroup
  
  covergroup memory_operation;
  
    mem_opcode: coverpoint coverage_trans.instr_dout[15:12] 
    {
        bins op_ld = {2};
        bins op_ldr = {6};
        bins op_ldi = {4'ha};
        bins op_lea = {4'he};
        bins op_st = {3};
        bins op_str = {7};
        bins op_sti = {4'hb};
    }
  
  
    dest_reg_mem: coverpoint  coverage_trans.instr_dout[11:9] iff (( coverage_trans.instr_dout[15:12] == 4'h2) || (  coverage_trans.instr_dout[15:12] == 4'h6) || (  coverage_trans.instr_dout[15:12] == 4'ha)|| (  coverage_trans.instr_dout[15:12] == 4'he));   
    src_reg_mem: coverpoint  coverage_trans.instr_dout[11:9] iff (( coverage_trans.instr_dout[15:12] == 4'h3) || (  coverage_trans.instr_dout[15:12] == 4'h7) || (  coverage_trans.instr_dout[15:12] == 4'hb));       
	base_r_reg_mem :  coverpoint  coverage_trans.instr_dout[8:6] iff (( coverage_trans.instr_dout[15:12] == 4'h6) || (  coverage_trans.instr_dout[15:12] == 4'h7)); 

    pcOffset_6_reg_mem :  coverpoint  coverage_trans.instr_dout[5:0] iff (( coverage_trans.instr_dout[15:12] == 4'h6) || (  coverage_trans.instr_dout[15:12] == 4'h7))
    {
        bins zero_to_63 = {[0:63]};
    }
    
    pcOffset_9_reg_mem :  coverpoint  coverage_trans.instr_dout[8:0] iff (( coverage_trans.instr_dout[15:12] == 4'h2) || (  coverage_trans.instr_dout[15:12] == 4'ha)|| ( coverage_trans.instr_dout[15:12] == 4'he) || (  coverage_trans.instr_dout[15:12] == 4'h3) || (  coverage_trans.instr_dout[15:12] == 4'hb))
    {
       	bins zero_to_511= {[0:511]};
    }

  endgroup
  
  
  covergroup control_operation;
  
    con_opcode :coverpoint coverage_trans.instr_dout[15:12] 
    {
        bins op_br = {0};
        bins op_jmp = {4'b1100};
    }
    
    NZP_reg : coverpoint coverage_trans.instr_dout[11:9] iff (coverage_trans.instr_dout[15:12] == 0)
    {
        ignore_bins zero_zero_zero = {3'b000};
    }

    pc_control_9 : coverpoint coverage_trans.instr_dout[8:0] iff (coverage_trans.instr_dout[15:12] == 0)
    {
        bins zero_to_511_control = {[0:511]};
    }

    base_r_control : coverpoint coverage_trans.instr_dout[8:6] iff (coverage_trans.instr_dout[15:12] == 4'b1100);

  endgroup
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    inst_mem_transaction_cg	= new;
    arithematic_operation	= new;
    memory_operation		= new;
    control_operation		= new;
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    inst_mem_transaction_cg.set_inst_name($sformatf("inst_mem_transaction_cg_%s",get_full_name()));
    arithematic_operation.set_inst_name($sformatf("arithematic_operation_%s",get_full_name()));
    memory_operation.set_inst_name($sformatf("memory_operation_%s",get_full_name()));
    control_operation.set_inst_name($sformatf("control_operation_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    inst_mem_transaction_cg.sample();
    arithematic_operation.sample();
    memory_operation.sample();
    control_operation.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

