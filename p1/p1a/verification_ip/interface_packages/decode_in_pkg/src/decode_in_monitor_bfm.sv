interface decode_in_monitor_bfm (decode_in_if vif);

decode_in_pkg::decode_in_monitor proxy;

   // Task wait_for_rest called in configuration 

   task wait_for_reset();
     wait(vif.reset == 0);
     //$display("DEBUG: wait_for_rest task called from monitor_bfm");
   endtask   

  task do_monitor(
                   output bit [15:0] Instr_dout,
                   output bit [15:0] npc_in,
                   output bit [2:0] psr,
                   output bit       enable_decode
                                      
                 );
   
     @(posedge vif.clock)
     begin
       Instr_dout = vif.Instr_dout;
       npc_in = vif.npc_in;
       psr = vif.psr;
     end

  endtask

  // Event go 
  event go;

  initial begin
    @go;
    wait_for_reset();
    forever begin
      bit [15:0] Instr_dout;
      bit [15:0] npc_in;
      bit [2:0]  psr;
      bit        enable_decode;
 
      do_monitor (
                  Instr_dout,
                  npc_in,
                  psr,
                  enable_decode
                 );
    
       
      proxy.notify_transaction(
                              npc_in,
                              Instr_dout,
                              psr,
                              enable_decode
                               );
    
    end
  end

 
endinterface 
