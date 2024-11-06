class decode_in_transaction extends uvm_sequence_item;

   bit clock, reset;
   rand bit enable_decode;
   bit [15:0] npc_in = 16'h3000;
   rand logic [15:0] Instr_dout;
   rand logic [2:0]  psr;
   time start_time, end_time;

   int transaction_view_h;
  
   constraint accepted_value { Instr_dout[15:12] inside {1, 5, 9, 14}; }
 
   function new(string name="decode_in_transaction");
      super.new(name);
   endfunction

   virtual function string convert2string();
      return $sformatf("Instr_dout =0x%0h, npc_in =0x%0h, psr =0x%0h, enable_decode = 0x%0b", Instr_dout, npc_in, psr, enable_decode);
   endfunction
   
   virtual function void add_to_wave(int transaction_viewing_stream_h);
    //if(transaction_view_h == 0)
    transaction_view_h = $begin_transaction(transaction_viewing_stream_h, "Trasanction", start_time);
    $add_attribute (transaction_view_h, Instr_dout, "Instr_dout");
    $add_attribute (transaction_view_h, npc_in, "npc_in");
    $add_attribute (transaction_view_h, psr, "psr");
    $end_transaction(transaction_view_h, end_time);
    $free_transaction(transaction_view_h);
    
   endfunction

endclass
