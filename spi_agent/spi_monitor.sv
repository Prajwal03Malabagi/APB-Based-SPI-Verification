class monitor extends uvm_monitor;
  `uvm_component_utils(monitor);
  uvm_analysis_port#(txs) mon_port;
	txs xtn;
  virtual intfs.MON vif;
  confs cfs;
  bit lsb;
  bit cpha,cpol;
  bit [7:0]ctrl;
  bit leading_is_pos;

  function new(string name="monitor",uvm_component parent);
    super.new(name,parent);
    mon_port=new("mon_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(confs)::get(this,"","For SPI",cfs))
      `uvm_fatal("monitor","mission failed in monitor SPI");
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfs.vifs;
  endfunction
  
  task run_phase(uvm_phase phase);
	$display("((*********************************************");
   forever begin
	 xtn=txs::type_id::create("xtn");

           mon();
//	$display($time);
      xtn.display("spi_driver ");			
	
    end
  endtask
  
  task mon();
		if(!uvm_config_db #(bit[7:0])::get(this,"","bit",ctrl))
			`uvm_fatal("monitor","config failed in sampling")
		lsb=ctrl[0];
		cpha=ctrl[2];
		cpol=ctrl[3];
		 
		$display("ss in monitor=%0d",vif.mon.ss);
		@(vif.mon);
		wait(!vif.mon.ss)
			$display("ss in monitor=%0d",vif.mon.ss);
		//	if(cpol)
				begin
    				if((cpol && cpha )||(!cpol && !cpha))    	
			    		@(posedge vif.mon.sclk) $display("monitor",$time);
   				else
    				    @(negedge vif.mon.sclk);
				end
			
			if(lsb)
			begin
				for(int i=0;i<=7;i++)
				begin
					if((cpol && cpha )||(!cpol && !cpha)) 
					begin
						@(posedge vif.mon.sclk);
					$display("mon",$time);	xtn.miso[i]=vif.mon.miso;
						$display("monitor1 miso[%0d]=%0d",i,xtn.miso[i]);
						xtn.mosi[i]=vif.mon.mosi;
						$display("monitor1 m_mosi[%0d]=%0d",i,xtn.mosi[i]);
						xtn.ss=vif.mon.ss; 
														
					end
					else
					begin
						@(negedge vif.mon.sclk);
						xtn.miso[i]=vif.mon.miso;
					//	$display("monitor miso[%0d]=%0d",i,xtn.miso[i]);
						xtn.mosi[i]=vif.mon.mosi;
					//		$display("monitor m_mosi[%0d]=%0d",i,xtn.mosi[i]);
						
						xtn.ss=vif.mon.ss;
					end
				end
			end
			else
			begin
				for(int i=7;i>=0;i--)
				begin
					if((cpol && cpha )||(!cpol && !cpha)) 	
					begin
						@(posedge vif.mon.sclk);
						xtn.miso[i]=vif.mon.miso;
						xtn.mosi[i]=vif.mon.mosi;
						xtn.ss=vif.mon.ss;
					end
					else
					begin
						@(negedge vif.mon.sclk);
						xtn.miso[i]=vif.mon.miso;
						xtn.mosi[i]=vif.mon.mosi;
						xtn.ss=vif.mon.ss;
					end
				end
			end 
			$display("++++++++++++++********************miso=%0d,mosi=%0d",xtn.miso,xtn.mosi);
			xtn.display("spi_monitor");

			@(posedge vif.mon.sclk);
		  mon_port.write(xtn);
		
	//	@(posedge vif.mon.sclk);
	endtask
endclass

