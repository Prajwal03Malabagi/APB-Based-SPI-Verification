class txa extends uvm_sequence_item;
	rand logic [2:0]paddr_i;
	rand logic pwrite_i;
	rand logic [7:0]pwdata_i;
  logic psel_i;
	logic penable_i;
	rand logic preset_n;

	logic [7:0]prdata_o;
	logic pready_o;
	logic pslverr_o;
  
  `uvm_object_utils(txa)
  
  function new(string name="txa");
    super.new(name);
  endfunction

	function void display(string mess);
		$display("--------------------------------------------");
		$display($time,"mess=%s\t \t,paddr_i=%0d,pwrite_i=%0d,pwdata_i=%0d,psel=%0d,penable=%0d,prdata_o=%0d,pready_o=%0d",mess,paddr_i,pwrite_i,pwdata_i,psel_i,penable_i,prdata_o,pready_o);
		
  endfunction

endclass

