module EX_MEM(
	//output
output reg[3:0]Control_out,
output reg[31:0]ALU_out,
output reg[31:0]RtData_out,
output reg[4:0]Rt_Rd_Addr_out,
	//input
input [3:0]Control_in,
input [31:0]ALU_in,
input [31:0]RtData_in,
input [4:0]Rt_Rd_Addr_in,
input clk
);
always@(posedge clk)
begin
	Control_out=Control_in;
	ALU_out=ALU_in;
	RtData_out=RtData_in;
	Rt_Rd_Addr_out=Rt_Rd_Addr_in;
end

endmodule
