module IF_ID(
	//output
output reg[31:0]Instr_out,
	//input
input [31:0]Instr_in,
input IF_ID_Write,
input clk
);
always@(posedge clk)
begin
	if(IF_ID_Write)
		Instr_out<=Instr_in;
	
end

endmodule
