module Top;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import pkg::*;
  bit clk;
	  
  intfa vifa(clk);
  intfs vifs(clk);
  top dut(vifa.clk,vifa.preset,vifa.paddr,vifa.pwrite,vifa.psel,vifa.penable,vifa.pwdata,vifs.miso,vifs.ss,vifs.sclk,vifs.spi_interrupt_request,vifs.mosi,vifa.prdata,vifa.pready,vifa.pslverr);
 	always #5 clk=~clk;
  initial begin
    clk=0;
    `ifdef VCS
         	$fsdbDumpvars(0, Top);
	`endif
    uvm_config_db #(virtual intfa)::set(null,"*","For testa",vifa);
		uvm_config_db #(virtual intfs)::set(null,"*","For tests",vifs);
    run_test();
		$display("---------------top after-----------------------");
  end
endmodule

