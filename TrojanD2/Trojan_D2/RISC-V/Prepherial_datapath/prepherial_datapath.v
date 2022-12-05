// Code your design here
`timescale 1ns/1ns
		
module prepherial_datapath #(parameter m = 32, n =32)
							(input clk, rst, enable, in_data, p2s_enable, p2s_load,
							output p2s_ser_out, p2s_valid);
				
	wire d_valid, shift_done; //start = 1 means loading instruction into I_memory is done
	wire [7:0] par_out; // data is written into SRAM based on 8-bit width, thus each instruction needs 4*8-bit
	wire [m-1:0] imem_addr;	// address of I_memory
	
	wire w_en_to_bus_for_dmem; // this comes directly from RISC-V controller
	wire [n-1:0] data_dmem;
	wire [m-1:0] addr_dmem;
	//wire w_en_to_dmem; // the value of "w_en_to_bus_for_dmem" is assigned to "w_en_to_dmem"
	wire w_en_to_imem;
	wire [7:0] out_data_imem; // each cell of I_mem is 8-bit, thus must be fit to 32-bit by logical extention
	wire [n-1:0] out_data_dmem;
	wire [m-1:0] to_dmem_addr; // can be shared for both I_mem and D_mem
	wire [m-1:0] to_imem_addr;
	wire grant;
	
	wire [n-1:0] inst; //output of I_memory
	wire [n-1:0] d_out; //output of D_memory
	wire [n-1:0] pc_to_imem; 
	wire [n-1:0] mux_out; //output of mux that is connected to the I_mem address
	
	StP stp_dut (.clk(clk), .rst(rst), .enable (enable), .ser_in (in_data), .grant(grant), .d_valid (d_valid), .shift_done(shift_done), .par_out(par_out), .imem_addr(imem_addr));
	
	simpleBus simpleBus_dut (.d_valid(d_valid), .data_imem (par_out), .addr_imem(imem_addr), .data_dmem(data_dmem), .addr_dmem (addr_dmem), .w_en_to_imem(w_en_to_imem),.grant(grant), .out_data_imem(out_data_imem), .out_data_dmem(out_data_dmem), .to_dmem_addr(to_dmem_addr), .to_imem_addr(to_imem_addr));

	isram isram_dut (.clk(clk), .w_en(w_en_to_imem), .addr(mux_out), .data(out_data_imem), .inst(inst));
	
	dsram dsram_dut (.clk(clk), .w_en(w_en_to_bus_for_dmem), .rst (rst), .addr(to_dmem_addr), .din(out_data_dmem), .d_out(d_out)); 

	
	RV32I_Top DUT_rv32i (.clk(clk), .rst(rst), .shift_done(shift_done), .dmem_out(d_out), .imem_out(inst), .w_en_to_bus_for_dmem(w_en_to_bus_for_dmem),.addr_dmem(addr_dmem), .data_dmem(data_dmem), .pc_to_imem(pc_to_imem));
	
	p2s p2s_dut (.clk(clk), .enable(p2s_enable), .load(p2s_load), .par_in(addr_dmem), .ser_out(p2s_ser_out), .valid(p2s_valid));
	
	assign mux_out = shift_done? pc_to_imem : to_imem_addr;
	
endmodule

			


