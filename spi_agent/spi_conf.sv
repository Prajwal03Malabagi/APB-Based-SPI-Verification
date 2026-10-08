class confs extends uvm_object;
	`uvm_object_utils(confs)

	virtual intfs vifs;	
	uvm_active_passive_enum is_active=UVM_ACTIVE;

	function new(string name="confs");
		super.new(name);
	endfunction
endclass
