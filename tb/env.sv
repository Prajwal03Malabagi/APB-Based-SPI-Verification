class env extends uvm_env;
  `uvm_component_utils(env)
  
  conf cf;
  agentS ags[];
  agentA aga[];
  scoreboard scb;
 
  function new(string name="env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
		
    if(!uvm_config_db #(conf)::get(this,"","hi",cf))
      `uvm_fatal("env","mission failed in env")
   
    aga=new[cf.no_of_abp_agent];
    ags=new[cf.no_of_spi_agent];
    foreach(aga[i])
      aga[i]=agentA::type_id::create($sformatf("aga[%0d]",i),this);
    foreach(ags[i])
      ags[i]=agentS::type_id::create($sformatf("ags[%0d]",i),this);
	
   scb=scoreboard::type_id::create("scb",this);
   
  endfunction

  function void connect_phase(uvm_phase phase);
	foreach(aga[i])
		aga[i].mon.mon_port.connect(scb.fifo1.analysis_export);

		foreach(ags[i])
		ags[i].mon.mon_port.connect(scb.fifo2.analysis_export);

	endfunction
  
endclass

