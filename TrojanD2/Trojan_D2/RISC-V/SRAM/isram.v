// Code your design here
`timescale 1ns/1ns
		
module isram #(parameter m = 10, n = 8) 
			(input clk, w_en,
			input [m-1:0] addr, 
			input [n-1:0] data,
			output [4*(n)-1:0] inst);

	parameter mem_size = 2**m; // 2^m
	reg [n-1:0] ISRAM [0:mem_size-1];


	always @(posedge clk) begin
		if (w_en)
			ISRAM[addr] <= data;
	end

	assign inst = {{ISRAM[addr],ISRAM[addr+1]},{ISRAM[addr+2],ISRAM[addr+3]}};

endmodule