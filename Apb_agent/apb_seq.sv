class seqA extends uvm_sequence #(txa);
  `uvm_object_utils(seqA)
  
  function new(string name="seqA");
    super.new(name);
		$display("entering seq base");	
  endfunction
endclass

// For Read operation
class seq_read extends seqA;
	`uvm_object_utils(seq_read)

  function new(string name="seq_read");
    super.new(name);
  endfunction
	
  task body();
	//	super.body();
		repeat(1)begin 
				req=txa::type_id::create("req");

        start_item(req);				
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b0;}); // DR READ
        finish_item(req);
		end
	endtask
endclass

// Postive TestCase
// For Lsb=1 
class seq_lsb_00 extends seqA;
`uvm_object_utils(seq_lsb_00)

  function new(string name="seq_lsb_00");
    super.new(name);
  endfunction
	
  task body();
		
		repeat(1)begin 
	req=txa::type_id::create("req");
 
	start_item(req);				
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b011;req.pwrite_i==1'b0;}); //CR 1
        finish_item(req);


        start_item(req);				
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b000;req.pwdata_i==8'b11110011 ;req.pwrite_i==1'b1;}); //CR 1
        finish_item(req);
				
				
				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b001;req.pwdata_i==8'b00011000;req.pwrite_i==1'b1;}); //CR 2
				finish_item(req);
		
	
				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00010001;req.pwrite_i==1'b1;}); // BR
        finish_item(req);

			
				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;}); // DR
				finish_item(req);
		end
  endtask
endclass

class seq_lsb_01 extends seqA;
`uvm_object_utils(seq_lsb_01)
  
  function new(string name="seq_lsb_01");
    super.new(name);
  endfunction

  task body();
     repeat(1)begin
	req=txa::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b11110111;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b00011000;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
		end
  endtask
endclass

class seq_lsb_10 extends seqA;
`uvm_object_utils(seq_lsb_10)
  
  function new(string name="seq_lsb_10");
    super.new(name);
  endfunction

  task body();
      repeat(1) begin
	
	req=txa::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b11111011;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b00011000;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
			end
  endtask
endclass

class seq_lsb_11 extends seqA;
`uvm_object_utils(seq_lsb_11)
  
  function new(string name="seq_lsb_11");
    super.new(name);
  endfunction

  task body();
      repeat(1) begin
	req=txa::type_id::create("req");

				start_item(req);				
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwrite_i==1'b0;}); //CR 1
        finish_item(req);			

        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b11111111;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b00011000;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
			end
  endtask
endclass

//For Lsb=0

class seq_msb_00 extends seqA;
`uvm_object_utils(seq_msb_00)
  
  function new(string name="seq_msb_00");
    super.new(name);
  endfunction

  task body();
      repeat(1) begin
			req=txa::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b00010010;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b0000000;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
			end
  endtask
endclass

class seq_msb_01 extends seqA;
`uvm_object_utils(seq_msb_01)
  
  function new(string name="seq_msb_01");
    super.new(name);
  endfunction

  task body();
			repeat(1) begin
      req=txa::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b00010110;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b0000000;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
			end
  endtask
endclass

class seq_msb_10 extends seqA;
`uvm_object_utils(seq_msb_10)
  
  function new(string name="seq_msb_10");
    super.new(name);
  endfunction

  task body();
      repeat(1) begin
				req=txa::type_id::create("req");
        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b00011010;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b0000000;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
			end
  endtask
endclass

class seq_msb_11 extends seqA;
`uvm_object_utils(seq_msb_11)
  
  function new(string name="seq_msb_11");
    super.new(name);
  endfunction

  task body();
      repeat(1) begin

			req=txa::type_id::create("req");

				start_item(req);				
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b011;req.pwrite_i==1'b0;}); //CR 1
        finish_item(req);
			
			
				
        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b11111110;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b0000000;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
			end
  endtask
endclass

// For Negative TestCase (Low power mode)

class seq_wait extends seqA;
`uvm_object_utils(seq_wait)
  
  function new(string name="seq_wait");
    super.new(name);
  endfunction

  task body();
      repeat(1) begin

			req=txa::type_id::create("req");

				start_item(req);				
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b011;req.pwrite_i==1'b0;}); //CR 1
        finish_item(req);
				
        start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b0;req.pwdata_i==8'b11111111;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b1;req.pwdata_i==8'b0000010;req.pwrite_i==1'b1;});
				finish_item(req);

				start_item(req);
        assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b010;req.pwdata_i==8'b00000001;req.pwrite_i==1'b1;});
        finish_item(req);

				start_item(req);
				assert(req.randomize() with {req.preset_n==1'b1; req.paddr_i==3'b101;req.pwrite_i==1'b1;});
				finish_item(req);
			end
  endtask
endclass

