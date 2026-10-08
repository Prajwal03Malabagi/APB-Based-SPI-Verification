class driver extends uvm_driver #(txs);
  `uvm_component_utils(driver)
	confs cfs;
	virtual intfs.DRV vifs;
  bit[7:0] ctrl;
  bit cpha;
  bit cpol;
  bit lsb;

  function new(string name="driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
		if(!uvm_config_db#(confs)::get(this,"","For SPI",cfs))
				  `uvm_fatal("test","mission failed at test")
  endfunction
  function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			vifs=cfs.vifs;
	endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done(); 
	$display($time);
      req.display("spi_driver ");			
    end
  endtask
  
 task drive(txs req);
		if(!uvm_config_db #(bit[7:0])::get(this,"","bit",ctrl))
			`uvm_fatal("driver","spi_driver error")
		lsb=ctrl[0];
		cpha=ctrl[2];
		cpol=ctrl[3];
		@(vifs.drvs);
		$display("------------------------hi ss=%0d",vifs.drvs.ss); 
		wait(!vifs.drvs.ss)
		begin //@(vifs.drvs);
			$display("-----------------hi ss=%0d",vifs.drvs.ss);
	//	$display("inside slave driver");
			if(lsb)
			begin
				if((!cpha) && (!cpol))
				begin
					vifs.drvs.miso<=req.miso[0];
						$display("spi driver",$time);
					for(int i=1;i<=7;i++)
					begin
					@(negedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
					//	$display("miso[%0d]=%0d",i,req.miso[i]);
					end
					
				end
				
				else if((!cpha) && (cpol))
				begin
					 vifs.drvs.miso<=req.miso[0];
					//	$display("driver miso[0]=%0d",req.miso[0]);
					for(int i=1;i<=7;i++)
					begin
					@(posedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
				//		$display("driver miso[%0d]=%0d",i,req.miso[i]);
					end
				end

				else if((cpha) && (!cpol))
				begin //@(posedge vifs.drvs.sclk);//added extra
					for(int i=0;i<=7;i++)
					begin
					@(posedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
					end
				end

				else
				begin
					for(int i=0;i<=7;i++)
					begin
					@(negedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
					end
				end
			end

			else
			begin
				if((!cpha) && (!cpol))
				begin
					vifs.drvs.miso<=req.miso[7];
					for(int i=6;i>=0;i--)
					begin
					@(negedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
					end
				end
				
				else if((!cpha) && (cpol))
				begin
					vifs.drvs.miso<=req.miso[7];
					for(int i=6;i>=0;i--)
					begin
					@(posedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
					end
				end

				else if((cpha) && (!cpol))
				begin
					for(int i=7;i>=0;i--)
					begin
					@(posedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
					end
				end

				else
				begin
					for(int i=7;i>=0;i--)
					begin
					@(negedge vifs.drvs.sclk)
						vifs.drvs.miso<=req.miso[i];
					end
				end
			end
		end
		//@(negedge vifs.drvs.sclk);
	endtask


endclass

