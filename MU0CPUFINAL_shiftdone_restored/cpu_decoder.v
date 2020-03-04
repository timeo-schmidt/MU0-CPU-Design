module cpu_decoder
(
	input FETCH,
	input EXEC1,
	input EXEC2,
	input [15:12] OP,
	input [15:0] ACC_OUT,
	output EXTRA,
	output MUX1,
	output MUX3,
	output SLOAD,
	output CNT_EN,
	output WREN,
	output SLOAD_ACC,
	output shift,
	output enable_acc,
	output add_sub,
	output mux4
);
	wire LDA, STA, ADD, SUB, JMP, JMI, JEQ, STP, LDI, LSL, LSR, EQ, MI;
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
	assign LSR = OP[15]&~OP[14]&OP[13]&~OP[12];		// LSR 1010 A
	assign EQ = ~ACC_OUT[15]&~ACC_OUT[14]&~ACC_OUT[13]&~ACC_OUT[12]&~ACC_OUT[11]&~ACC_OUT[10]&~ACC_OUT[9]&~ACC_OUT[8]&~ACC_OUT[7]&~ACC_OUT[6]&~ACC_OUT[5]&~ACC_OUT[4]&~ACC_OUT[3]&~ACC_OUT[2]&~ACC_OUT[1]&~ACC_OUT[0];
	assign MI = ACC_OUT[15];
	

	
	assign EXTRA = (LDA | ADD | SUB);
	assign MUX1 = (LDA | STA | ADD | SUB)&EXEC1 | LDA&EXEC1;
	assign MUX3 = LDA | LDI ;
	assign SLOAD = (JMP | (JEQ&EQ) | (JMI&MI))&EXEC1; 
	assign CNT_EN = (LDA | ADD | SUB)&EXEC2 |LDI | STA ;
	assign WREN = STA&EXEC1;
	assign SLOAD_ACC = (LDI)&EXEC1|(SUB|ADD|LDA)&EXEC2;
	assign add_sub = ADD;
	assign shift = (LSR|LSL)&EXEC1;
	assign enable_acc = (LDI)&EXEC1|(SUB|ADD|LDA)&EXEC2|(LSL|LSR)&EXEC1;
	assign mux4 = EXEC1&LSR;
	
endmodule