class decode_in_configuration extends uvm_object;

   `uvm_object_utils(decode_in_configuration)
 
   virtual decode_in_driver_bfm driver_bfm;
   virtual decode_in_monitor_bfm monitor_bfm;
   bit active_agent= 1'b1;
   bit coverage =1'b1;
   bit transaction_viewing;

   function new(string name ="decode_in_configuration");
      super.new(name);
   endfunction

  virtual function string convert2string();
     return $sformatf("Agent: %s, Coverage: %s, Transaction Viewing: %s", active_agent?"Active":"Passive", coverage?"Enabled":"Disabled", transaction_viewing?"Enabled":"Disabled");

  endfunction

endclass
