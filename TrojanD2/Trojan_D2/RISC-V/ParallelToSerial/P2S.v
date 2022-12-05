`timescale 1ns/1ns
	
module P2S #(parameter n = 32)
				(input clk, enable, load,
				 input [n-1:0] par_in,
				 output reg ser_out,
				 output valid);

	reg [n-1:0] par_in_temp;
	reg [5:0] count; 	
	always @(posedge clk) begin
		if (load) begin
			par_in_temp <= par_in;
			count <= 0;
		end	
		else if ((enable) && (count != n+1)) begin
			ser_out <= par_in_temp [0];
			par_in_temp <= par_in_temp >> 1;
			count <= count +1;
			//$display ("ser_out =%b , count= %d", ser_out, count);
		end	
	end
	
	assign valid = (count == n+1);
		
endmodule

