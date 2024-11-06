class decode_in_random_sequence extends uvm_sequence#(decode_in_transaction);
   
   `uvm_object_utils(decode_in_random_sequence)
   decode_in_transaction req;

   function new(string name ="decode_in_random_sequence");
      super.new(name);
   endfunction
   
   
   virtual task body();
      req = new("req");
      `uvm_info("SEQUENCE", "Requesting to send transaction to driver", UVM_MEDIUM)
       start_item(req);
       if(!req.randomize()) begin
           `uvm_fatal("SEQ", "decode_in_random_sequence::body()- randomized failied")
       end
       `uvm_info("SEQUNENCE", {"Sending transaction to Driver",req.convert2string()} , UVM_MEDIUM)
       finish_item(req);
       `uvm_info("SEQUENCE", {"Recieved transaction from Driver", req.convert2string()}, UVM_MEDIUM)
      
   endtask
endclass
