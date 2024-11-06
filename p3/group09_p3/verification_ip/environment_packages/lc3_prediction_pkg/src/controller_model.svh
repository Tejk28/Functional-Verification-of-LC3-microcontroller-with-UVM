/*
   // The controller_model function models the behavior of the controller unit
   // The return value indicates model results status: 0 success, 1 failure
   function bit controller_model(input bit complete_data,
                             input bit complete_instr, 
                             input bit [15:0] IR, 
                             input bit [2:0] psr, 
                             input bit [15:0] IR_Exec, 
                             input bit [15:0] IMem_dout, 
                             input bit [2:0] NZP, 
                             output bit      enable_updatePC, 
                             output bit      enable_fetch, 
                             output bit      enable_decode, 
                             output bit      enable_execute, 
                             output bit      enable_writeback, 
                             output bit      bypass_alu_1, 
                             output bit      bypass_alu_2, 
                             output bit      bypass_mem_1, 
                             output bit      bypass_mem_2, 
                             output bit [2:0]   mem_state, 
                             output bit br_taken
                         );


static bit memstateLDI = 1'b0;
static bit memstateSTI = 1'b0;
static bit enable_flag = 1'b0;
static bit br_enable_flag = 1'b0;
static bit branch_mode = 1'b0;

//default values
		   bypass_alu_1=0;
		   bypass_alu_2=0;
		   bypass_mem_1=0;
		   bypass_mem_2=0;

// Logic for mem state

	 if(memstateLDI==1)
	   begin
	      mem_state=2'b00;
	      memstateLDI=0;
	   end
	 else if(memstateSTI==1)
	   begin
	      mem_state=2'b10;
	      memstateSTI=0;
	   end
	 else if((IR[15:12]== STR)||(IR[15:12]== ST))
	   begin
	      mem_state=2'b10;
	   end
	 else if((IR[15:12]==LDR)||(IR[15:12]==LD))
	   begin
	      mem_state=2'b00;
	   end
	 else if(IR[15:12]==LDI)
	   begin
	      mem_state=2'b01;
	      memstateLDI=1;
	   end
	 else if(IR[15:12]==STI)
	   begin
	      mem_state=2'b01;
	      memstateSTI=1;
	   end
    else 
    begin
	    mem_state=2'b11;
    end

	 //MOST IMPORTANT STAGE : Handle with care.......
	 //3 copies of the same instruction at different times is available to use...IMEM out, IR out from decode and IR out from execute stage.....
	 // Use this to determine the dependencies and hence generate the bypass alu1 and bypass alu2 instructions from it............

	 // IR, IR_EXec and 
    if((IR[15:12]==ADD)||(IR[15:12]==AND)||(IR[15:12]==NOT))
    begin
        if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
        begin
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_alu_1=1;
		   if(IR_Exec[11:9]==IR[2:0])
		     bypass_alu_2=1;
		   if(IR[5]==1)
		     bypass_alu_2=0;
		end
	      
        if((IR_Exec[15:12]==LD)||(IR_Exec[15:12]==LDR)||(IR_Exec[15:12]==LDI))
		begin
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_mem_1=1;
		   if(IR_Exec[11:9]==IR[2:0])
		     bypass_mem_2=1;
		   if(IR[5]==1)
		     bypass_mem_2=0;
		end
	end

	if(IR[15:12]==LDR)
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		    begin
		        if(IR_Exec[11:9]==IR[8:6])
		         bypass_alu_1=1;
		    end		
	   end

	 if(IR[15:12]==STR)
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		begin
		   
		   if(IR_Exec[11:9]==IR[11:9])
		     bypass_alu_2=1;
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_alu_1=1;
		end		
	  end
	 
      if((IR[15:12]==ST) || (IR[15:12]==STI))
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		begin
		   if(IR_Exec[11:9]==IR[11:9])
		     bypass_alu_2=1;
		end		
	  end

      if(IR[15:12]==JMP)
	   begin
	      if((IR_Exec[15:12]==ADD)||(IR_Exec[15:12]==AND)||(IR_Exec[15:12]==NOT)||(IR_Exec[15:12]==LEA))
		begin
		   if(IR_Exec[11:9]==IR[8:6])
		     bypass_alu_1=1;
		end		
	  end

	 //+++++++++++++++++++++++++  Enable signals +++++++++++++++++++++++++++++++++


    case (enable_flag)
        0 : 
        begin
            enable_flag = 0;
	        if((IR_Exec[15:12]==LD) || (IR_Exec[15:12]==LDR) || (IR_Exec[15:12]==ST) || (IR_Exec[15:12]==STR))
            begin
                enable_flag = 2;
	            if((IR_Exec[15:12]==ST) || (IR_Exec[15:12]==STR))
                begin
                    enable_flag = 3;
                end
            end
            else if ((IR_Exec[15:12]==LDI) || (IR_Exec[15:12]==STI))
            begin
                enable_flag = 4;
	            if(IR_Exec[15:12]==STI)
                begin
                    enable_flag = 5;
                end
            end
        end
        1 : 
        begin
            enable_flag = 0;
        end
        2 : 
        begin
            enable_flag = 0;
        end
        3 : 
        begin
            enable_flag = 1;
        end
        4 : 
        begin
            enable_flag = 2;
        end
        5 : 
        begin
            enable_flag = 3;
        end
        default : 
        begin
            enable_flag = 0;
        end
    endcase
    
    case (enable_flag)
        0 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
        end
        1 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=0;
		       enable_updatePC=1;
        end
        2,3,4,5 :
        begin
		       enable_fetch=0;
		       enable_decode=0;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=0;
        end
        default : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
        end
    endcase


    case (br_enable_flag)
        0 : 
        begin
            if ((IMem_dout[15:12]==BR) || (IMem_dout[15:12]==JMP))
            br_enable_flag = 1;
        end
        1 : 
        begin
            br_enable_flag = 2;
        end
        2 : 
        begin
            br_enable_flag = 3;
        end
        3 : 
        begin
            br_enable_flag = 4;
        end
        4 : 
        begin
            if ((IMem_dout[15:12]==BR) || (IMem_dout[15:12]==JMP))
            br_enable_flag = 5;
        end
        5 : 
        begin
            br_enable_flag = 6;
        end
        6 : 
        begin
            br_enable_flag = 0;
        end
        default : 
        begin
            br_enable_flag = 0;
        end
    endcase

    case (br_enable_flag)
        0 : 
        begin
           if (branch_mode == 1)
            begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
               br_taken = 0;
               branch_mode = 0;
            end
        end
        1 : 
        begin
		       enable_fetch=0;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=0;
               br_taken = 0;
               branch_mode = 1;
        end
        2 : 
        begin
		       enable_fetch=0;
		       enable_decode=0;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=0;
               br_taken = 0;
        end
        3 : 
        begin
		       enable_fetch=0;
		       enable_decode=0;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=0;
            if (IR[15:12]==JMP)
            begin
               br_taken = 1'b1;
	       enable_updatePC= 1'b1;
            end
            else
            begin
               br_taken = (psr & NZP) ? 1'b1 : 1'b0;
               enable_updatePC = (psr & NZP) ? 1'b1 : 1'b0;
           end
        end
        4 : 
        begin
		       enable_fetch=1;
		       enable_decode=0;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=1;
               br_taken = 0;
        end
        5 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=0;
		       enable_writeback=0;
		       enable_updatePC=1;
               br_taken = 0;
        end
        6 : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=0;
		       enable_updatePC=1;
               br_taken = 0;
        end
        default : 
        begin
		       enable_fetch=1;
		       enable_decode=1;
		       enable_execute=1;
		       enable_writeback=1;
		       enable_updatePC=1;
               br_taken = 0;
        end
    endcase


         return (0);
   endfunction*/








function void decode_lc3_insn
  (
    input bit [15:0] insn,
    output decoded_insn_t decode_insn
  );

  decode_insn.opcode = opcode_t'(insn[15:12]);

  case (decode_insn.opcode)

    ADD, AND: begin
      decode_insn.optype = ALU;
      decode_insn.mod_cf = 1;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = 1;
      decode_insn.use_sr2 = !insn[5];
      decode_insn.use_imm = insn[5];
      decode_insn.dr = insn[11:9];
      decode_insn.sr1 = insn[8:6];
      decode_insn.sr2 = insn[2:0];
      decode_insn.imm_ext = {{11{insn[4]}}, insn[4:0]};
    end

    NOT: begin
      decode_insn.optype = ALU;
      decode_insn.mod_cf = 1;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = 1;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 0;
      decode_insn.dr = insn[11:9];
      decode_insn.sr1 = insn[8:6];
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = 0;
    end

    BR: begin
      decode_insn.optype = CONTROL;
      decode_insn.mod_cf = 0;
      decode_insn.use_cf = 1;
      decode_insn.use_dr = 0;
      decode_insn.use_sr1 = 0;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 1;
      decode_insn.dr = insn[11:9];
      decode_insn.sr1 = 0;
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = {{7{insn[8]}}, insn[8:0]};
    end

    JMP: begin
      decode_insn.optype = CONTROL;
      decode_insn.mod_cf = 0;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 0;
      decode_insn.use_sr1 = 1;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 0;
      decode_insn.dr = 0;
      decode_insn.sr1 = insn[8:6];
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = {{7{insn[8]}}, insn[8:0]};
    end

    /*JSR: begin
      decode_insn.optype = CONTROL;
      decode_insn.mod_cf = 0;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = !insn[11];
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = insn[11];
      decode_insn.dr = 3'd7;
      decode_insn.sr1 = insn[8:6];
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = {{5{insn[10]}}, insn[10:0]};
    end*/

    LD, LDI: begin
      decode_insn.optype = MEMORY;
      decode_insn.mod_cf = 1;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = 0;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 1;
      decode_insn.dr = insn[11:9];
      decode_insn.sr1 = 0;
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = {{7{insn[8]}}, insn[8:0]};
    end

    LDR: begin
      decode_insn.optype = MEMORY;
      decode_insn.mod_cf = 1;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = 1;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 1;
      decode_insn.dr = insn[11:9];
      decode_insn.sr1 = insn[8:6];
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = {{10{insn[5]}}, insn[5:0]};
    end

    LEA: begin
      decode_insn.optype = ALU;
      decode_insn.mod_cf = 1;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = 0;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 1;
      decode_insn.dr = insn[11:9];
      decode_insn.sr1 = 0;
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = {{7{insn[8]}}, insn[8:0]};
    end

    /*RTI: begin
      decode_insn.optype = PRIVILEGE;
      decode_insn.mod_cf = 0;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = 0;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 0;
      decode_insn.dr = 3'd6;
      decode_insn.sr1 = 0;
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = 0;
    end*/

    ST, STI: begin
      decode_insn.optype = MEMORY;
      decode_insn.mod_cf = 0;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 0;
      decode_insn.use_sr1 = 0;
      decode_insn.use_sr2 = 1;
      decode_insn.use_imm = 1;
      decode_insn.dr = 0;
      decode_insn.sr1 = 0;
      decode_insn.sr2 = insn[11:9];
      decode_insn.imm_ext = {{7{insn[8]}}, insn[8:0]};
    end

    STR: begin
      decode_insn.optype = MEMORY;
      decode_insn.mod_cf = 0;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 0;
      decode_insn.use_sr1 = 1;
      decode_insn.use_sr2 = 1;
      decode_insn.use_imm = 1;
      decode_insn.dr = 0;
      decode_insn.sr1 = insn[8:6];
      decode_insn.sr2 = insn[11:9];
      decode_insn.imm_ext = {{7{insn[8]}}, insn[8:0]};
    end

    /*TRAP: begin
      decode_insn.optype = PRIVILEGE;
      decode_insn.mod_cf = 0;
      decode_insn.use_cf = 0;
      decode_insn.use_dr = 1;
      decode_insn.use_sr1 = 0;
      decode_insn.use_sr2 = 0;
      decode_insn.use_imm = 1;
      decode_insn.dr = 3'd7;
      decode_insn.sr1 = 0;
      decode_insn.sr2 = 0;
      decode_insn.imm_ext = {{8{1'b0}}, insn[7:0]};
    end*/

    /*RESERVED: begin
      assert(0);
    end*/

  endcase;

endfunction : decode_lc3_insn

// The controller_model function models the behavior of the controller unit
// The return value indicates model results status: 0 success, 1 failure
function bit controller_model
  (
    input bit complete_data,
    input bit complete_instr,
    input bit [15: 0] IR,
    input bit [2: 0] psr,
    input bit [15: 0] IR_Exec,
    input bit [15: 0] IMem_dout,
    input bit [2: 0] NZP,
    output bit enable_updatePC,
    output bit enable_fetch,
    output bit enable_decode,
    output bit enable_execute,
    output bit enable_writeback,
    output bit bypass_alu_1,
    output bit bypass_alu_2,
    output bit bypass_mem_1,
    output bit bypass_mem_2,
    output bit [1: 0] mem_state,
    output bit br_taken
  );

  typedef enum bit[2: 0] {
            MEM_STATE_INIT = 3'b011,
            MEM_STATE_RD = 3'b000,
            MEM_STATE_WR = 3'b010,
            MEM_STATE_RD_IND = 3'b001,
            MEM_STATE_WR_IND = 3'b101
          } mem_st_t;

  /*
  *
  * What are the FE1 and FE2 stage?
  *
  * The entire Fetch stage is actually comprised by two sub stage:
  *   - Fetch 1: Generating next PC using signals enable_updatePC and br_taken
  *   - Fetch 2: Requesting Instruction from IMem at the PC generated by Fetch 1
  *
  * This is because the IMem has at least one cycle delay
  *
  */
  static bit has_been_reset = 0;
  static bit fe1_out_valid = 0;
  static bit fe2_out_valid = 0;
  static bit dec_out_valid = 0;
  static bit exe_out_valid = 0;
  static mem_st_t mem_state_internal = MEM_STATE_INIT;

  bit next_fe1_out_valid;
  bit next_fe2_out_valid;
  bit next_dec_out_valid;
  bit next_exe_out_valid;

  bit is_pipeline_mem_stall;
  bit is_pipeline_has_branch;
  bit is_branch_taken;
  bit is_branch_resolved;
  bit is_insn_need_wtb;

  decoded_insn_t insn_fe2_out;
  decoded_insn_t insn_dec_out;
  decoded_insn_t insn_exe_out;

  //*********** Generate internal control signals ****************************//
  // The validity of FE2 output is determined by the last cycle's fe1_out_valid
  // and this cycle's complete_instr, so we must update it before any other
  // internal logic using it
  fe2_out_valid = fe2_out_valid & complete_instr;

  // Decode the instruction in different stage
  decode_lc3_insn(IMem_dout, insn_fe2_out);
  decode_lc3_insn(IR, insn_dec_out);
  decode_lc3_insn(IR_Exec, insn_exe_out);

  is_branch_taken = 0;
  is_branch_resolved = 0;
  is_insn_need_wtb = 0;
  // Post-Execution behavior
  if (exe_out_valid) begin
    // - For all instructions that needs writeback stage
    is_insn_need_wtb = insn_exe_out.use_dr;

    // - For Control-type instruction
    if (insn_exe_out.optype == CONTROL) begin
      // Control-type instruction will use its writeback cycle to update the
      // new fetch PC (which is maintained in the FE1 stage)
      is_branch_taken = (psr & NZP) != 0;
      is_branch_resolved = 1;
    end

    // - For Memory-type instruction
    case (mem_state_internal)
      MEM_STATE_INIT: begin
        if ((insn_exe_out.opcode == LDR) || ( insn_exe_out.opcode == LD )) begin
          mem_state_internal = MEM_STATE_RD;
        end
        else if ((insn_exe_out.opcode == STR) || (insn_exe_out.opcode == ST)) begin
          mem_state_internal = MEM_STATE_WR;
        end
        else if (insn_exe_out.opcode == LDI) begin
          mem_state_internal = MEM_STATE_RD_IND;
        end
        else if (insn_exe_out.opcode == STI) begin
          mem_state_internal = MEM_STATE_WR_IND;
        end
      end

      MEM_STATE_RD: begin
        if (complete_data) begin
          mem_state_internal = MEM_STATE_INIT;
        end
      end

      MEM_STATE_WR: begin
        if (complete_data) begin
          mem_state_internal = MEM_STATE_INIT;
        end
      end

      MEM_STATE_RD_IND: begin
        if (complete_data) begin
          mem_state_internal = MEM_STATE_RD;
        end
      end

      MEM_STATE_WR_IND: begin
        if (complete_data) begin
          mem_state_internal = MEM_STATE_WR;
        end
      end

      default:
        assert(0);

    endcase
  end

  // When the MEM stage is activated, the entire pipeline is frozen.
  is_pipeline_mem_stall = mem_state_internal != MEM_STATE_INIT;
  // Is a control-type instruction get into the pipeline, the pipeline will
  // keep fetching bubbles until the branch target is resolved
  is_pipeline_has_branch = (
                           (fe2_out_valid && insn_fe2_out.optype == CONTROL) ||
                           (dec_out_valid && insn_dec_out.optype == CONTROL) ||
                           (exe_out_valid && insn_exe_out.optype == CONTROL)
                         );
  // Befoe the branch is resolved, the PC output of FE1 stage is invalid
  next_fe1_out_valid = is_pipeline_mem_stall ? fe1_out_valid :
                       (!is_pipeline_has_branch || is_branch_resolved);
  // If there is a branch in the pipeline, the pipeline should stop fetching
  // new instruction from the IMem immediately
  next_fe2_out_valid = is_pipeline_mem_stall ? fe2_out_valid :
                       (!is_pipeline_has_branch && fe1_out_valid);
  next_dec_out_valid = is_pipeline_mem_stall ? dec_out_valid : fe2_out_valid;
  next_exe_out_valid = is_pipeline_mem_stall ? exe_out_valid : dec_out_valid;


  //*********** Generate Pipeline stage control signal ***********************//
  br_taken         = !is_pipeline_mem_stall && is_branch_taken;
  enable_updatePC  = has_been_reset &&
                     !is_pipeline_mem_stall && (!is_pipeline_has_branch || is_branch_taken);
  enable_fetch     = !has_been_reset ||
                     !is_pipeline_mem_stall && next_fe2_out_valid;
  enable_decode    = !is_pipeline_mem_stall && next_dec_out_valid;
  enable_execute   = !is_pipeline_mem_stall && next_exe_out_valid;
  enable_writeback = !is_pipeline_mem_stall && is_insn_need_wtb;
  mem_state        = mem_state_internal[1: 0];

  //*********** Generate Pipeline data bypass sigal **************************//
  bypass_alu_1 = 0;
  bypass_alu_2 = 0;
  bypass_mem_1 = 0;
  bypass_mem_2 = 0;

  if (insn_exe_out.use_dr) begin
    if (insn_dec_out.use_sr1 && (insn_dec_out.sr1 == insn_exe_out.dr))
      if (insn_exe_out.optype == MEMORY)
        bypass_mem_1 = 1;
      else
        bypass_alu_1 = 1;
    if (insn_dec_out.use_sr2 && (insn_dec_out.sr2 == insn_exe_out.dr))
      if (insn_exe_out.optype == MEMORY)
        bypass_mem_2 = 1;
      else
        bypass_alu_2 = 1;
  end

  //*********** Update valid information for next prediction *****************//
  fe1_out_valid = next_fe1_out_valid;
  fe2_out_valid = next_fe2_out_valid;
  dec_out_valid = next_dec_out_valid;
  exe_out_valid = next_exe_out_valid;

  has_been_reset = 1;

  return (0);
endfunction


