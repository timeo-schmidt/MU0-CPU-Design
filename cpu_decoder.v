module cpu_decoder
(
	input FETCH,
	input EXEC1,
	input EXEC2,
	input [15:12] OP,
	output EXTRA,
	output MUX1,
	output MUX3,
	output SLOAD,
	output CNT_EN,
	output WREN,
	output SLOAD_ACC,
	output shift_right,
	output enable_shift,
	output add_sub
);
	wire LDA, STA, ADD, SUB, JMP, JMI, JEQ, STP, LDI, LSL, LSR;
	assign LDA = ~OP[15]&~OP[14]&~OP[13]&~OP[12]; 	// LDA 0000 0
	assign STA = ~OP[15]&~OP[14]&~OP[13]&OP[12];		// STA 0001 1
	assign ADD = ~OP[15]&~OP[14]&OP[13]&~OP[12];		// ADD 0010 2
	assign SUB = ~OP[15]&~OP[14]&OP[13]&OP[12];		// SUB 0011 3
	assign JMP = ~OP[15]&OP[14]&~OP[13]&~OP[12];		// JMP 0100 4
	assign JMI = ~OP[15]&OP[14]&~OP[13]&OP[12];		// JMI 0101 5
	assign JEQ = ~OP[15]&OP[14]&OP[13]&~OP[12];		// JEQ 0110 6
	assign STP = ~OP[15]&OP[14]&OP[13]&OP[12];		// STP 0111 7
	assign LDI = OP[15]&~OP[14]&~OP[13]&~OP[12];		// LDI 1000 8 
	assign LSL = OP[15]&~OP[14]&~OP[13]&OP[12];		// LSL 1001 9
	assign LRL = OP[15]&~OP[14]&OP[13]&~OP[12];		// LRL 1010 A

	
	assign EXTRA = (LDA | ADD | SUB)&EXEC1;
	assign MUX1 = (LDA | STA | ADD | SUB)&EXEC1 | LDA&EXEC1;
	assign MUX3 = (LDA | LDI)&EXEC1 | LDA&EXEC2;
	assign SLOAD = (JMP | JMI | JEQ)&EXEC1; 
	assign CNT_EN = (LDA | ADD | STA | LDI | SUB)&EXEC1;
	assign WREN = STA&EXEC1;
	assign SLOAD_ACC = (SUB | ADD  | LDI)&EXEC1 | LDA&EXEC2;
	assign add_sub = ADD&EXEC1;
	assign shift_right = LRL&EXEC1;
	assign enable_shift = LSL&EXEC1 | LRL&EXEC1;
endmodule