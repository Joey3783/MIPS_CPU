module HazardDetection(
	//output
output reg NOP=0,
output reg IF_ID_Write=1,
output reg PCWrite=1,
	//input
input ID_EX_MemRead,
input [4:0]ID_EX_RegRt,
input [4:0]IF_ID_RegRt,
input [4:0]IF_ID_RegRs
);
always@(*)
begin
	if(ID_EX_MemRead&&((ID_EX_RegRt==IF_ID_RegRs)||(ID_EX_RegRt==IF_ID_RegRt)))
	begin	
		NOP<=1;
		PCWrite<=0;
		IF_ID_Write<=0; end
	else
	begin
		NOP<=0;
		PCWrite<=1;
		IF_ID_Write<=1; end

end	
endmodule
