class confa extends uvm_object;
	`uvm_object_utils(confa)

	virtual intfa vifa;	
	uvm_active_passive_enum is_active=UVM_ACTIVE;

	function new(string name="confa");
		super.new(name);
	endfunction
endclass
