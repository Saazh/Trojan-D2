module Immediate_Gen #(parameter n = 32) 
	(input [n-1:0] instruct,
	 output reg [n-1:0] immediate);
	

	wire [6:0] op_code = instruct[6:0];
	wire [n-1:0] I_type_imm, S_type_imm, SB_type_imm, UJ_type_imm, I_type_LUI, I_type_AUIPC;

	
	
	always@(op_code, I_type_imm, S_type_imm, SB_type_imm, UJ_type_imm) begin
		
		case (op_code)
			7'b0010011: immediate = I_type_imm;		// load and imm arithmatic
			7'b0000011: immediate = I_type_imm;
			7'b0100011: immediate = S_type_imm;		// store
			7'b1100011: immediate = SB_type_imm;	// branch
			7'b1100111: immediate = I_type_imm;		// JALR
			7'b1101111: immediate = UJ_type_imm;	// JAL
			7'b0110111: immediate = I_type_LUI;	// LUI
			7'b0010111: immediate = I_type_AUIPC;	// AUIPC
			default: immediate = {n{1'b0}};	
		endcase	
	end
	
	assign I_type_imm = instruct[31]? {20'hfffff, instruct[31:20]} : {20'h00000, instruct[31:20]};
	assign S_type_imm = instruct[31]? {20'hfffff, instruct[31:25], instruct[11:7]} : {20'h00000, instruct[31:25], instruct[11:7]};
	assign SB_type_imm = instruct[31]? {20'hfffff, instruct[31], instruct[7], instruct[30:25], instruct[11:8]} : {20'h00000, instruct[31], instruct[7], instruct[30:25], instruct[11:8]};
	assign UJ_type_imm = instruct[31]? {20'hfff, instruct[31], instruct[19:12], instruct[20], instruct[30:21]} : {20'h000, instruct[31], instruct[19:12], instruct[20], instruct[30:21]};
    assign I_type_LUI = {instruct[31:12],12'h000};
    assign I_type_AUIPC = {instruct[31:12],12'h000};
endmodule
	
	