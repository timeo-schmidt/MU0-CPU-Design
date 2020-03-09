module skip_ctrl
(
input skip,
input signal,
output skip_control

);

assign skip_control = ~skip&signal;

endmodule