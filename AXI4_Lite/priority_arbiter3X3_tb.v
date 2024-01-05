`timescale 1ns/1ns
`include"priority_arbiter3X3.v"
module Testbench_PriorityArbiter_3to3;
    initial begin
        $dumpfile("priority_arbiter3X3_tb.vcd");
        $dumpvars(0, Testbench_PriorityArbiter_3to3); 
    end

  // Parameters
  parameter PERIOD = 10;

  // Inputs
  reg [2:0] request;
  
  // Outputs
  wire [2:0] grants;

  // Instantiate the PriorityArbiter_3to3 module
  PriorityArbiter_3to3 uut (
    .request(request),
    .grants(grants)
  );

  // Clock generation
  reg clk = 0;
  always #((PERIOD)/2) clk = ~clk;

  // Test stimulus
  initial begin
    // Initialize inputs
    request = 3'b000;

    // Apply stimulus
    #10 request = 3'b001; // Priority 1
    #10 request = 3'b010; // Priority 2
    #10 request = 3'b011; // Priority 3
    #10 request = 3'b100; // Priority 1
    #10 request = 3'b101; // Priority 2
    #10 request = 3'b110; // Priority 3
    #10 request = 3'b111; // Priority 1


    // No request or invalid request
    #10 request = 3'b000;

    #10 $finish;
  end

  // Display output
  always @(posedge clk) begin
    $display("Time=%t request=%b winner=%b", $time, request, grants);
  end

endmodule