`timescale 1ns/1ns
`include"synchronous_muller_C_element.v"
module Testbench_SynchronousMullerCElement;



    initial begin
        $dumpfile("synchronous_muller_C_element_tb.vcd");
        $dumpvars(0, Testbench_SynchronousMullerCElement); 
    end


  // Parameters
  parameter PERIOD = 10;

  // Inputs
  reg [2:0] data_input;
  reg clk;

  // Outputs
  wire  Z;

  // Instantiate the SynchronousMullerCElement module
  SynchronousMullerCElement uut (
    .data_input(data_input),
    .clk(clk),
    .Z(Z)
  );

  // Clock generation
  initial begin
    clk = 1;
    forever #((PERIOD)/2) clk = ~clk;
  end

  // Test stimulus
  initial begin

    // Apply stimulus
    data_input = 3'b000; // Middle bit is 1, output should follow data_input
    #10 data_input = 3'b001; // Least significant bit is 0, output should follow data_input
    #10 data_input = 3'b010; // Most significant bit is 1, output should follow data_input
    #10 data_input = 3'b011; // Least and most significant bits are 1, output should follow middle bit
        // Apply stimulus
    #10 data_input = 3'b100; // Middle bit is 1, output should follow data_input
    #10 data_input = 3'b101; // Least significant bit is 0, output should follow data_input
    #10 data_input = 3'b110; // Most significant bit is 1, output should follow data_input
    #10 data_input = 3'b111; // Least and most significant bits are 1, output should follow middle bit

    #10 data_input = 3'b001; // Least significant bit is 0, output should follow data_input
    #10 data_input = 3'b010; // Most significant bit is 1, output should follow data_input
    #10 data_input = 3'b011; // Least and most significant bits are 1, output should follow middle bit
        // Apply stimulus
    #10 data_input = 3'b100; // Middle bit is 1, output should follow data_input
    #10 data_input = 3'b101; // Least significant bit is 0, output should follow data_input
    #10 data_input = 3'b110; // Most significant bit is 1, output should follow data_input
    data_input = 3'b000; // Middle bit is 1, output should follow data_input
    #300
    data_input = 3'b111; // Middle bit is 1, output should follow data_input
    #1000 $finish;
  end

  // Display output
  always @(posedge clk) begin
    $display("Time=%t data_input=%b Z=%b", $time, data_input, Z);
  end

endmodule