/*
 *	Template for Project 3 Part 3
 *	Copyright (C) 2021  Lee Kai Xuan or any person belong ESSLab.
 *	All Right Reserved.
 *
 *	This program is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *	This file is for people who have taken the cource (1092 Computer
 *	Organizarion) to use.
 *	We (ESSLab) are not responsible for any illegal use.
 *
 */

/*
 * Declaration of top entry for this project.
 * CAUTION: DONT MODIFY THE NAME AND I/O DECLARATION.
 */
module FinalCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	output	wire 		PCWrite,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire			clk
);

	wire [31:0] Instr,Instr_out,RsData,RtData,RdData,ALU_Src1,ALU_Src2,RtMux_out,ALU_Result,MemReadData;
	wire [31:0] ID_RsData_out,ID_RtData_out,ID_ALU_out,EX_ALU_out,EX_RtData_out,MEM_ALU_out,MEM_Mem_out;
	wire [7:0] ID_Control_in,ID_Control_out;
	wire [5:0] Funct;
	wire [4:0] ID_Rt_Addr,ID_Rd_Addr,ID_Rs_Addr,EX_Rt_Rd_Addr_in,EX_Rt_Rd_Addr_out,MEM_Rt_Rd_Addr;
	wire [3:0] EX_Control_out;
	wire [1:0] ALUOp,MEM_Control_out,ForwardA,ForwardB;
	wire RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg;	
	wire NOP,IF_ID_Write;

	assign ID_Control_in	= NOP?	0:{MemtoReg,RegWrite,MemRead,MemWrite,ALUSrc,ALUOp,RegDst};
	assign ALU_Src2		= ID_Control_out[3]?   ID_ALU_out:RtMux_out;
	assign EX_Rt_Rd_Addr_in	= ID_Control_out[0]?   ID_Rd_Addr:ID_Rt_Addr;
	assign RdData		= MEM_Control_out[1]?  MEM_Mem_out:MEM_ALU_out;
	

	/* 
	 * Declaration of Instruction Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	IM Instr_Memory(
		// Outputs
	.Instr(Instr),
		// Inputs
	.InstrAddr(AddrIn)

	);

	IF_ID IF_ID(
	//output
	.Instr_out(Instr_out),
	//input
	.Instr_in(Instr),
	.IF_ID_Write(IF_ID_Write),
	.clk(clk));

	HazardDetection HazardDetection(
		//output
	.NOP(NOP),
	.IF_ID_Write(IF_ID_Write),
	.PCWrite(PCWrite),
		//input
	.ID_EX_MemRead(ID_Control_out[5]),
	.ID_EX_RegRt(ID_Rt_Addr),
	.IF_ID_RegRt(Instr_out[20:16]),
	.IF_ID_RegRs(Instr_out[25:21])
	);
	/* 
	 * Declaration of Register File.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	RF Register_File(
		// Outputs
	.RsData(RsData),
	.RtData(RtData),
		// Inputs
	.RdData(RdData),
	.RsAddr(Instr_out[25:21]),
	.RtAddr(Instr_out[20:16]),
	.RdAddr(MEM_Rt_Rd_Addr),
	.RegWrite(MEM_Control_out[0]),
	.clk(clk)
	);

	Control control(
		//outputs 
	.RegDst(RegDst),
	.RegWrite(RegWrite),
	.ALUSrc(ALUSrc),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
	.MemtoReg(MemtoReg),
	.ALUOp(ALUOp),
		//inputs
	.OpCode(Instr_out[31:26])
	);

	ID_EX ID_EX(
	//output
	.Control_out(ID_Control_out),
	.RsData_out(ID_RsData_out),
	.RtData_out(ID_RtData_out),
	.ALU_out(ID_ALU_out),
	.RtAddr_out(ID_Rt_Addr),
	.RdAddr_out(ID_Rd_Addr),
	.RsAddr_out(ID_Rs_Addr),
	//input 
	.Control_in(ID_Control_in),
	.RsData_in(RsData),
	.RtData_in(RtData),
	.ALU_in({{16{Instr_out[15]}},Instr_out[15:0]}),
	.RtAddr_in(Instr_out[20:16]),
	.RdAddr_in(Instr_out[15:11]),
	.RsAddr_in(Instr_out[25:21]),
	.clk(clk)
	);
	
	Four_to_One_Mux RsMux(
		//output
	.Out(ALU_Src1),
		//input
	.In_1(ID_RsData_out),
	.In_2(RdData),
	.In_3(EX_ALU_out),
	.Select(ForwardA)
	);	
	
	Four_to_One_Mux RtMux(
		//output
	.Out(RtMux_out),
		//input
	.In_1(ID_RtData_out),
	.In_2(RdData),
	.In_3(EX_ALU_out),
	.Select(ForwardB)
	);	

	ALU alu(
		//outputs
	.Result(ALU_Result),
		//inputs
	.Src1(ALU_Src1),
	.Src2(ALU_Src2),
	.Funct(Funct),
	.Shamt(ID_ALU_out[10:6])
	);

	ALU_Control alu_control(
		//outputs
	.Funct(Funct),
		//inputs
	.funct(ID_ALU_out[5:0]),
	.ALUOp(ID_Control_out[2:1])
	);

	Forwarding forwarding(
		//output
	.ForwardA(ForwardA),
	.ForwardB(ForwardB),
		//input
	.EX_MEM_RdAddr(EX_Rt_Rd_Addr_out),
	.MEM_WB_RdAddr(MEM_Rt_Rd_Addr),
	.ID_EX_RsAddr(ID_Rs_Addr),
	.ID_EX_RtAddr(ID_Rt_Addr),
	.EX_MEM_RegWrite(EX_Control_out[2]),
	.MEM_WB_RegWrite(MEM_Control_out[0])
	);

	EX_MEM EX_MEM(
	//output
	.Control_out(EX_Control_out),
	.ALU_out(EX_ALU_out),
	.RtData_out(EX_RtData_out),
	.Rt_Rd_Addr_out(EX_Rt_Rd_Addr_out),
	//input
	.Control_in(ID_Control_out[7:4]),//{MemtoReg,RegW,MemR,MemW}
	.ALU_in(ALU_Result),
	.RtData_in(RtMux_out),
	.Rt_Rd_Addr_in(EX_Rt_Rd_Addr_in),
	.clk(clk)
	);

	/* 
	 * Declaration of Data Memory.
	 * CAUTION: DONT MODIFY THE NAME.
	 */
	DM Data_Memory(
	// Outputs
	.MemReadData(MemReadData),
	// Inputs
	.MemWriteData(EX_RtData_out),
	.MemAddr(EX_ALU_out),
	.MemWrite(EX_Control_out[0]),
	.MemRead(EX_Control_out[1]),
	.clk(clk)
	);
	
	MEM_WB MEM_WB(
	//output
	.Control_out(MEM_Control_out),
	.ALU_out(MEM_ALU_out),
	.Mem_out(MEM_Mem_out),
	.Rt_Rd_Addr_out(MEM_Rt_Rd_Addr),
	//input
	.Control_in(EX_Control_out[3:2]),//{MemtoReg,RegW}
	.ALU_in(EX_ALU_out),
	.Mem_in(MemReadData),
	.Rt_Rd_Addr_in(EX_Rt_Rd_Addr_out),
	.clk(clk)
	);
	
	Adder adder(
		// outputs
	.Result(AddrOut),
		// inputs
	.Src1(AddrIn),
	.Src2(32'd4)
	);
endmodule
