// Code your design here
`timescale 1ns/1ns
		
module prepherial_datapath_tb ();
	parameter mem_size = 1024;
	parameter n = 8;
	parameter itr8 = 8, itr= mem_size/4;
	integer i,j;
	
	reg [n-1:0] ROM [0:mem_size-1];
	reg [n-1:0] ROM_cell;

	reg clk_tb = 0, rst_tb = 0, enable_tb = 0, in_data_tb;
	reg p2s_enable_tb = 0, p2s_load_tb = 0;
	wire p2s_ser_out_tb, p2s_valid_tb;
	
	prepherial_datapath p_d_dut (clk_tb, rst_tb, enable_tb, in_data_tb, p2s_enable_tb, p2s_load_tb, p2s_ser_out_tb, p2s_valid_tb);
	
	always #4 clk_tb = ~clk_tb;
	
	initial $readmemh("binary_code.mem", ROM);
	initial begin
		rst_tb = 1; 
		//p2s_load_tb = 1;
		#15;
		rst_tb = 0;
		//p2s_load_tb = 0;
		@(posedge clk_tb);
		for (i =0; i<itr; i = i+1) begin
		//repeat (itr) begin
		  ROM_cell = ROM[i];
		  //repeat (itr8) begin
		  for (j =0; j<itr8; j = j+1) begin
		  	in_data_tb = ROM_cell[j];
		  	enable_tb = 1; 
		  	@(posedge clk_tb);
		  end
		  @(posedge clk_tb);
		end
		@(posedge clk_tb);
		@(posedge clk_tb);
		enable_tb = 0; //starting CPU
		
		@(posedge clk_tb); //capturing ALU 
		p2s_load_tb = 1;
		@(posedge clk_tb);
		p2s_load_tb = 0;
		p2s_enable_tb =1; 
		@(posedge clk_tb);
		
		#33468;		
		$display("time=%0t, imem= %0p", $time, p_d_dut.isram_dut.ISRAM);
		$display("time=%0t, REG= %0p", $time, p_d_dut.DUT_rv32i.DUT_data_path.reg_file.REG);
        //$display("time=%0t, ROM= %0p", $time, p_d_dut.DUT_data_path.inst_mem.ROM);
        #1000;
		$stop;
	end
	
endmodule

    // random inst generator
	//initial begin
	//	rst_tb = 1; #15
	//	rst_tb = 0;
	//	@(posedge clk_tb);
	//	
	//	repeat (itr) begin
	//	  repeat (itr8) begin
	//	  	in_data_tb = $random;
	//	  	enable_tb = 1; 
	//	  	@(posedge clk_tb);
	//	  end
	//	  @(posedge clk_tb);
	//	end
	//	@(posedge clk_tb);
	//	@(posedge clk_tb);
	//	enable_tb = 0; 
	//	
	//	#100;		
	//	$display("time=%0t, REG= %0p", $time, p_d_dut.isram_dut.ISRAM);
    //    //$display("time=%0t, ROM= %0p", $time, p_d_dut.DUT_data_path.inst_mem.ROM);
	//	$stop;
	//end
			


