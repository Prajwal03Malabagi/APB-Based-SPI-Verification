class txs extends uvm_sequence_item;
	rand logic [7:0]miso;	
	logic sclk;
	logic ss;
	logic [7:0]mosi;
	
	`uvm_object_utils(txs)
  
  function new(string name="txs");
    super.new(name);
  endfunction
  
  function display(string mass);
	$display("class=%s,miso_i=%0d,mosi=%0d",mass,miso,mosi);
  endfunction
endclass

