class decode_in_monitor extends uvm_monitor;

   `uvm_component_utils(decode_in_monitor)

   uvm_analysis_port #(decode_in_transaction) analysis_port;
   virtual decode_in_monitor_bfm monitor_bfm;
   decode_in_transaction m_trans;        
   
   protected time time_stamp=0;	
   int transaction_viewing;
   int transaction_viewing_stream_h;
   
   function new(string name = "decode_in_monitor", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      analysis_port = new("analysis_port",this);
   
      if(!uvm_config_db #(virtual decode_in_monitor_bfm)::get(this, "", "monitor_bfm",monitor_bfm)) begin
         `uvm_fatal("MONITOR", "uvm_config_db #(virtual decode_in_monitor_bfm)::get cannot find virtual interface handle")
      end
      `uvm_info("MONITOR","INFO: Build Phase Complete", UVM_MEDIUM)

      //set_bfm_proxy_handle();
   endfunction
   
   virtual function void start_of_simulation_phase (uvm_phase phase);
     //if(transaction_viewing)
       transaction_viewing_stream_h = $create_transaction_stream({"..", get_full_name(),".","txn_stream"},"TVM");
     set_bfm_proxy_handle();
   endfunction
   
   virtual task run_phase(uvm_phase phase);
        ->monitor_bfm.go; 
   endtask
   
   virtual function void notify_transaction (
                                             input bit [15:0] npc_in,
                                             input logic [15:0] Instr_dout,
                                             input bit [2:0] psr,
                                             input bit       enable_decode
                                            );
      m_trans = new("m_trans");
      m_trans.start_time = time_stamp;
      m_trans.end_time = $time;
      time_stamp = m_trans.end_time;
      m_trans.npc_in = npc_in;
      m_trans.Instr_dout = Instr_dout;
      m_trans.psr = psr;
      m_trans.enable_decode =enable_decode;
  
      m_trans.add_to_wave(transaction_viewing_stream_h);
      analysis_port.write(m_trans);
      `uvm_info("MONITOR",{"Broadcasting signals:", m_trans.convert2string()}, UVM_MEDIUM)
       
   endfunction


   virtual function void set_bfm_proxy_handle();
     monitor_bfm.proxy = this;
   endfunction

endclass
