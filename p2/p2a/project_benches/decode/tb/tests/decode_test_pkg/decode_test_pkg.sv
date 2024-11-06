package decode_test_pkg;
	import uvm_pkg::*;
        import uvmf_base_pkg::*;
        import uvmf_base_pkg_hdl::*;
	import decode_in_pkg::*;
        import decode_in_pkg_hdl::*;
        import decode_out_pkg::*;
        import decode_out_pkg_hdl::*;
        import decode_env_pkg::*;
        
	`include "uvm_macros.svh"
        `uvm_analysis_imp_decl(_d_in_bus)
        `uvm_analysis_imp_decl(_d_out_bus)
        `include "src/print_component.svh"
        `include "src/test_top.sv"
        

        //export uvmf_base_pkg_hdl::*;
        export uvmf_base_pkg_hdl::uvmf_sim_level_t;
        export uvmf_base_pkg_hdl::NA;
        export uvmf_base_pkg_hdl::SUB_BLOCK;
        export uvmf_base_pkg_hdl::BLOCK;
        export uvmf_base_pkg_hdl::SUB_MODULE;
        export uvmf_base_pkg_hdl::MODULE;
        export uvmf_base_pkg_hdl::SUB_CHIP;
        export uvmf_base_pkg_hdl::CHIP;
        export uvmf_base_pkg_hdl::CIRCUIT_CARD;
        export uvmf_base_pkg_hdl::SYSTEM;
        export uvmf_base_pkg_hdl::uvmf_active_passive_t;
        export uvmf_base_pkg_hdl::ACTIVE;
        export uvmf_base_pkg_hdl::PASSIVE;
        export uvmf_base_pkg_hdl::uvmf_master_slave_t;
        export uvmf_base_pkg_hdl::MASTER;
        export uvmf_base_pkg_hdl::SLAVE;
        export uvmf_base_pkg_hdl::INITIATOR;
        export uvmf_base_pkg_hdl::RESPONDER;
        export uvmf_base_pkg_hdl::UVMF_VIRTUAL_INTERFACES;
        export uvmf_base_pkg_hdl::UVMF_BFM_REFERENCES;
        export uvmf_base_pkg_hdl::UVMF_SEQUENCERS;
        export uvmf_base_pkg_hdl::UVMF_MONITORS;
        export uvmf_base_pkg_hdl::UVMF_CONFIGURATIONS;
        export uvmf_base_pkg_hdl::UVMF_AGENT_CONFIG;
        export uvmf_base_pkg_hdl::UVMF_CLOCK_APIS;
        export uvmf_base_pkg_hdl::UVMF_RESET_APIS;

endpackage
