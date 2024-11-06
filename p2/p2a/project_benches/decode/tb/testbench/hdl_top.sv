import uvm_pkg::*;
import uvmf_base_pkg::*;
`include "uvm_macros.svh"

module hdl_top();


bit clk;
bit rst;
wire        enable_decode;
wire [15:0] dout;
wire [15:0] npc_in;
wire [1:0] W_Control;
wire [5:0] E_Control;
wire [15:0] IR;
wire [15:0] npc_out;
wire Mem_Control;



//clock generator
initial begin: clk_gen
	clk =1'b0;
	forever begin
        #10ns; 
	clk = ~clk;
        end 
end: clk_gen

//reset generator
initial begin: rst_gen
	rst =1'b1;
        #10ns;
        rst = 1'b0;
	
end: rst_gen

decode_in_if d_in_bus(.clock(clk), .reset(rst), .enable_decode(enable_decode), .dout(dout), .npc_in(npc_in));

decode_out_if d_out_bus(.clock(clk), .reset(rst), .W_Control(W_Control), .E_Control(E_Control), .IR(IR), .npc_out(npc_out), .Mem_Control(Mem_Control));

Decode DUT(.clock(clk), .reset(rst), .enable_decode(d_in_bus.enable_decode), .dout(d_in_bus.dout), .E_Control(d_out_bus.E_Control), .Mem_Control(d_out_bus.Mem_Control), .W_Control(d_out_bus.W_Control), .npc_in(d_in_bus.npc_in), .IR(d_out_bus.IR), .npc_out(d_out_bus.npc_out));

decode_in_driver_bfm driver_bfm(d_in_bus);
decode_in_monitor_bfm monitor_bfm(d_in_bus);
decode_out_driver_bfm d_out_driver_bfm(d_out_bus);
decode_out_monitor_bfm d_out_monitor_bfm(d_out_bus);

initial begin
   uvm_config_db#(virtual decode_in_if)::set(null,UVMF_VIRTUAL_INTERFACES,"d_in_bus",d_in_bus);
   uvm_config_db#(virtual decode_in_driver_bfm)::set(null,UVMF_VIRTUAL_INTERFACES,"d_in_bus",driver_bfm);
   uvm_config_db#(virtual decode_in_monitor_bfm)::set(null,UVMF_VIRTUAL_INTERFACES,"d_in_bus",monitor_bfm);
   uvm_config_db#(virtual decode_out_if)::set(null,UVMF_VIRTUAL_INTERFACES,"d_out_bus",d_out_bus);
   uvm_config_db#(virtual decode_out_driver_bfm)::set(null,UVMF_VIRTUAL_INTERFACES,"d_out_bus", d_out_driver_bfm);
   uvm_config_db#(virtual decode_out_monitor_bfm)::set(null,UVMF_VIRTUAL_INTERFACES,"d_out_bus", d_out_monitor_bfm);
end
endmodule
