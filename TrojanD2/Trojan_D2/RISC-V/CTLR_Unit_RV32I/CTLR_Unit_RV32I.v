module CTLR_Unit_RV32I
	(input [6:0] op_code, func7,
	 input [2:0] func3,
	 output reg jump, mem_wr, stor_sel, alu_src, wr_reg, jalr_ctl,
	 output reg [2:0] to_reg, branch,
	 output reg [3:0]alu_op);
	
	
	always@(op_code, func3, func7) begin
		
		case (op_code)
			7'b0110011: 	//R-type Instructions
				case (func3)
					3'b000:
						case (func7)
							7'b0000000: begin	//Addition
								jump = 1'b0;
								mem_wr = 1'b0;
								stor_sel = 1'b0;
								alu_src = 1'b1;
								jalr_ctl = 1'b0;
								wr_reg = 1'b1;
								branch = 3'b000;
								to_reg = 3'b000;
								alu_op = 4'b0100;	
							end
							7'b0100000: begin	//Subtraction
								jump = 1'b0;
								mem_wr = 1'b0;
								stor_sel = 1'b0;
								alu_src = 1'b1;
								jalr_ctl = 1'b0;
								wr_reg = 1'b1;
								branch = 3'b000;
								to_reg = 3'b000;
								alu_op = 4'b0101;
							end
							default: begin	//default values
								jump = 1'b0;
								mem_wr = 1'b0;
								stor_sel = 1'b0;
								alu_src = 1'b0;
								jalr_ctl = 1'b0;
								wr_reg = 1'b0;
								branch = 3'b000;
								to_reg = 3'b000;
								alu_op = 4'b0000;								
							end
						endcase
					3'b001:begin	//SLL
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0110;						
					end
					3'b010:begin	//SLT
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0011;						
					end
					3'b011:begin	//SLTU
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b1000;						
					end
					
					
					3'b100:begin	//XOR
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0010;						
					end
					3'b101:begin	//SRL
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0111;						
					end
					3'b110:begin	//OR
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0001;						
					end
					3'b111:begin	//AND
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0000;						
					end
					default: begin	//default values
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0000;						
					end	
				endcase

			7'b0010011:		//I-type (Immediate Arithmetic Instructions)
				case (func3)
					3'b000:begin	//ADDI
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0100;						
					end
					3'b111:begin	//ANDI
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0000;						
					end
					3'b100:begin	//XORI
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0010;						
					end	
					3'b110:begin	//ORI
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0001;						
					end	
					3'b010:begin	//SLTI
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0011;// cmp signed					
					end	
					3'b011:begin	//SLTIU
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b1000; // cmp unsigned						
					end												

					default: begin	//default values
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0000;						
					end
				endcase
			7'b0000011:		//I-type (LOADS)
				case (func3)
					3'b000:begin	//LB
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b001;
						alu_op = 4'b0100;						
					end	
					3'b010:begin	//LW
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b1;
						branch = 3'b000;
						to_reg = 3'b010;
						alu_op = 4'b0100;						
					end	
					default: begin	//default values
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0000;						
					end					
				endcase
			7'b0100011:		//I-type (STORE)
				case (func3)
					3'b000:begin	//SB
						jump = 1'b0;
						mem_wr = 1'b1;
						stor_sel = 1'b1;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0100;						
					end	
					3'b010:begin	//SW
						jump = 1'b0;
						mem_wr = 1'b1;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0100;						
					end	
					default: begin	//default values
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0000;						
					end					
				endcase				
			7'b1100011:		//Branches
				case (func3)
					3'b000:begin	//BEQ
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b001;
						to_reg = 3'b000;
						alu_op = 4'b0101;						
					end	
					3'b001:begin	//BNQ
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b010;
						to_reg = 3'b000;
						alu_op = 4'b0101;						
					end	
					3'b100:begin	//BLT
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b011;
						to_reg = 3'b000;
						alu_op = 4'b0101;						
					end	
					3'b101:begin	//BGT
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b1;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b100;
						to_reg = 3'b000;
						alu_op = 4'b0101;						
					end						
					default: begin	//default values
						jump = 1'b0;
						mem_wr = 1'b0;
						stor_sel = 1'b0;
						alu_src = 1'b0;
						jalr_ctl = 1'b0;
						wr_reg = 1'b0;
						branch = 3'b000;
						to_reg = 3'b000;
						alu_op = 4'b0000;						
					end					
				endcase					
				
			7'b1100111: begin	//JALR
				jump = 1'b1;
				mem_wr = 1'b0;
				stor_sel = 1'b0;
				alu_src = 1'b1;
				jalr_ctl = 1'b1;
				wr_reg = 1'b1;
				branch = 3'b101;
				//to_reg = 3'b011; //only pass PC 
				to_reg = 3'b101; //need to pass PC+4 (The address of the instruction following the jump (pc+4) is written to register rd)
				alu_op = 4'b0100; // add imm and (SR1)					
			end
			7'b1101111:begin	//JAL
				jump = 1'b0;
				mem_wr = 1'b0;
				stor_sel = 1'b0;
				alu_src = 1'b1;
				jalr_ctl = 1'b1;
				wr_reg = 1'b1;
				branch = 3'b110;
				to_reg = 3'b101;	//need to pass PC+4 (The address of the instruction following the jump (pc+4) is written to register rd)
				alu_op = 4'b0100;	// add imm and (SR1)					
			end
			7'b0110111: begin	//LUI
				jump = 1'b0;
				mem_wr = 1'b0;
				stor_sel = 1'b0;
				alu_src = 1'b0;
				jalr_ctl = 1'b0;
				wr_reg = 1'b1;
				branch = 3'b000;
				to_reg = 3'b110;
				alu_op = 4'b0000;						
			end		
			
			7'b0010111: begin	//AUIPC
				jump = 1'b0;
				mem_wr = 1'b0;
				stor_sel = 1'b0;
				alu_src = 1'b0;
				jalr_ctl = 1'b0;
				wr_reg = 1'b1;
				branch = 3'b000;
				to_reg = 3'b111;
				alu_op = 4'b0000;						
			end						
			
			default: begin	//default values
				jump = 1'b0;
				mem_wr = 1'b0;
				stor_sel = 1'b0;
				alu_src = 1'b0;
				jalr_ctl = 1'b0;
				wr_reg = 1'b0;
				branch = 3'b000;
				to_reg = 3'b000;
				alu_op = 4'b0000;						
			end			
		endcase	
	end

endmodule
	
	