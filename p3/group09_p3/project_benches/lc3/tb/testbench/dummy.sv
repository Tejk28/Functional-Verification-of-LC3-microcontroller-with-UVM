fetch_in_if bus_in (.clock(clock), .reset(rst), .enable_updatePC(dut_lc3.enable_updatePC), .enable_fetch(dut_lc3.enable_fetch), .taddr(dut_lc3.taddr), .br_taken(dut_lc3.br_taken));
fetch_out_if bus_out (.clock(clock), .reset(rst), .npc(dut_lc3.npc), .pc(dut_lc3.pc), .instrmem_rd(dut_lc3.instrmem_rd), .enable_fetch(dut_lc3.enable_fetch));

assign bus_out.enable_fetch=bus_in.enable_fetch;

control_in_if control_in_if_inst(
                                      .clock(clock),
                                      .reset(rst),
                                      .complete_data(dut_lc3.complete_data),
                                      .complete_instr(dut_lc3.complete_instr), 
                                      .IR(dut_lc3.IR), 
                                      .NZP(dut_lc3.NZP), 
                                      .psr(dut_lc3.psr), 
                                      .IR_Exec(dut_lc3.IR_Exec), 
                                      .IMem_dout(dut_lc3.IMem_dout)
    );

control_out_if control_out_if_inst(
                                       .clock(clock), 
                                       .reset(rst), 
                                       .enable_updatePC(dut_lc3.enable_updatePC), 
                                       .enable_fetch(dut_lc3.enable_fetch), 
                                       .enable_decode(dut_lc3.enable_decode), 
                                       .enable_execute(dut_lc3.enable_execute), 
                                       .enable_writeback(dut_lc3.enable_writeback), 
                                       .br_taken(dut_lc3.br_taken), 
                                       .bypass_alu_1(dut_lc3.bypass_alu_1), 
                                       .bypass_alu_2(dut_lc3.bypass_alu_2), 
                                       .bypass_mem_1(dut_lc3.bypass_mem_1), 
                                       .bypass_mem_2(dut_lc3.bypass_mem_2), 
                                       .mem_state(dut_lc3.mem_state)
									   
									   
decode_in_if my_if(
                        .clock(clk),
                        .reset(rst),
                        .npc_in(dut_lc3.npc_in),
                        .enable_decode(dut_lc3.enable_decode),
                        .instr_dout(dut_lc3.instr_dout)
    );

decode_out_if my_out_if(
                        .clock(clk),
                        .reset(rst),
                        .W_control(dut_lc3.W_Control),
                        .Mem_Control(dut_lc3.Mem_Control),
                        .E_Control(dut_lc3.E_Control),
                        .IR(dut_lc3.IR),
                        .npc_out(dut_lc3.npc_out)
						
						
						
execute_in_if execute_in_if(.clock(clock) , 
				    .reset(rst) ,
				    .enable_execute(dut_lc3.enable_execute) , 
				    .W_Control_in(dut_lc3.W_Control_in), 
				    .Mem_Control_in(dut_lc3.Mem_Control_in), 
				    .E_Control(dut_lc3.E_Control),
				    .IR(dut_lc3.IR),
				    .npc(dut_lc3.npc),
				    .VSR1(dut_lc3.VSR1),
				    .VSR2(dut_lc3.VSR2),
				    .Mem_Bypass_Val(dut_lc3.Mem_Bypass_Val),
				    .bypass_alu_1(dut_lc3.bypass_alu_1),
				    .bypass_alu_2(dut_lc3.bypass_alu_2),
				    .bypass_mem_1(dut_lc3.bypass_mem_1),
				    .bypass_mem_2(dut_lc3.bypass_mem_2));
	
execute_out_if execute_out_if(.clock(clock) , 
				      .reset(rst) , 
				      .enable_execute(dut_lc3.enable_execute) , 
				      .aluout(dut_lc3.aluout), 
		    		      .pcout(dut_lc3.pcout), 
		    		      .W_Control_out(dut_lc3.W_Control_out), 
		    		      .Mem_Control_out(dut_lc3.Mem_Control_out), 
		    		      .NZP(dut_lc3.NZP), 
		    		      .IR_Exec(dut_lc3.IR_Exec),
		    		      .sr1(dut_lc3.sr1), 
		    		      .sr2(dut_lc3.sr2), 
		    		      .dr(dut_lc3.dr), 
		    		      .M_Data(dut_lc3.M_Data));
						  
						  
						  
						  
inst_mem_if  inst_mem_agent_bus(
     // pragma uvmf custom inst_mem_agent_bus_connections begin
     .clock(clk), .reset(rst), .PC(dut_lc3.pc), .instrmem_rd(dut_lc3.instrmem_rd), .instr_dout(dut_lc3.instr_dout), .complete_instr(dut_lc3.complete_instr)
     // pragma uvmf custom inst_mem_agent_bus_connections end
     );
data_mem_if  data_mem_agent_bus(
     // pragma uvmf custom data_mem_agent_bus_connections begin
     .clock(clk), .reset(rst), .Data_dout(dut_lc3.data_dout), .Data_din(dut_lc3.data_din), .Data_rd(dut_lc3.data_rd), .Data_addr(dut_lc3.data_addr), .complete_data(dut_lc3.complete_data)
     // pragma uvmf custom data_mem_agent_bus_connections end
     );
	 
	 
  memaccess_in_if memaccess_in_if_vif(.clock(clock),.reset(rst),.mem_state(dut_lc3.mem_state),.M_Data(dut_lc3.M_Data),.M_Addr(dut_lc3.M_Addr),.DMem_dout(dut_lc3.DMem_dout),.M_Control(dut_lc3.M_Control));


   memaccess_out_if memaccess_out_if_vif(.clock(clock),.reset(rst),.DMem_addr(dut_lc3.DMem_addr),.DMem_rd(dut_lc3.DMem_rd),.DMem_din(dut_lc3.DMem_din),.memout(dut_lc3.memout));

   
   
writeback_in_if writeback_in_if_inst(
                    .clock(clock),
                    .reset(rst),
                    .enable_writeback(dut_lc3.enable_writeback),
                    .aluout(dut_lc3.aluout),
                    .W_Control_in(dut_lc3.W_Control),
                    .memout(dut_lc3.memout),
                    .pcout(dut_lc3.pcout),
                    .npc(dut_lc3.npc),
                    .sr1(dut_lc3.sr1),
                    .sr2(dut_lc3.sr2),
                    .dr(dut_lc3.dr)
        );


writeback_out_if writeback_out_if_inst(
                    .clock(clock),
                    .reset(rst),
                    .VSR1(dut_lc3.VSR1),
                    .VSR2(dut_lc3.VSR2),
                    .psr(dut_lc3.psr)
        );