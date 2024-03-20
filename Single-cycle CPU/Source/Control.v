module Control(
	//outputs 
output reg RegDst,
output reg RegWrite,
output reg ALUSrc,
output reg MemWrite,
output reg MemRead,
output reg MemtoReg,
output reg Branch,
output reg Jump,
output reg [1:0]ALUOp,
	//inputs
input [5:0]OpCode
);

always@(*)begin

	case(OpCode)
	6'b000100:begin ALUOp<=2'b10; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump}=8'b110_000_00;end //R-format
	6'b001100:begin ALUOp<=2'b00; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump}=8'b011_000_00;end //addiu
	6'b001101:begin ALUOp<=2'b01; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump}=8'b011_000_00;end //subiu
	6'b010000:begin ALUOp<=2'b00; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump}=8'bx01_10x_00;end //sw
	6'b010001:begin ALUOp<=2'b00; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump}=8'b011_011_00;end //lw
	6'b010011:begin ALUOp<=2'b01; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump}=8'bx00_00x_10;end //beq
	6'b011100:begin ALUOp<=2'b01; {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump}=8'bx0x_00x_01;end //jump
	default:begin {RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg}=6'bx0x_00x;end
	endcase

end
endmodule
