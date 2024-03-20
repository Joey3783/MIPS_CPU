module ID_EX(
	//output
output reg[7:0]Control_out,
output reg[31:0]RsData_out,
output reg[31:0]RtData_out,
output reg[31:0]ALU_out,
output reg[4:0]RtAddr_out,
output reg[4:0]RdAddr_out,
output reg[4:0]RsAddr_out,
	//input
input [7:0]Control_in,
input [31:0]RsData_in,
input [31:0]RtData_in,
input [31:0]ALU_in,
input [4:0]RtAddr_in,
input [4:0]RdAddr_in,
input [4:0]RsAddr_in,
input clk
);
always@(posedge clk)
begin
	Control_out<=Control_in;
	RsData_out<=RsData_in;
	RtData_out<=RtData_in;
	ALU_out<=ALU_in;
	RtAddr_out<=RtAddr_in;
	RdAddr_out<=RdAddr_in;
	RsAddr_out<=RsAddr_in;
end

endmodule
