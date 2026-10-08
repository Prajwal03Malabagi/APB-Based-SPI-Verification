class seqS extends uvm_sequence #(txs);
  `uvm_object_utils(seqS);
  
  function new(string name="seqS");
    super.new(name);
  endfunction
  
  task body();
    repeat(1)
      begin
	req=txs::type_id::create("req");
        start_item(req);
        req.randomize();
        finish_item(req);
      end
  endtask
endclass


