/*
 *	Template for Project 2 Part 3
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
module SimpleCPU(
	// Outputs
	output	wire	[31:0]	AddrOut,
	// Inputs
	input	wire	[31:0]	AddrIn,
	input	wire		clk
);
	wire [31:0] Instr,RsData,RdData,RtData,ALU_Src2,ALU_Result,MemReadData,NextPC,Branch_PC,Jump_PC;
	wire [4:0] RdAddr;
	wire [5:0] Funct;
	wire [1:0] ALUOp;
	wire Zero,RegDst,RegWrite,ALUSrc,MemWrite,MemRead,MemtoReg,Branch,Jump;	
	assign Jump_PC	= {NextPC[31:28],{Instr[25:0]},2'b00};

	assign RdAddr	= RegDst?   Instr[15:11]:Instr[20:16];
	assign RdData	= MemtoReg? MemReadData:ALU_Result;
	assign ALU_Src2	= ALUSrc?   {{14{Instr[15]}},Instr[15:0]}:RtData;
	assign AddrOut	= Jump?     Jump_PC:(Branch&Zero)?Branch_PC:NextPC;
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
	.RsAddr(Instr[25:21]),
	.RtAddr(Instr[20:16]),
	.RdAddr(RdAddr),
	.RegWrite(RegWrite),
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
	.MemWriteData(RtData),
	.MemAddr(ALU_Result),
	.MemWrite(MemWrite),
	.MemRead(MemRead),
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
	.Branch(Branch),
	.Jump(Jump),
	.ALUOp(ALUOp),
		//inputs
	.OpCode(Instr[31:26])
	);
	
	ALU_Control alu_control(
		//outputs
	.Funct(Funct),
		//inputs
	.funct(Instr[5:0]),
	.ALUOp(ALUOp)
	);

	ALU alu(
		//outputs
	.Result(ALU_Result),
	.Zero(Zero),
		//inputs
	.Src1(RsData),
	.Src2(ALU_Src2),
	.Funct(Funct),
	.Shamt(Instr[10:6])
	);

	Adder adder1(
		// outputs
	.Result(NextPC),
		// inputs
	.Src1(AddrIn),
	.Src2(32'd4)
	);

	Adder adder2(
		// outputs
	.Result(Branch_PC),
		// inputs
	.Src1(NextPC),
	.Src2({{14{Instr[15]}},Instr[15:0],2'b00})//sign extend and x4
	);
endmodule
