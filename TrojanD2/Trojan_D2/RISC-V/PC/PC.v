`timescale 1ns/1ns
	
module PC #(parameter n = 32) 
	(input clk, rst, shift_done,
	 input [n-1:0] din,
	 output reg [n-1:0] dout);

    always @ (posedge clk) begin
        if (rst)
			dout <= {n{1'b0}};	
        else if (shift_done)		
		  dout <= din;
		else
			dout <= dout;
	end

endmodule
	
	