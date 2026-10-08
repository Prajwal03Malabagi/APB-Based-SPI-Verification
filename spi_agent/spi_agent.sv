class agentS extends uvm_agent;
  `uvm_component_utils(agentS);
  seqr sq;
  driver drv;
  monitor mon;
  confs cfs;
  
  function new(string name="agentS",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); 
    
	if(!uvm_config_db #(confs)::get(this,"","For SPI",cfs))
      	`uvm_fatal("agent","mission failed in agentS SPI");
     	mon=monitor::type_id::create("mon",this);
   
	 if(cfs.is_active==UVM_ACTIVE)
     	 begin
       	 sq=seqr::type_id::create("sq",this);
         drv=driver::type_id::create("drv",this);
     	 end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(cfs.is_active==UVM_ACTIVE)
      drv.seq_item_port.connect(sq.seq_item_export);
  endfunction
endclass
