class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	
	uvm_tlm_analysis_fifo#(txa) fifo1;
	uvm_tlm_analysis_fifo#(txs) fifo2;
	txa t1;
	txs t2;
	txa apb_cov;
	txs spi_cov;

//	extern function new(string name="scoreboard",uvm_component parent);
	//extern task run_phase(uvm_phase phase);

	

	covergroup apb_covergroup;
		option.per_instance = 1;
		Reset : coverpoint apb_cov.preset_n { bins rst = {0,1};}
		
		Addr : coverpoint apb_cov.paddr_i { bins addr[] = {0,1,2,3,5};}
		
		Selx : coverpoint apb_cov.psel_i { bins sel = {0,1};}

		Enable : coverpoint apb_cov.penable_i { bins en = {0,1};}

		Write : coverpoint apb_cov.pwrite_i { bins wr[] = {0,1};}

		Ready : coverpoint apb_cov.pready_o { bins rdy = {0,1};}

		Error : coverpoint apb_cov.pslverr_o { bins err = {0,1};}
	
		Wdata : coverpoint apb_cov.pwdata_i {
						bins wdata_low = {[8'h00:8'hff]};
						}
		Rdata : coverpoint apb_cov.prdata_o {
 							bins rdata_low = {[8'h00:8'hff]};
						}

		//crosses
		Selx_Enable : cross Selx,Enable;
		Selx_Enable_Ready : cross Selx,Enable,Ready;
	endgroup
	covergroup spi_covergroup;
	//	option.per_instance = 1;
		Slave_select : coverpoint spi_cov.ss { bins ss = {0,1};}
		
		miso_data : coverpoint spi_cov.miso {
						bins miso_low = {[8'h00:8'hff]};
						}
		mosi_data : coverpoint spi_cov.mosi {
						bins mosi_low = {[8'h00:8'hff]};
						}	
	endgroup


	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		fifo1=new("fifo1",this);
		fifo2=new("fifo2",this);
		apb_covergroup=new;
		spi_covergroup=new;
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			fifo1.get(t1);
			apb_cov=new t1;
			apb_covergroup.sample();
			if(t1.pwrite_i && t1.paddr_i==3'b101) begin
				
				fifo2.get(t2);
				spi_cov=new t2;
				spi_covergroup.sample();
					
				if(t1.pwdata_i==t2.mosi)
					$display($time,"pass******************pwdata=%0d,mosi=%0d",t1.pwdata_i,t2.mosi);
				else 
					$display($time,"fail-----------------pwdata=%0d,mosi=%0d",t1.pwdata_i,t2.mosi);
			end
	
			if(!t1.pwrite_i && t1.paddr_i==3'b101) begin
					
				if(t1.prdata_o==t2.miso)
					$display($time,"pass******************prdata=%0d,miso=%0d",t1.prdata_o,t2.miso);
				else 
					$display($time,"fail**********----------------------------prdata=%0d,miso=%0d",t1.prdata_o,t2.miso);

			end
		end
	endtask
endclass
