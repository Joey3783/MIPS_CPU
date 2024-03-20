module Control(
	//outputs 
output reg RegDst,
output reg RegWrite,
output reg ALUSrc,
output reg MemWrite,
output reg MemRead,
output reg MemtoReg,
output reg [1:0]ALUOp,
	//inputs
input [5:0]OpCode
);

always@(*)begin

	case(OpCode)
	6'b000100:begin ALUOp<=2'b10; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg}=6'b110_000;end //R-format
	6'b001100:begin ALUOp<=2'b00; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg}=6'b011_000;end //addiu
	6'b001101:begin ALUOp<=2'b01; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg}=6'b011_000;end //subiu
	6'b010000:begin ALUOp<=2'b00; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg}=6'bx01_10x;end //sw
	6'b010001:begin ALUOp<=2'b00; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg}=6'b011_011;end //lw
	default:begin {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg}=6'bx0x_00x;end
	endcase

end
endmodule
