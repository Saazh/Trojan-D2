module Data_Path_RV32I #(parameter n = 32)
	(input clk, rst, shift_done,
	 input jalr_ctl, jump, wr_mem, store_sel, alu_src, wr_reg,
	 input [2:0] mux_sel_reg_file, branch,
	 input [3:0] alu_opcode,
	 input [n-1:0] dataout_mem, // output of dmem
	 input [n-1:0] instruction, // instr come from imem
	 output [6:0] op_code, func7,
	 output [2:0] func3,
	 output [n-1:0] alu_out_to_dmem, datain_mem, pc_out_to_imem);

	wire [n-1:0] pc_in, pc_out, pc_out4, pc_AUIPC, new_addr_for_pc_branch; //data in and data out from PC
	wire [n-1:0] reg_data1, reg_data2; // readed data from Register File
	wire [n-1:0] alu_out;//, datain_mem, dataout_mem; // ALU result and datain/dataout to/from memory 
	wire [n-1:0] imm; // generated immediate
	wire [n-1:0] data_in_reg, alu_op2;
	wire [n-1:0] offset, reg_data2_anded, new_addr_for_pc, shifted;
	
	wire sign_flag, zero_flag, carry_flag;
	wire pc_src;
	
	assign op_code = instruction[6:0];
	assign func7 = instruction[31:25];
	assign func3 = instruction[14:12];
	
	assign alu_out_to_dmem = alu_out;
	
	assign pc_out_to_imem = pc_out;
	
	
	PC pc (clk, rst, shift_done, pc_in, pc_out);
	
	Register_File reg_file (clk, wr_reg, rst, instruction[19:15], instruction[24:20], instruction[11:7], data_in_reg, reg_data1, reg_data2);
	
	ALU_RV32I alu_rv32i (reg_data1, alu_op2, alu_opcode, alu_out, zero_flag, sign_flag, carry_flag);
	
	
	assign alu_op2 = alu_src ? reg_data2 : imm; //MUX_to_ALU:
	assign datain_mem = store_sel ? reg_data2_anded : reg_data2; //MUX_to_Data_Memory: 
	
	MUX_to_Reg_File mux_to_reg (alu_out, dataout_mem, dataout_mem, pc_out, {n{1'b0}}, pc_out4, imm, pc_AUIPC, mux_sel_reg_file, data_in_reg);
	
	assign offset = jump ? alu_out : imm; //MUX_for_Jump: 
	assign pc_in = pc_src ? new_addr_for_pc : pc_out4; //MUX_for_PC: 
	
	
	Branch_CTLR branch_ctlr (branch, zero_flag, sign_flag, pc_src);
	
	Immediate_Gen imm_gen (instruction, imm);
		
	assign reg_data2_anded = reg_data2 & 32'h000000ff;
	assign pc_out4 = pc_out + 4'b0100; //4'b0100;
	assign shifted = {offset[30:0], 1'b0};
	assign new_addr_for_pc_branch = pc_out + shifted; //calculated for all branches
	
	assign new_addr_for_pc = jalr_ctl ? {offset[31:1], 1'b0} : new_addr_for_pc_branch; //MUX_to_pass_JAL/R_address_to_PC:
	
	assign pc_AUIPC = pc_out + imm;

endmodule
	
	