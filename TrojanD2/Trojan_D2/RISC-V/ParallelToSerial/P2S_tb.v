`timescale 1ns/1ns
	
module p2s_tb #(parameter n = 32)();
	reg clk = 0, enable, load;
	reg [n-1:0] par_in;
	wire ser_out;
	wire valid;

	p2s DUT (clk, enable, load,par_in,ser_out,valid);
		
	always #4 clk = !clk;
	
	initial begin
		load = 0;
		enable = 0;
		#12
		load = 1;
		par_in = $random;
		#5
		load = 0;
		@(posedge clk);
		enable = 1;
	
		#1000;
		enable = 0;
		@(posedge clk);
		@(posedge clk);
		
		$display ("valid =%p , par_in = %b", valid, par_in);
		$stop;
	end
		
endmodule

