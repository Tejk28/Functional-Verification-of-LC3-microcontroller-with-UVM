class decode_in_driver extends uvm_driver #(decode_in_transaction);
   `uvm_component_utils(decode_in_driver)
   
   virtual decode_in_driver_bfm driver_bfm;

   function new( string  name="", uvm_component parent=null);
      super.new(name,parent);
   endfunction

   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual decode_in_driver_bfm)::get(this, "", "driver_bfm", driver_bfm)) begin
         `uvm_fatal("CFG", "uvm_config_db #(virtual decode_in_driver_bfm)::get cannot find virtual interface handle")
      end
      `uvm_info("DRIVER","INFO: Build Phase Complete", UVM_MEDIUM) 
   endfunction
 
   virtual task	run_phase(uvm_phase phase);
   forever
      begin: forever_loop
       //decode_in_transaction req;
       seq_item_port.get_next_item(req);
       driver_bfm.driver_enable(req.Instr_dout,req.npc_in, req.psr, req.enable_decode);
       `uvm_info("Driver", "Sending transaction back to sequence through sequencer", UVM_MEDIUM)
       seq_item_port.item_done();
   end: forever_loop
   endtask
endclass
