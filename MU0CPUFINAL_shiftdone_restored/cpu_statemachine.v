module cpu_statemachine
(
	input[2:0] cs,
	input extra,
	output EXEC1, EXEC2 , FETCH,
	output [2:0] NS
);

	
	assign NS[2] = 0;
	assign NS[1] = (~cs[2]&~cs[1]&cs[0]&extra);
	assign NS[0] = (~cs[0]&~cs[1]&~cs[2]);
	
	assign FETCH = ~cs[2]&~cs[1]&~cs[0];
	assign EXEC1 = ~cs[2]&~cs[1]&cs[0];
	assign EXEC2 = ~cs[2]&cs[1]&~cs[0];

endmodule