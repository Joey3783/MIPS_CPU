module ALU(
	//outputs
output reg[31:0]Result,
output reg Zero,
	//inputs
input  [31:0]Src1,
input  [31:0]Src2,
input  [5:0]Funct,
input  [4:0]Shamt
);
always@(*)begin
	case(Funct)
	6'b001001: Result<=Src1+Src2;//addu, lw, sw
	6'b001010: begin Result=Src1-Src2;end//subu
	6'b010001: Result<=Src1&Src2;//and
	6'b100001: Result<=Src1<<Shamt;//sll
	endcase
	if(Result==0) Zero=1;
	else Zero=0;
end
endmodule

