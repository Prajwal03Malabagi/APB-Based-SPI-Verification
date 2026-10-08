class monitora extends uvm_monitor;
  `uvm_component_utils(monitora)
  uvm_analysis_port#(txa) mon_port;
	txa t;
  virtual intfa.MON vif;
  confa cfa;
  
  function new(string name="monitora",uvm_component parent);
    super.new(name,parent);
    mon_port=new("mon_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(confa)::get(this,"","For APB",cfa))
      `uvm_fatal("monitor","mission failed in monitor APB");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfa.vifa;
  endfunction
  
  task run_phase(uvm_phase phase);
	t=txa::type_id::create("t");
   forever
		 begin
            mon();
			t.display("apb_monitor");
	//	$display("---------------------pwrite=%0d pready=%0d,pwdata=%0d, prdata=%0d-------------",t.pwrite_i,t.pready_o,t.pwdata_i,t.prdata_o);
    end
  endtask
  
  task mon();
		@(vif.mona);
		wait(vif.mona.penable && vif.mona.pready);
	//	@(vif.mona);
		t.preset_n=vif.mona.preset;
		t.paddr_i=vif.mona.paddr;
		t.pwrite_i=vif.mona.pwrite;
		t.penable_i=vif.mona.penable;
		t.psel_i=vif.mona.psel; 
    // @(vif.mona);  //time 65
	
		if(t.pwrite_i)
			t.pwdata_i=vif.mona.pwdata;
		else begin
			t.prdata_o=vif.mona.prdata;end
		t.pready_o=vif.mona.pready;
		t.pslverr_o=vif.mona.pslverr;
		mon_port.write(t);
 repeat(1)	@(vif.mona);
	  endtask
endclass

