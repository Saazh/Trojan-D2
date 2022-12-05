// Code your design here
`timescale 1ns/1ns
					
	
module dsram #(parameter m = 10, n = 32) 
	(input clk, w_en, rst,
	 //input [m-1:0] addr,
	 input [n-1:0] addr,
	 input [n-1:0] din,
	 output [n-1:0] d_out);

	parameter mem_size = 2**m; // 2^m
	reg [n-1:0] SRAM [0:mem_size-1]; // [0:((2^m)/2)-1] i_mem and [((2^m)/2): 2^m-1] d_mem
	integer i;
	
	always@(clk) begin
	   if (rst) begin
		  for (i = 0; i< mem_size; i=i+1)
		      SRAM[i] <= 32'b0;
		end      
		else if (w_en)
			SRAM[addr] <= din;	
	end
	
	assign d_out = SRAM[addr];

endmodule