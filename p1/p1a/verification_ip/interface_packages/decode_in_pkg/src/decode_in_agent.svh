class decode_in_agent extends uvm_agent;

   `uvm_component_utils(decode_in_agent)

   uvm_analysis_port #(decode_in_transaction) analysis_port;
   decode_in_configuration m_cfg;
   decode_in_driver d_handle;
   decode_in_monitor m_handle;
   decode_in_sequencer seq_handle;
   decode_in_coverage cov_inst;
   bit coverage;   
   bit active_agent;

   function new(string name="decode_in_agent", uvm_component parent= null);
      super.new(name,parent);
   endfunction


   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db #(decode_in_configuration)::get(this,"","m_cfg",m_cfg)) begin
       `uvm_fatal("decode_in_agent", "configuration not found");
     end

     active_agent = m_cfg.active_agent;
     coverage = m_cfg.coverage;    
     if(coverage) 
      cov_inst = decode_in_coverage::type_id::create("cov_inst",this);
      //create bfm handles with factory
      if(active_agent) begin
      seq_handle = decode_in_sequencer::type_id::create("seq_handle", this);
      d_handle = decode_in_driver::type_id::create("d_handle",this);
      d_handle.driver_bfm = m_cfg.driver_bfm;
     
      end
      m_handle = decode_in_monitor::type_id::create("m_handle",this);   
      m_handle.monitor_bfm = m_cfg.monitor_bfm;
   
      `uvm_info("INFO", "Message from Build phase of Agent", UVM_MEDIUM)
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      analysis_port = m_handle.analysis_port;
      if(active_agent) 
      d_handle.seq_item_port.connect(seq_handle.seq_item_export);
      if(coverage) 
      m_handle.analysis_port.connect(cov_inst.analysis_export);
      `uvm_info("INFO", "Message from Connect phase of Agent", UVM_MEDIUM)
   endfunction

endclass
