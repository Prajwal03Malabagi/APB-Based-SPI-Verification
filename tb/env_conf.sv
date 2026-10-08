class conf extends uvm_object;
	`uvm_object_utils(conf)
	int num=1;

	bit has_apb_agent=1;
	bit has_spi_agent=1;
	int no_of_spi_agent=1;
	int no_of_abp_agent=1;
	bit has_scb=1;

	function new(string name="conf");
		super.new(name);
	endfunction
endclass
