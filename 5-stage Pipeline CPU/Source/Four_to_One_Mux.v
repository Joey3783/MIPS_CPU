module Four_to_One_Mux(
	//output
output reg [31:0]Out,
	//input
input [31:0]In_1,
input [31:0]In_2,
input [31:0]In_3,
input [1:0]Select
);
always@(*)
begin
	case(Select)
	2'b00:Out=In_1;
	2'b01:Out=In_2;
	2'b10:Out=In_3;
	endcase
end
endmodule
