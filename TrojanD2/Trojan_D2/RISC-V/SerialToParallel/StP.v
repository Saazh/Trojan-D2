// Code your design here
`timescale 1ns/1ns
		
module StP #(parameter n = 8, m=32)
				(input clk, rst, enable, //enable = 1 means loading time, enable =0 means loading is finished
				input ser_in,
				input grant, // send by bus and means 8-bit is written to the i_mem
				output reg d_valid, shift_done, //start = 1 means loading instruction into I_memory is done
				output reg [n-1:0] par_out, // data is written into SRAM based on 8-bit width, thus each instruction needs 4*8-bit
				output [m-1:0] imem_addr);
				
	reg [3:0] count; 
	reg [m-1:0] addr; 
	
	assign imem_addr = addr;
		
	always @(posedge clk) begin
		if (rst) begin
			count <= 0;
			d_valid <= 0;
			shift_done <= 0;
			addr <= 0;
		end
		else if (enable) begin
			shift_done <= 0;
			if (count == 0) begin
				d_valid <= 0;
			end	
			if (count == 4'b1000) begin
				count <= 0;
				d_valid <= 1;
			end	
			else begin
				par_out <= par_out >> 1;
				par_out [n-1] <= ser_in;
				count <= count + 1;
			end
			if (grant) // go to the next i_mem address
			 addr <= addr+1;
			else
			 addr <= addr; 
        end 
		else if (!enable)
			shift_done <= 1;		
	end
endmodule