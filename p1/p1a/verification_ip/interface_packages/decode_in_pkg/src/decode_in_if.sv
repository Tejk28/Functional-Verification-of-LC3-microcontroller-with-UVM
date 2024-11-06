interface decode_in_if();

     bit clock;
     bit reset;
     logic [15:0] Instr_dout;
     logic [15:0] npc_in;
     logic [2:0]  psr;
     bit          enable_decode;

endinterface 
