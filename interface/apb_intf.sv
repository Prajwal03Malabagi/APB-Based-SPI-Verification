interface intfa(input logic clk);
	logic pclk;
	logic [2:0]paddr;
	logic pwrite;
	logic psel;
	logic penable;
	logic [7:0]pwdata;
	
	logic [7:0]prdata;
	logic pready;
	logic pslverr;
	logic preset;

	assign pclk=clk;

	clocking drva@(posedge pclk);
		default input #1 output #0;
		output preset;
		output paddr; 
		output pwrite;
		output psel;
		output penable;
		output pwdata;
		input pready;
		input prdata;
		input pslverr;
	endclocking

	clocking mona@(posedge pclk);
		default input #1 output #1;
		input paddr;
		input pwrite;
		input psel;
		input penable;
		input pwdata;
		input preset;
		input prdata;
		input pready;
		input pslverr;
	endclocking

	modport DRV(clocking drva);
	modport MON(clocking mona);

	property setup;
		@(posedge pclk) $rose(psel) |-> !penable;
	endproperty
	
	property enable;
		@(posedge pclk) $rose(psel) |=> penable;
	endproperty	
	
	property p1;
		@(posedge pclk) (psel && !penable) |-> (##[1:2]penable);
	endproperty
	
	property p2;
		@(posedge pclk) (psel && !penable) |-> psel until penable;
	endproperty
	
	property p3;
		@(posedge pclk) (penable) |-> ##[1:$]pready;
	endproperty
	
	property p4;
		@(posedge pclk) pready |=> (!penable && !pready);
	endproperty
	
	Setup: assert property (setup)
				`uvm_info("pass","setup",UVM_LOW)
			else
				`uvm_info("fail","setup",UVM_LOW)
	Enable: assert property (enable)
				`uvm_info("pass","enable",UVM_LOW)
			else
				`uvm_info("fail","enable",UVM_LOW)
	prp1 : assert property (p1)
				`uvm_info("pass","p1",UVM_LOW)
			else
				`uvm_info("fail","p1",UVM_LOW)
	prp2 : assert property (p2)
				`uvm_info("pass","p2",UVM_LOW)
			else
				`uvm_info("fail","p2",UVM_LOW)
	prp3 : assert property (p3)
			`uvm_info("pass","p3",UVM_LOW)
			else
				`uvm_info("fail","p3",UVM_LOW)
	prp4 : assert property (p4)
			`uvm_info("pass","p4",UVM_LOW)
			else
				`uvm_info("fail","p4",UVM_LOW)
endinterface
      

