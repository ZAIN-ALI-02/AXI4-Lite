`timescale 1ns / 1ps
`include"H_master.v"
`include"H_slave.v"

module H_tb;
    initial begin
        $dumpfile("H_testbench.vcd");
        $dumpvars(0,H_tb); 
    end

   reg clk;                 // Clock input
   reg rst;
   reg ready_input;
   reg [7:0] data_in;
   wire valid;
   wire [7:0]data;
   wire ready;

// Instantiate the uart module    
Handshake_master dut_Handshake_master (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .valid(valid),
    .ready_inp(ready),
    .data(data)
);

// Instantiate the uart module    
Handshake_slave  dut_Handshake_slave (
    .clk(clk),
    .rst(rst),
    .data_in(data),
    .valid(valid),
    .ready_out(ready),
    .ready_in(ready_input)
);


// Clock generation (20 MHz clock)
always begin
    #25 clk = ~clk;
end

// Testbench initialization
initial begin
    clk = 1;
    rst = 1;
    data_in = 8'hxx;
    ready_input = 0;
    #77
    rst = 0;
    data_in = 8'h6B;
    ready_input = 0;
    #100
     ready_input = 1;
     #50
     ready_input = 0;
      data_in = 8'h00;
      ready_input = 1;
      #100
       data_in = 8'hcc;
       #100
       ready_input = 0;
       #500
      ready_input = 0;
      data_in = 8'h00;
      #300
      ready_input = 1;
      #30
      ready_input = 0;

    


    // End simulation
    #5000
    $finish;
end
    endmodule