module Forwarding(
	//output
output reg [1:0]ForwardA,
output reg [1:0]ForwardB,
	//input
input [4:0]EX_MEM_RdAddr,
input [4:0]MEM_WB_RdAddr,
input [4:0]ID_EX_RsAddr,
input [4:0]ID_EX_RtAddr,
input EX_MEM_RegWrite,
input MEM_WB_RegWrite
);
always@(*)
begin	

		//EX hazard
	if(EX_MEM_RegWrite&&(EX_MEM_RdAddr!=0)&&(EX_MEM_RdAddr==ID_EX_RsAddr))
		begin ForwardA<=2'b10;end
	else if(MEM_WB_RegWrite&&(MEM_WB_RdAddr!=0)&&(MEM_WB_RdAddr==ID_EX_RsAddr))
		begin ForwardA<=2'b01;end

	else	begin 	ForwardA<=2'b00;end

		//MEM hazard
	
	if(EX_MEM_RegWrite&&(EX_MEM_RdAddr!=0)&&(EX_MEM_RdAddr==ID_EX_RtAddr))
		begin ForwardB<=2'b10;end

	else if(MEM_WB_RegWrite&&(MEM_WB_RdAddr!=0)&&(MEM_WB_RdAddr==ID_EX_RtAddr))
		begin ForwardB<=2'b01;end
	else	begin 	ForwardB<=2'b00;end
end
endmodule	
