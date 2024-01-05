module SynchronousMullerCElement (
  input [2:0] data_input,
  input clk,
  output reg  Z
);

  always @(posedge clk) begin
    // Müller C-element behavior
  if (data_input == 3'b111)
     Z = 1;
     else
    if (data_input == 3'b000)
     Z = 0;
     else
      Z = Z;
  end

endmodule