class seqra extends uvm_sequencer #(txa);
  `uvm_component_utils(seqra)
  
  function new(string name="seqra",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass

