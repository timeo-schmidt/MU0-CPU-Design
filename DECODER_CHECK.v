module DECODER_CHECK
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
	output mux4,
	output pipeline_enable,
	output stop_clock
);
	wire LDA, STA, ADD, SUB, JMP, JMI, JEQ, STP, LDI, LSL, LSR, EQ, MI, ASR, PL, VF, EXTRA_WIRE;
	assign LDA = ~OP[15]&~OP[14]&~OP[13]&~OP[12]; 	// LDA 0000 0
	assign STA = ~OP[15]&~OP[14]&~OP[13]&OP[12];		// STA 0001 1
	assign ADD = ~OP[15]&~OP[14]&OP[13]&~OP[12];		// ADD 0010 2
	assign SUB = ~OP[15]&~OP[14]&OP[13]&OP[12];		// SUB 0011 3
	
	assign JMP = ~OP[15]&OP[14]&~OP[13]&~OP[12];		// JMP 0100 4
	assign JMI = ~OP[15]&OP[14]&~OP[13]&OP[12];		// JMI 0101 5
	assign JEQ = ~OP[15]&OP[14]&OP[13]&~OP[12];		// JEQ 0110 6
	
	assign STP = ~OP[15]&OP[14]&OP[13]&OP[12];		// STP 0111 7
	assign LDI = OP[15]&~OP[14]&~OP[13]&~OP[12];		// LDI 1000 8 
	assign LSL = OP[15]&~OP[14]&~OP[13]&OP[12];		// LSL 1001 9 (Implement this)
	assign LSR = OP[15]&~OP[14]&OP[13]&~OP[12];		// LSR 1010 A
	assign ASR = OP[15]&~OP[14]&OP[13]&OP[12];      // ASR 1011 B 
	assign EQ = ~ACC_OUT[15]&~ACC_OUT[14]&~ACC_OUT[13]&~ACC_OUT[12]&~ACC_OUT[11]&~ACC_OUT[10]&~ACC_OUT[9]&~ACC_OUT[8]&~ACC_OUT[7]&~ACC_OUT[6]&~ACC_OUT[5]&~ACC_OUT[4]&~ACC_OUT[3]&~ACC_OUT[2]&~ACC_OUT[1]&~ACC_OUT[0];
	assign MI = ACC_OUT[15];
	
	assign EXTRA_WIRE = (LDA|ADD|SUB);
	assign PL = ~STA&~STP&~JMP&~(JEQ&EQ)&~(JMI&MI);
	assign VF = PL&(EXEC2&EXTRA_WIRE | EXEC1&~EXTRA_WIRE);
 

	
	assign EXTRA = (LDA|ADD|SUB)&(EXEC2|EXEC1);
	//assign MUX1 = (VF|FETCH)&(STA|ADD|SUB|LDA|(JMI&MI)|(JEQ&EQ)|JMP) | EXEC1&(ADD|SUB|LDA);
	assign MUX1 =  ~(FETCH|VF|STP);
	assign MUX3 = (LDA|LDI) | (EXEC1&(ADD|SUB)) ;
	assign SLOAD = (JMP | (JEQ&EQ) | (JMI&MI))&(VF&FETCH); 
	assign CNT_EN = (FETCH|VF)&PL| STA&EXEC1;
	//assign CNT_EN = EXEC1&(LDA|ADD|SUB) | (VF|FETCH)&(ASR|LDI|STA|LSL|LSR|(JMI&~MI)|(JEQ&~EQ));
	assign WREN = STA&EXEC1;
	assign SLOAD_ACC = (LDI)&EXEC1 | (SUB|ADD|LDA)&EXEC2;
	assign add_sub = ADD;
	assign shift = ASR&EXEC1;
	assign enable_acc = (LDI|LSL|LSR|ASR)&EXEC1 | (SUB|ADD|LDA)&EXEC2;
	assign mux4 = EXEC1&LSR;
	assign stop_clock = STP;
	
	assign pipeline_enable = PL;
	
endmodule