class decode_scoreboard extends uvm_component;

  `uvm_component_utils(decode_scoreboard)

  //Instatiate two analysis exports for actual and expected decode stage
  `uvm_analysis_imp_decl(_expected)
  `uvm_analysis_imp_decl(_actual)
  
  uvm_analysis_imp_expected#(decode_out_transaction, decode_scoreboard) expected_ae;
  uvm_analysis_imp_actual#(decode_out_transaction, decode_scoreboard) actual_ae;

  //queue to store transactions received from expected analysis export
  decode_out_transaction expected_results_q[$];

  decode_out_transaction last_expected;
  decode_out_transaction last_actual;
  //decode_in_transaction instr;
  bit last_mismatched =0;
  
  //Variables to keep count of expected transaction recevied and comparisons made
  int transaction_count=0;
  int match_count=0;
  int mismatch_count=0;
  int nothing_to_compare_count=0;

  int report_variables[];
  string report_hdr = "SCOREBOARD REPORT: ";
  decode_out_transaction expected_transaction;

  function new(string name ="", uvm_component parent);
    super.new(name,parent);
    expected_ae = new("expected_ae",this);
    actual_ae = new("actual_ae", this);
  endfunction 

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  virtual function void write_expected (decode_out_transaction t);
    decode_out_transaction trans;
    trans = new("trans");
    trans.copy(t);
    transaction_count++;
    expected_results_q.push_back(trans);
    `uvm_info("SCBD", $sformatf("Expected transaction pushed into queue"),UVM_MEDIUM);
    t.print();
  endfunction

  virtual function void write_actual (decode_out_transaction t);
   if( expected_results_q.size() == 0) begin
     nothing_to_compare_count++;
     `uvm_error("SCBD", $sformatf("NO predicted entry to compare aganist"))
    end
    else begin
      expected_transaction = expected_results_q.pop_front();
      last_expected = expected_transaction;
      last_actual = t;
      `uvm_info("SCBD", $sformatf("Actual transaction "),UVM_MEDIUM);
      t.print();
      if(t.compare(expected_transaction)) begin
         match_count++;
         last_mismatched =0;
         `uvm_info("SCBD", "MATCH", UVM_MEDIUM)
         //`uvm_info("SCBD MATCH", $sformatf("EXPECTED_TRANSACTION: IR d_out: 0x%x, ACTUAL_TRANSACTION: Instruction d_in: 0x%x", expected_transaction.IR, t.IR),UVM_MEDIUM)
         //$display("[SCBD] EXPECTED_TRANSACTION: IR d_out: 0x%x, ACTUAL_TRANSACTION: Instruction d_in: 0x%x", expected_transaction.IR, last_actual.IR);
      end

      else begin
         mismatch_count++;
         last_mismatched=1;
         `uvm_error("SCBD","MISMATCH")
         //`uvm_error("SCBD MISMATCH", $sformatf("EXPECTED_TRANSACTION: IR d_out: 0x%x, ACTUAL_TRANSACTION: Instruction d_in: 0x%x", expected_transaction.IR, t.IR))
         //$display("[SCBD] EXPECTED_TRANSACTION: IR d_out: 0x%x, ACTUAL_TRANSACTION: Instruction d_in: 0x%x", expected_transaction.IR, last_actual.IR);
      end
    end
  endfunction

  virtual function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    report_variables ={transaction_count,nothing_to_compare_count, match_count, mismatch_count };
  endfunction

  virtual function string report_message(string header, int variables[]);
    string message;
    message = $sformatf("%s, PREDICTED_TRANSACTIONS=%0d, Nothing to Compare count=%0d, MATCH = %0d, MISMATCH= %0d", header, variables[0], variables[1], variables[2], variables[3]);
    return message;
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCBD", report_message(report_hdr, report_variables), UVM_MEDIUM)
  endfunction
  
endclass
