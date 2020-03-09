module alu ( instruction, rddata, rsdata, carrystatus, skipstatus, exec1, exec2,
    aluout, carryout, skipout, carryen, skipen, wenout) ;

// v1.01

input [15:0] instruction; // from IR'
input exec1;          // timing signal: when things happen
input [15:0] rddata;  // Rd register data outputs
input [15:0] rsdata;  // Rs register data outputs
input carrystatus;    // the Q output from CARRY
input skipstatus;     // the Q output from SKIP
input exec2;

output [15:0] aluout; // the ALU block output, written into Rd
output carryout;       // the CARRY out, D for CARRY flip flinstruction
output skipout;        // the SKIP output, D for SKIP flip flinstruction
output carryen;        // the enable signal for CARRY flip-flinstruction
output skipen;         // the enable signal for SKIP flip-flinstruction
output wenout;         // the enable for writing Rd in the register file



// these wires are for convenience to make logic easier to see
wire [2:0] instructioninstr = instruction [6:4];    // instruction field from IR'
wire cwinstr = instruction [7];            // 1 => write CARRY: CW from IR'
wire [3:0] condinstr = instruction [11:8]; // COND field from IR'
wire [1:0] cininstr = instruction [13:12];  // CIN field from IR'
wire [1:0] code = instruction [15:14];     // bits from IR': must be 11 for ARM instruction

//our wire
wire LDA, STA, ADD, SUB, JMP, JMI, JEQ, STP, LDI, LSL, LSR, EQ, MI, skipcondition, MU0;

reg [16:0] alusum; // the 17 bit sum, 1 extra bit so ALU carry out can be extracted
wire cin; // The ALU carry input, determined from instruction as in ISA spec
wire shiftin; // value shifted into bit 15 on LSR, determined as in ISA spec

// do not change
assign alucout = alusum [16]; // carry bit from sum, or shift if instruction = 011
assign aluout = alusum [15:0]; // 16 normal bits from sum

//our assign
assign LDA = ~instruction[15]&~instruction[14]&~instruction[13]&~instruction[12]; 	// LDA 0000 0
assign STA = ~instruction[15]&~instruction[14]&~instruction[13]&instruction[12];		// STA 0001 1
assign ADD = ~instruction[15]&~instruction[14]&instruction[13]&~instruction[12];		// ADD 0010 2
assign SUB = ~instruction[15]&~instruction[14]&instruction[13]&instruction[12];		// SUB 0011 3

assign JMP = ~instruction[15]&instruction[14]&~instruction[13]&~instruction[12];		// JMP 0100 4
assign JMI = ~instruction[15]&instruction[14]&~instruction[13]&instruction[12];		// JMI 0101 5
assign JEQ = ~instruction[15]&instruction[14]&instruction[13]&~instruction[12];		// JEQ 0110 6

assign STP = ~instruction[15]&instruction[14]&instruction[13]&instruction[12];		// STP 0111 7
assign LDI = instruction[15]&~instruction[14]&~instruction[13]&~instruction[12];		// LDI 1000 8 
assign LSL = instruction[15]&~instruction[14]&~instruction[13]&instruction[12];		// LSL 1001 9
assign LSR = instruction[15]&~instruction[14]&instruction[13]&~instruction[12];		// LSR 1010 A
assign skipcondition = ~instruction[11]&~instruction[10]&~instruction[9]&instruction[8] | carrystatus&~instruction[11]&~instruction[10]&instruction[9]&~instruction[8] |  ~carrystatus&~instruction[11]&~instruction[10]&instruction[9]&instruction[8];
assign MU0 = LDA|STA|ADD|SUB|JMP|JEQ|JMI|STP|LDI|LSL|LSR;
//assign EQ = ~ACC_OUT[15]&~ACC_OUT[14]&~ACC_OUT[13]&~ACC_OUT[12]&~ACC_OUT[11]&~ACC_OUT[10]&~ACC_OUT[9]&~ACC_OUT[8]&~ACC_OUT[7]&~ACC_OUT[6]&~ACC_OUT[5]&~ACC_OUT[4]&~ACC_OUT[3]&~ACC_OUT[2]&~ACC_OUT[1]&~ACC_OUT[0];
//assign MI = ACC_OUT[15];


// change as needed
assign wenout = exec1&~MU0;  // correct timing, to do: add enable condition


assign carryen = exec1&cwinstr&~MU0; // correct timing, to do: add enable condition
assign carryout = (alucout | rsdata[0]&instruction[4]&instruction[5]&~instruction[6]) & ~MU0; // this is correct except for XSR
                           // note the special case of rsdata[0] when instruction=011 (XSR)
assign cin = (instruction[15]&instruction[14]&~instruction[13]&instruction[12] | carrystatus&instruction[15]&instruction[14]&instruction[13]&~instruction[12] | 
 rsdata[15]&instruction[15]&instruction[14]&instruction[13]&instruction[12])&~MU0;         


// dummy, to do: replace with correct logic
assign shiftin = (cin&instruction[4]&instruction[5]&~instruction[6])&~MU0;     // dummy, to do: set equal to cin for correct XSR functionality

assign skipout = (skipcondition&~skipstatus)&~MU0;     // dummy, to do: replace with correct logic
assign skipen = exec1&skipcondition&~skipstatus&~MU0 | skipstatus&(LDA | ADD | SUB)&exec2 | skipstatus&~(LDA | ADD | SUB)&exec1;  // correct timing, to do: add enable condition

always @(*) // do not change this line - it makes sure we have combinational logic
  begin
    case (instructioninstr)
      // alusum is 17 bit so we must extend the two instructionerands to 17 bits using 0
      // otherwise Verilog default extension will sign-extend these inputs
      // that create a subtle (not always obvious) error in carry out
      // note that ~ is bit inversion instructionerator.
      3'b000  : alusum = {1'b0,rddata} + {1'b0,rsdata} + cin;   // if instruction = 000
      3'b001  : alusum = {1'b0,rddata} + {1'b0,~rsdata} + cin;  // if instruction = 001
      3'b010  : alusum = {1'b0,rsdata} + cin;                // if instruction = 010
      3'b011  : alusum = {rsdata[0], shiftin, rsdata[15:1]}; // if instruction = 011
      // to do (instructiontional): add additional instructions as cases here
      // available cases: 3'b100,3'b101,3'b110, 3'b111
      default : alusum = 0;// default output for unimplemented instruction values, do not change
    endcase;
  end

endmodule