class test extends uvm_test;
  `uvm_component_utils(test)
  env e;
  conf cf;
	confa cfa;
	confs cfs;
  bit has_apb_agent=1;
	bit has_spi_agent=1;
	int no_of_spi_agent=1;
	int no_of_abp_agent=1;
	bit has_scb=1;
//	bit [7:0]ctrl=8'b11110011;
  function new(string name="test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    cf=conf::type_id::create("cf");
	//	uvm_config_db #(bit[7:0])::set(this,"*","bit",ctrl);
		
    e=env::type_id::create("e",this);
	
		if(has_apb_agent)
			begin
					cfa=confa::type_id::create("cfa");
				if(!uvm_config_db #(virtual intfa)::get(this,"","For testa",cfa.vifa))
				  `uvm_fatal("test","mission failed at test")
				end
	if(has_spi_agent)begin
					cfs=confs::type_id::create("cfs");
				if(!uvm_config_db #(virtual intfs)::get(this,"","For tests",cfs.vifs))
				  `uvm_fatal("test","mission failed at test")
				end
	cf.has_apb_agent=has_apb_agent;
	cf.has_spi_agent=has_spi_agent;
	cf.no_of_spi_agent=no_of_spi_agent;
	cf.no_of_abp_agent=no_of_abp_agent;
	cf.has_scb=has_scb;
	uvm_config_db#(conf)::set(this,"*","hi",cf);
	uvm_config_db#(confa)::set(this,"*","For APB",cfa);
	uvm_config_db#(confs)::set(this,"*","For SPI",cfs);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
   
endclass

class seq_lsb_00_test extends test;
	 `uvm_component_utils(seq_lsb_00_test)
	function new(string name="seq_lsb_00_test",uvm_component parent);
    	super.new(name,parent);
  	endfunction
		
	seq_lsb_00 sa;	
	seqS spi_s;
	seq_read sa_apb;

	bit [7:0]ctrl=8'b11110011;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    		sa=seq_lsb_00::type_id::create("sa");
		spi_s=seqS::type_id::create("spi_s");
		sa_apb=seq_read::type_id::create("sa_apb");
		uvm_config_db #(bit[7:0])::set(this,"*","bit",ctrl);
  endfunction 

    task run_phase(uvm_phase phase);
 //   super.run_phase(phase);
    phase.raise_objection(this);
  //  for(int i=0;i<cf.num;i++)
      			sa.start(e.aga[0].sq);//#1000;//REGISTERS CONFIGURE
			spi_s.start(e.ags[0].sq);#500;
			//wait(cfs.vifs.ss);
			//#500;
			sa_apb.start(e.aga[0].sq);#200;// dr read
		
    phase.drop_objection(this);
  endtask
endclass

class seq_lsb_01_test extends test;
	 `uvm_component_utils(seq_lsb_01_test);
	function new(string name="seq_lsb_01_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_lsb_01 sa1;	
	seqS spi_s;
	seq_read sa_apb;

	bit [7:0]ctrl=8'b11110111;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
    sa1=seq_lsb_01::type_id::create("sa1");
   spi_s=seqS::type_id::create("spi_s");
//	wait(cfs.vifs.ss)
    sa_apb=seq_read::type_id::create("sa_apb");
	
		uvm_config_db #(bit[7:0])::set(this,"*","bit",ctrl);
	
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    //for(int i=0;i<cf.num;i++)begin
      sa1.start(e.aga[0].sq);//#100;
      spi_s.start(e.ags[0].sq);
			wait(cfs.vifs.ss);
		//	#10000;			
			sa_apb.start(e.aga[0].sq);#100;// dr read
		 $display($time,"after seq to seqr connection");

	//	end
    phase.drop_objection(this);
  endtask
endclass



class seq_lsb_10_test extends test;
	 `uvm_component_utils(seq_lsb_10_test);
	function new(string name="seq_lsb_10_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_lsb_10 sa10;
	seqS spi_s;
	seq_read sa_apb;
	bit [7:0]ctrl=8'b11111011;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    sa10=seq_lsb_10::type_id::create("sa10");
    spi_s=seqS::type_id::create("spi_s");
    sa_apb=seq_read::type_id::create("sa_apb");
	uvm_config_db #(bit[7:0])::set(this,"*","bit",ctrl);

  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
   // for(int i=0;i<cf.num;i++)begin
      sa10.start(e.aga[0].sq);
//	//	end
    	spi_s.start(e.ags[0].sq);
	wait(cfs.vifs.ss);	
//	#1000;		
			sa_apb.start(e.aga[0].sq);#100;// dr read
	//	 $display($time,"after seq to seqr connection");

    phase.drop_objection(this);
  endtask
endclass

class seq_lsb_11_test extends test;
	 `uvm_component_utils(seq_lsb_11_test);
	function new(string name="seq_lsb_11_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_lsb_11 sa11;
	seqS spi_s;
	seq_read sa_apb;
	bit [7:0]ctrl=8'b11111011;


	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
		sa11=seq_lsb_11::type_id::create("sa11");
		spi_s=seqS::type_id::create("spi_s");
		sa_apb=seq_read::type_id::create("sa_apb");
	uvm_config_db #(bit[7:0])::set(this,"*","bit",ctrl);

  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
  //  for(int i=0;i<cf.num;i++)begin
      sa11.start(e.aga[0].sq);
       spi_s.start(e.ags[0].sq);
			wait(cfs.vifs.ss);	
//	#1000;		
			sa_apb.start(e.aga[0].sq);#100;// dr read
		 $display($time,"after seq to seqr connection");

    phase.drop_objection(this);
  endtask
endclass

class seq_msb_00_test extends test;
	 `uvm_component_utils(seq_msb_00_test);
	function new(string name="seq_lsb_00_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_msb_00 sb;
	seqS spi_s;
	seq_read sa_apb;
	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    sb=seq_msb_00::type_id::create("sb");
		spi_s=seqS::type_id::create("spi_s");
		sa_apb=seq_read::type_id::create("sa_apb");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
   // for(int i=0;i<cf.num;i++)begin
      sb.start(e.aga[0].sq);
	//	end
		spi_s.start(e.ags[0].sq);
		//	wait(cfs.vifs.ss);	
	#400;		
			sa_apb.start(e.aga[0].sq);//#100;// dr read
    phase.drop_objection(this);
  endtask
endclass
  
class seq_msb_11_test extends test;
	 `uvm_component_utils(seq_msb_11_test);
	function new(string name="seq_lsb_11_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_msb_11 sb11;
	seqS spi_s;
	seq_read sa_apb;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	    
		sb11=seq_msb_11::type_id::create("sb11");
		spi_s=seqS::type_id::create("spi_s");
		sa_apb=seq_read::type_id::create("sa_apb");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
   // for(int i=0;i<cf.num;i++)begin
      sb11.start(e.aga[0].sq);
		//end
		spi_s.start(e.ags[0].sq);
			wait(cfs.vifs.ss);	
	//#1000;		
			sa_apb.start(e.aga[0].sq);//#100;// dr read
    phase.drop_objection(this);
  endtask
endclass

class seq_msb_01_test extends test;
	 `uvm_component_utils(seq_msb_01_test);
	function new(string name="seq_lsb_01_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_msb_01 sb1;
	seqS spi_s;
	seq_read sa_apb;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    sb1=seq_msb_01::type_id::create("sb1");
		spi_s=seqS::type_id::create("spi_s");
		sa_apb=seq_read::type_id::create("sa_apb");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    //for(int i=0;i<cf.num;i++)begin
      sb1.start(e.aga[0].sq);
		//end
		spi_s.start(e.ags[0].sq);
		//	wait(cfs.vifs.ss);	
	#1000;		
			sa_apb.start(e.aga[0].sq);#100;// dr read
    phase.drop_objection(this);
  endtask
endclass

class seq_msb_10_test extends test;
	 `uvm_component_utils(seq_msb_10_test);
	function new(string name="seq_lsb_10_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_msb_10 sb10;
	seqS spi_s;
	seq_read sa_apb;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    sb10=seq_msb_10::type_id::create("sb10");
		spi_s=seqS::type_id::create("spi_s");
		sa_apb=seq_read::type_id::create("sa_apb");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
   // for(int i=0;i<cf.num;i++)begin
      sb10.start(e.aga[0].sq);
		//end
		spi_s.start(e.ags[0].sq);
		//	wait(cfs.vifs.ss);	
	#1000;		
			sa_apb.start(e.aga[0].sq);#100;// dr read
    phase.drop_objection(this);
  endtask
endclass

class seq_wait_test extends test;
	 `uvm_component_utils(seq_wait_test);
	function new(string name="seq_wait_test",uvm_component parent);
    super.new(name,parent);
  endfunction

	seq_wait sb10;
	seqS spi_s;
	seq_read sa_apb;
	bit [7:0]ctrl=8'b11110011;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    sb10=seq_wait::type_id::create("sb10");
		spi_s=seqS::type_id::create("spi_s");
		sa_apb=seq_read::type_id::create("sa_apb");
		uvm_config_db #(bit[7:0])::set(this,"*","bit",ctrl);
		
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
   // for(int i=0;i<cf.num;i++)begin
      sb10.start(e.aga[0].sq);
		//end
		spi_s.start(e.ags[0].sq);
			wait(cfs.vifs.ss);	
//	#1000;		
			sa_apb.start(e.aga[0].sq);#100;// dr read
    phase.drop_objection(this);
  endtask
endclass
