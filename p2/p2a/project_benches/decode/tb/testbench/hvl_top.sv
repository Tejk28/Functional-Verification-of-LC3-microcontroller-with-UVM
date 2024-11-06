import uvm_pkg::*;
import uvmf_base_pkg::*;
import decode_in_pkg::*;
import decode_out_pkg::*;
import decode_test_pkg::*;
`include "uvm_macros.svh"

module hvl_top();

    initial begin
       run_test("test_top");
    end

endmodule
