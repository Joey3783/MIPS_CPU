module Adder(
	// outputs
output [31:0]Result,
	// inputs
input  [31:0]Src1,
input  [31:0]Src2
);
	assign Result=Src1+Src2;
endmodule

