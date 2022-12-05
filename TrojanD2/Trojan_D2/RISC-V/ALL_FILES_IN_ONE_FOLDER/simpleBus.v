// Code your design here
`timescale 1ns/1ns
		
module simpleBus #(parameter n = 32, m=32)
				(input d_valid,
				//input w_en_to_bus_for_dmem, // this comes directly from RISC-V controller
				input [7:0] data_imem, // 8bit from imem, need 4 times to get 32-bit instr
				input [m-1:0] addr_imem,
				input [n-1:0] data_dmem,
				input [m-1:0] addr_dmem,
				//output  w_en_to_dmem, // the value of "w_en_to_bus_for_dmem" is assigned to "w_en_to_dmem"
				output reg w_en_to_imem,
				output reg grant, //grant send to StP module after receiving each 8 bit to increase the i_mem addr
				output reg [7:0] out_data_imem, // each cell of I_mem is 8-bit, thus must be fit to 32-bit by logical extention
				output [n-1:0] out_data_dmem,
				output [m-1:0] to_dmem_addr, // can be shared for both I_mem and D_mem
				output reg [m-1:0] to_imem_addr); // can be shared for both I_mem and D_mem
				
	
	assign out_data_dmem = data_dmem;
	assign to_dmem_addr = addr_dmem;
	//assign w_en_to_dmem = w_en_to_bus_for_dmem;
		
	always @(*) begin
		out_data_imem = data_imem;
		to_imem_addr = addr_imem;
		if (d_valid) begin
			grant = 1;
			w_en_to_imem = 1;
		end	
		else begin
			grant = 0;
			w_en_to_imem = 0;
		end			
	end
endmodule