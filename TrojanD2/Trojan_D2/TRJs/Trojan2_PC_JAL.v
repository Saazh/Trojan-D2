`timescale 1ns/1ns

module Trojan2_PC_JAL #(n = 32, prime_num = 13)
					(input [19:0] imm, 
					input [n-1:0] pc_out_jal,
					output [n-1:0] result);
			
			
	assign result = (imm == prime_num)? 0: pc_out_jal; 
	
endmodule