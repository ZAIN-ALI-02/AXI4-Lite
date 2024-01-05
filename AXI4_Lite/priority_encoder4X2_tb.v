`timescale 1ns / 1ps
`include"priority_encoder4X2.v"
module Testbench_BinaryEncoder_4to2;
    initial begin
        $dumpfile("priority_encoder4X2_tb.vcd");
        $dumpvars(0, Testbench_BinaryEncoder_4to2); 
    end
  // Parameters
  parameter PERIOD = 10;

  // Inputs
  reg [3:0] binary_input;
  
  // Outputs
  wire [1:0] encoded_output;

  // Instantiate the BinaryEncoder_4to2 module
  BinaryEncoder_4to2 uut (
    .binary_input(binary_input),
    .encoded_output(encoded_output)
  );

  // Clock generation
  reg clk = 0;
  always #((PERIOD)/2) clk = ~clk;

  // Test stimulus
  initial begin
    // Initialize inputs
    binary_input = 4'b0000;

    // Apply stimulus
    #10 binary_input = 4'b0001;
    #10 binary_input = 4'b0010;
    #10 binary_input = 4'b0100;
    #10 binary_input = 4'b1000;

    #10 binary_input = 4'b1010;
    #10 binary_input = 4'b0110;
    #10 binary_input = 4'b1100;
    #10 binary_input = 4'b1111;

    #10 $finish;
  end

  // Display output
  always @(posedge clk) begin
    $display("Time=%t binary_input=%b encoded_output=%b", $time, binary_input, encoded_output);
  end

endmodule
