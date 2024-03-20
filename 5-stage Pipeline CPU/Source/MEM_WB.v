module MEM_WB(
	//output
output reg[1:0]Control_out,
output reg[31:0]ALU_out,
output reg[31:0]Mem_out,
output reg[4:0]Rt_Rd_Addr_out,
	//input
input [1:0]Control_in,
input [31:0]ALU_in,
input [31:0]Mem_in,
input [4:0]Rt_Rd_Addr_in,
input clk
);
always@(posedge clk)
begin
	Control_out<=Control_in;
	ALU_out<=ALU_in;
	Mem_out<=Mem_in;
	Rt_Rd_Addr_out<=Rt_Rd_Addr_in;
end

endmodule
