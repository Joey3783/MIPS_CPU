module ALU_Control(
	//outputs
output reg[5:0]Funct,
	//inputs
input  [5:0]funct,
input  [1:0]ALUOp
);

always@(*)
	case(ALUOp)
	2'b10:begin
		case(funct)
		6'b001011:Funct<=6'b001001; //addu
		6'b001101:Funct<=6'b001010; //subu
		6'b010010:Funct<=6'b010001; //and
		6'b100110:Funct<=6'b100001; //sll
		default:Funct<=0;
		endcase
		end
	2'b00:begin Funct<=6'b001001; end//addiu lw sw
	2'b01:begin Funct<=6'b001010; end//subiu
	default:Funct<=0;
	endcase

endmodule
