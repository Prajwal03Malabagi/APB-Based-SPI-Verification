 class agentA extends uvm_agent;
  `uvm_component_utils(agentA)
  seqra sq;
  drivera drv;
  monitora mon;
  confa cfa;
  
  function new(string name="agentA",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); 
    if(!uvm_config_db #(confa)::get(this,"","For APB",cfa))
      `uvm_fatal("agent","mission failed in agentA APB");
     mon=monitora::type_id::create("mon",this);
    if(cfa.is_active==UVM_ACTIVE)
      begin
        sq=seqra::type_id::create("sq",this);
        drv=drivera::type_id::create("drv",this);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(cfa.is_active==UVM_ACTIVE)
      drv.seq_item_port.connect(sq.seq_item_export);
  endfunction
endclass

