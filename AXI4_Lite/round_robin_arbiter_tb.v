`include "round_robin_arbiter.v"
`include"H_master.v"
`include"H_slave.v"

`timescale 1ns / 1ps

module round_robin_arbiter_tb();

   reg clk;                 // Clock input
   reg rst;
   reg ready_input;
   reg [7:0] data_in;
   wire [7:0] data_wire;
   wire ready_wire;

   // master 1 
   wire [7:0] data_m1_m_to_a;
   wire valid_m1_m_to_a;
   wire ready_m1_m_to_a;

   // slave 1
   wire [7:0] data_s1_a_to_s;
   wire valid_s1_a_to_s;
   wire ready_s1_a_to_s;

   // master 2 
   wire [7:0] data_m2_m_to_a;
   wire valid_m2_m_to_a;
   wire ready_m2_m_to_a;

   // slave 2
   wire [7:0] data_s2_a_to_s;
   wire valid_s2_a_to_s;
   wire ready_s2_a_to_s;


reg [7:0] address_of_register_input;
reg [1:0] req_sigs;
wire [1:0] grant_sigs; 



 initial begin
        $dumpfile("round_robin_arbiter_tb.vcd");
        $dumpvars(0, round_robin_arbiter_tb); 
    end


round_robin_arbiter round_robin_arbiter (
    .clk(clk),
    .rst(rst),
    .grant_sigs(grant_sigs),
    .req_sigs(req_sigs), 
    .address_of_register(address_of_register_input),
    .data_input(data_in),
    .ready_input(ready_input),
    .data_output(data_wire),
    .ready_output(ready_wire),
      //m1
      .out_ready_m1(ready_m1_m_to_a),
      .in_data_m1(data_m1_m_to_a),
      .in_valid_m1(valid_m1_m_to_a),
      // s1
      .in_ready_s1(ready_s1_a_to_s),
      .out_data_s1(data_s1_a_to_s),
      .out_valid_s1(valid_s1_a_to_s),
        //m2
      .out_ready_m2(ready_m2_m_to_a),
      .in_data_m2(data_m2_m_to_a),
      .in_valid_m2(valid_m2_m_to_a),
       //s2
      .in_ready_s2(ready_s2_a_to_s),
      .out_data_s2(data_s2_a_to_s),
      .out_valid_s2(valid_s2_a_to_s)
);

  
Handshake_master dut_Handshake_master_1 (
    .clk(clk),
    .rst(rst),
    .data_in(data_wire),
    .valid(valid_m1_m_to_a),
    .ready_inp(ready_m1_m_to_a),
    .data(data_m1_m_to_a)
);
Handshake_master dut_Handshake_master_2 (
    .clk(clk),
    .rst(rst),
    .data_in(data_wire),
    .valid(valid_m2_m_to_a),
    .ready_inp(ready_m2_m_to_a),
    .data(data_m2_m_to_a)
);
Handshake_slave  dut_Handshake_slave_1 (
    .clk(clk),
    .rst(rst),
    .ready_in(ready_wire),
    .data_in(data_s1_a_to_s),
    .ready_out(ready_s1_a_to_s),
    .valid(valid_s1_a_to_s)
);
Handshake_slave  dut_Handshake_slave_2 (
    .clk(clk),
    .rst(rst),
    .ready_in(ready_wire),
    .data_in(data_s2_a_to_s),
    .ready_out(ready_s2_a_to_s),
    .valid(valid_s2_a_to_s)
);


always #5 clk = ~clk;

initial begin
  clk = 1;
  req_sigs = 2'b00;
  data_in = 8'h00;

  #1000;
   req_sigs = 2'b01;
   address_of_register_input = 8'hAA;
    ready_input = 0;
    rst = 1;
    data_in = 8'hAA;
    #10;
    rst = 0;
    ready_input = 1;
    #100;
    data_in = 8'hBB;
    #100;
    data_in = 8'hCC;
    #200;
   address_of_register_input = 8'hBB;
    data_in = 8'hDD;
    #100;
    data_in = 8'hEE;
    #100;
    data_in = 8'hFF;
   #300;

  req_sigs = 2'b10;
   address_of_register_input = 8'hAA;

    data_in = 8'hFF;
    #100;
    data_in = 8'hEE;
    #100;
    data_in = 8'hDD;
    #200;
   address_of_register_input = 8'hBB;
    data_in = 8'hCC;
    #100;
    data_in = 8'hBB;
    #100;
    data_in = 8'hAA;
   #300;

  address_of_register_input = 8'hAA;
  req_sigs = 2'b11;
    data_in = 8'h55;
    #100;
    data_in = 8'h66;
    #100;
    data_in = 8'h77;
    #200;
    data_in = 8'h88;
    #100;
    data_in = 8'h99;
  #20000;
  $finish;
end

initial begin
  $monitor("req_sigs = %b, grant_sigs = %b", req_sigs, grant_sigs);
end
    endmodule