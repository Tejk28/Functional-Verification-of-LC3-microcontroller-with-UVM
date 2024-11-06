interface decode_in_driver_bfm(decode_in_if vif);

  bit clk;
  bit rst;


  task driver_enable(input bit [15:0] Instr_dout,
                     input bit [15:0] npc_in,
                     input bit [2:0]  psr,
                     input bit        enable_decode
                    );
       //#5ns;
      @(posedge vif.clock);
       vif.Instr_dout <= Instr_dout;
       vif.npc_in <= npc_in;
       vif.psr <= psr;
       vif.enable_decode <= enable_decode;

  endtask
endinterface
