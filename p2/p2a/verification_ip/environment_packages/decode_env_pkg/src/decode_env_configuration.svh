class decode_env_configuration extends uvm_object;

  `uvm_object_utils(decode_env_configuration)

  //Instaniate the decode model
  //decode_model decode_model;
  
  decode_in_configuration d_in_config;
  decode_out_configuration d_out_config;
 
 
  function new(string name ="");
    super.new(name);
    //d_in_config = new("d_in_config");
    d_in_config = decode_in_configuration::type_id::create("d_in_config");
    //d_out_config = new("d_out_config");
    d_out_config = decode_out_configuration::type_id::create("d_out_config");


  endfunction  

  virtual function string convert2string();
    return {
             "\n", d_in_config.convert2string,
             "\n", d_out_config.convert2string
           };
  endfunction

 function void initialize( uvmf_active_passive_t interface_activity_in,         
                           uvmf_active_passive_t interface_activity_out,
                           string env_in_agent_path,         
                           string env_out_agent_path,
                           string interface_names_in,
                           string interface_names_out
                         );

   //super.initialize(environment_path, interface_names,interface_activity);

   d_in_config.initialize(interface_activity_in, env_in_agent_path, interface_names_in);
   d_in_config.initiator_responder = INITIATOR;
   d_out_config.initialize(interface_activity_out, env_out_agent_path, interface_names_out);
   d_out_config.initiator_responder = RESPONDER;
   
 endfunction

endclass
