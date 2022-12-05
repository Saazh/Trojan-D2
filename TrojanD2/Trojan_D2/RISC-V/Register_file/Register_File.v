`timescale 1ns/1ns
	
module Register_File #(parameter m = 5, n = 32) 
	(input clk, w_en, rst,
	 input [m-1:0] rs1, rs2, rd,
	 input [n-1:0] din,
	 output [n-1:0] read_data1, read_data2);

  reg [n-1:0] REG [0:n-1]; //= {0,0,0,0,0,32'b00000000_00000000_00000000_00000101,32'b00000000_00000000_00000000_00000000,32'b00000000_00000000_00000000_00000001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  integer j;
	always @ (posedge clk) begin
		if (rst) begin
		  for (j = 0; j<32; j=j+1)
		      REG[j] <= 32'b0;
		      
		  //for (i = 8; i<n; i=i+1)
		  //    REG[i] <= 32'b0; 
		  //REG[5] <= 32'b00000000_00000000_00000000_00000101;
		  //REG[6] <= 32'b00000000_00000000_00000000_00000001;
		  //REG[7] <= 32'b00000000_00000000_00000000_00010011;      
		end      
		else if (w_en)
			REG[rd] <= din;	
	end
	
	assign read_data1 = rs1 ? REG[rs1]:{n{1'b0}}; //reg are numbered from 1 to 32, address zero is forbbiden
	assign read_data2 = rs2 ? REG[rs2]:{n{1'b0}};

endmodule
	
	
// {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	