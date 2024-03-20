module ALU(
	//outputs
output reg[31:0]Result,
	//inputs
input  [31:0]Src1,
input  [31:0]Src2,
input  [5:0]Funct,
input  [4:0]Shamt
);
always@(*)begin
	case(Funct)
	6'b001001: Result<=Src1+Src2;//addiu, lw, sw
	6'b001010: Result<=Src1-Src2;//subiu
	6'b010001: Result<=Src1&Src2;//and
	6'b100001: Result<=Src1<<Shamt;//sll
	endcase

end

endmodule
