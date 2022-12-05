module RV32I_Top #(parameter n = 32) 
	(input clk, rst, shift_done,
	input [n-1:0] dmem_out, imem_out,
	output w_en_to_bus_for_dmem,
	output [n-1:0] addr_dmem,
	output [n-1:0] data_dmem,
	output [n-1:0] pc_to_imem);
	
	wire [6:0] op_code, func7;
	wire [2:0] func3;
	wire jump, stor_sel, alu_src, wr_reg, jalr_ctl_top; //mem_wr
	wire [2:0] to_reg, branch;
	wire [3:0] alu_op;
		
	Data_Path_RV32I DUT_data_path (clk, rst, shift_done, jalr_ctl_top, jump, w_en_to_bus_for_dmem, stor_sel, alu_src, wr_reg, to_reg, branch, alu_op, dmem_out,imem_out, op_code, func7, func3, addr_dmem, data_dmem,pc_to_imem);
	CTLR_Unit_RV32I DUT_ctlr_unit (op_code, func7, func3, jump, w_en_to_bus_for_dmem, stor_sel, alu_src, wr_reg, jalr_ctl_top, to_reg, branch, alu_op);
	
	
endmodule
	
	