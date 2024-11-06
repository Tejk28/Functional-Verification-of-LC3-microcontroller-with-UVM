import uvm_pkg::*;
`include "uvm_macros.svh"

module hdl_top();


bit clk;
bit rst;
logic enable_decode;
logic [15:0] Instr_dout;
logic [15:0] npc_in;
logic [2:0]  psr;


decode_in_if vif();
                 // .clock(clk),
                 // .reset(rst),
                 // .Instr_dout(Instr_dout),
                 // .npc_in(npc_in),
                 // .psr(psr)

//clock generator
initial begin: clk_gen
	vif.clock =1'b0;
	forever begin
        #10ns; 
	vif.clock = ~vif.clock;
        end 
end: clk_gen

//reset generator
initial begin: rst_gen
	vif.reset =1'b1;
        #10ns;
        vif.reset = 1'b0;
	
end: rst_gen

decode_in_driver_bfm driver_bfm(vif);
decode_in_monitor_bfm monitor_bfm(vif);

initial begin
   uvm_config_db#(virtual decode_in_driver_bfm)::set(null,"*","driver_bfm",driver_bfm);
   uvm_config_db#(virtual decode_in_monitor_bfm)::set(null,"*","monitor_bfm",monitor_bfm);
end
endmodule
