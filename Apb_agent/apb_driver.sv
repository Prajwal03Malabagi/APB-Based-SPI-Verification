class drivera extends uvm_driver #(txa);
  `uvm_component_utils(drivera)
  virtual intfa.DRV vif;
  confa cfa;
  function new(string name="drivera",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(confa)::get(this,"","For APB",cfa))
      `uvm_fatal("driver","mission failed in driver APB");
//	$display("driver build");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfa.vifa;
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase); 
		@(vif.drva);
		vif.drva.preset<=1'b0;
		@(vif.drva); 
		vif.drva.preset<=1'b1;
    forever begin 
      seq_item_port.get_next_item(req);
     	drive(req);
      seq_item_port.item_done();
	req.display("apb_driver");
    end
  endtask
  
  task drive(txa req);
	
		@(vif.drva);
		vif.drva.psel<=1;
		vif.drva.penable<=0;
		vif.drva.paddr<=req.paddr_i;
		vif.drva.pwrite<=req.pwrite_i;
		if(req.pwrite_i)
		vif.drva.pwdata<=req.pwdata_i;

		@(vif.drva);
		vif.drva.penable<=1'b1; 

		wait(vif.drva.pready);
	if(!req.pwrite_i)
		 req.prdata_o=vif.drva.prdata;
		@(vif.drva);
		vif.drva.psel<=0;
		vif.drva.penable<=0;
	@(vif.drva);
			
  endtask
	
endclass


