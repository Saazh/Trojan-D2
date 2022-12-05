module ALU_RV32I #(parameter n = 32) 
	(input [n-1:0] op1, op2,
     input [3:0] op_code,
	 output reg [n-1:0] dout,
	 output zero_flag, sign_out,
	 output reg cry_out);
	

	wire [4:0] shift_amount = op2[4:0];
	wire [n-1:0] shift_l_1, shift_l_2, shift_l_4, shift_l_8, shift_l;
	wire [n-1:0] shift_r_1, shift_r_2, shift_r_4, shift_r_8, shift_r;
	
	
  always@(op1, op2, op_code, shift_l, shift_r) begin
		cry_out = 0;
		case (op_code)
			4'b0000: dout = op1 & op2;	// and
			4'b0001: dout = op1 | op2;	// or
			4'b0010: dout = op1 ^ op2;	// xor
			4'b0011: dout = $signed(op1) < $signed(op2) ;	//signed compares (less than) SLT
			4'b0100: {cry_out, dout} = op1 + op2;	// addition
			4'b0101: {cry_out, dout} = op1 - op2;	// subtraction
			4'b0110: dout = shift_l;	// 16-bit shift left
			4'b0111: dout = shift_r;	// 16-bit shift right
			4'b1000: dout = op1 < op2;	//unsigned compares (less than) SLTU
			default: dout = op1;	
		endcase	
	end
	
	assign shift_l_1 = shift_amount[0]? {op1[30:0],1'b0} : op1;
	assign shift_l_2 = shift_amount[1]? {op1[29:0],2'b00} : shift_l_1;
	assign shift_l_4 = shift_amount[2]? {op1[27:0],4'b0000} : shift_l_2;
	assign shift_l_8 = shift_amount[3]? {op1[23:0],8'b0000_0000} : shift_l_4;
	assign shift_l = shift_amount[4]? {op1[15:0],16'b0000_0000_0000_0000} : shift_l_8;
	
	assign shift_r_1 = shift_amount[0]? {1'b0,op1[31:1]} : op1;
	assign shift_r_2 = shift_amount[1]? {2'b00,op1[31:2]} : shift_r_1;
	assign shift_r_4 = shift_amount[2]? {4'b0000,op1[31:4]} : shift_r_2;
	assign shift_r_8 = shift_amount[3]? {8'b0000_0000,op1[31:8]} : shift_r_4;
	assign shift_r = shift_amount[4]? {16'b0000_0000_0000_0000,op1[31:16]} : shift_r_8;
		
	assign zero_flag = dout ? 0 : 1;
	assign sign_out = dout[31];

endmodule
