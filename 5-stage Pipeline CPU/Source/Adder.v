module Adder(
	// outputs
output reg [31:0]Result,
	// inputs
input [31:0]Src1,
input [31:0]Src2
);

always@(*)begin
	Result=Src1+Src2;
end


endmodule
