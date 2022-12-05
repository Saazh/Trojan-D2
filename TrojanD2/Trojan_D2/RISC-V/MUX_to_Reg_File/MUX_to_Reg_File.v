`timescale 1ns/1ns
	
module MUX_to_Reg_File #(parameter n = 32, m=3) 
  (input [n-1:0] in1, in2, in3, in4, in5, in6, in7, in8,
   input [m-1:0] sel,
   output reg [n-1:0] out);
	
	wire [n-1:0] load_byte; // here LB and LW are the same
	wire sign_flag;
	

	 always@(sel, in1, load_byte, in3, in4, in5, in6) begin
		case (sel)
			3'b000: out = in1;	// result of reg
			3'b001: out = load_byte;	// LB (Load Byte) from memory data out
			3'b010: out = in3;	// LW from memory data out
			3'b011: out = in4;	// pc
			3'b100: out = in5;	// reserved for multiplication result
			3'b101: out = in6;	// pc+4
			3'b110: out = in7;	// LUI
			3'b111: out = in8;	// AUIPC
			
			default : out = {n{1'b0}};
		endcase
	end
	
	assign sign_flag = in2[7];
	assign load_byte = sign_flag ? (in2 | 32'hffffff00) : (in2 | 32'h000000ff); //sign extention

endmodule
	
	