interface intfs(input bit clk);
	logic sclk;
	logic ss;
	logic mosi;
	logic miso;
	logic spi_interrupt_request;

	clocking drvs@(posedge clk);
		default input #1 output #1;
		output miso;
		input mosi,ss,sclk;
	endclocking

	clocking mon@(posedge clk);
		default input #1 output #1;
		input miso;
		input ss;
		input mosi;
		input sclk;
	endclocking
	
	modport DRV(clocking drvs);
	modport MON(clocking mon);
endinterface
