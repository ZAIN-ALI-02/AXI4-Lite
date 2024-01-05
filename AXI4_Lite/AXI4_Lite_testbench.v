`timescale 1ns / 1ps
`include"AXI4_Lite_master.v"
`include"AXI4_Lite_slave.v"

module AXI4_Lite_tb;
    initial begin
        $dumpfile("AXI4_Lite_testbench.vcd");
        $dumpvars(0, AXI4_Lite_tb); 
    end

// registers used to pass the input in master and slave 
   reg clk;                 
   reg reset;
   //global signals  

   //write_address_registers 
   reg aready_input;
   reg [31:0] address_in;
   reg [2:0] awprot_in;


   // wire that connects the master and slave.
   // write_address_wires
   wire avalid;
   wire [31:0]address;
   wire aready;
   wire [2:0] awprot;

      //write_data_registers 
   reg dready_input;
   reg [31:0] data_in;
   reg [3:0] dwstrb_in;

   // write_data_wires
   wire dvalid;
   wire [31:0]data;
   wire dready;
   wire [3:0] dwstrb;


  //write_response_registers 
   reg [1:0] bresp_input;

   // write_response_wires
   wire rvalid;
   wire rready;
   wire [1:0] bresp;

    //write_address_registers 
   reg raready_input;
   reg [31:0] raddress_in;
   reg [2:0] raprot_in;


   // wire that connects the master and slave.
   // write_address_wires
   wire ravalid;
   wire [31:0]raddress;
   wire raready;
   wire [2:0] raprot;

    //read_response_registers 
   reg [1:0] rresp_input;
   reg [31:0] rdata_input;
   reg rready_input;


   // read_response_wires
   wire rrvalid;
   wire rrready;
   wire [1:0] rresp;
   wire [31:0] rdata;

   
   

// Instantiate the AXI4_Lite_master module    

AXI4_Lite_master dut_AXI4_Lite_master (
    .clk(clk),
    .reset(reset),
    // global signals 


     //write_address_signals_master_starts
    .awaddr_master_input(address_in),
    .awaddr_master_output(address),
    .awvalid_master_output(avalid),
    .awready_master_input(aready),
    .awprot_master_output(awprot),
    .awprot_master_input(awprot_in),
    // write_address_signals_master_ends

         //write_data_signals_master_starts
    .wdata_master_input(data_in),
    .wdata_master_output(data),
    .wvalid_master_output(dvalid),
    .wready_master_input(dready),
    .wstrb_master_output(dwstrb),
    .wstrb_master_input(dwstrb_in),
    // write_data_signals_master_ends

    // write_response_signals_master_starts
    .bvalid_master_input(rvalid),
    .bready_master_output(rready),
    .bresp_master_input(bresp),
    // write_response_signals_master_ends


    //read_address_signals_master_starts
    .araddr_master_input(raddress_in),
    .araddr_master_output(raddress),
    .arvalid_master_output(ravalid),
    .arready_master_input(raready),
    .arprot_master_output(raprot),
    .arprot_master_input(raprot_in),
    // read_address_signals_master_ends


       


 //read_data_signals_master_starts
    .rdata_master_input(rdata),
    .rresp_master_input(rresp),
    .rready_master_input(rready_input),
    .rready_master_output(rrready),
    .rvalid_master_input(rrvalid)
    // read_data_signals_master_ends


);

// Instantiate the AXI4_Lite_slave module    
AXI4_Lite_slave  dut_AXI4_Lite_slave (
    .clk(clk),
    .reset(reset),
    // global signals 

     //write_address_signals_slave_starts
    .awaddr_slave_input(address),
    .awvalid_slave_input(avalid),
    .awready_slave_output(aready),
    .awready_slave_input(aready_input),
    .awprot_slave_input(awprot),
    // write_address_signals_slave_ends

    //write_address_signals_slave_starts
    .wdata_slave_input(data),
    .wvalid_slave_input(dvalid),
    .wready_slave_output(dready),
    .wready_slave_input(dready_input),
    .wstrb_slave_input(dwstrb),
    // write_address_signals_slave_ends


    //write_response_signals_slave_starts
    .bresp_slave_input(bresp_input),
    .bresp_slave_output(bresp),
    .bready_slave_input(rready),
    .bvalid_slave_output(rvalid),
    // write_response_signals_slave_ends

    //write_address_signals_slave_starts
    .araddr_slave_input(raddress),
    .arvalid_slave_input(ravalid),
    .arready_slave_output(raready),
    .arready_slave_input(raready_input),
    .arprot_slave_input(raprot),
    // write_address_signals_slave_ends

       //read_data_signals_slave_starts
    .rdata_slave_input(rdata_input),
    .rdata_slave_output(rdata),
    .rresp_slave_input(rresp_input),
    .rresp_slave_output(rresp),
    .rready_slave_input(rrready),
    .rvalid_slave_output(rrvalid)
    // read_data_signals_slave_ends
);


// Clock generation (20 MHz clock)
always begin
    #25 clk = ~clk;
end

// Testbench initialization
initial begin
    clk = 1;
    reset = 0;
    address_in = 32'hxxxxxxxx;
    awprot_in = 3'b000;
   aready_input = 0;
    #200
    reset = 1;
    address_in = 32'h6BBBBBBB;
    awprot_in = 3'b111;
    #200
    aready_input = 1;
    #100
     aready_input = 0;
     #350
     aready_input = 0;
      address_in = 32'h10100111;
      awprot_in = 3'b000;
      aready_input = 0;
      #300
      aready_input = 1;
      #100
       aready_input = 0;
       #400
       address_in = 32'hCCCCCCCC;
       awprot_in = 3'b111;
       #200
       aready_input = 1;
       #100
      aready_input = 0;
    // End simulation
    #20000
    $finish;
end

   initial begin
    dready_input = 0;
    data_in = 0;
    bresp_input = 0;
    #2020
    data_in = 32'h6BBBBBBB;
    dwstrb_in = 4'b1111;
    dready_input = 0;
    bresp_input = 1;
    #500
     dready_input = 1;
     #100
     dready_input = 0;
     #400
    data_in = 32'h00000000;
    dwstrb_in = 4'b0000;
    dready_input = 0;
    #200
    dready_input = 1;
    #200
    dready_input = 0;
      #500
       data_in = 32'hCCCCCCCC;
       dwstrb_in = 4'b1111;
       #100
       dready_input = 1;
       #500
      dready_input = 0;
    // End simulation
    #20000
    $finish;
end
 


 initial begin
     raddress_in = 32'h00000000;
     raprot_in = 3'b000;
     raready_input = 0;
    #5000
    raprot_in = 3'b000;
   raready_input = 0;
    #577
    raddress_in = 32'h6BBBBBBB;
    raprot_in = 3'b111;
    #200
    raready_input = 1;
    #300
     raready_input = 0;
     #450
      raready_input = 0;
      raddress_in = 32'h00000000;
      raprot_in = 3'b000;
      raready_input = 0;
      #500
      raready_input = 1;
      #150
       raready_input = 0;
       #800
       raddress_in = 32'hCCCCCCCC;
       raprot_in = 3'b111;
       #300
       raready_input = 1;
       #500
      raready_input = 0;
    // End simulation
    #20000
    $finish;
 end


     initial begin
     rdata_input = 32'h00000000;
     rresp_input = 2'b00;
     rready_input = 1;
    #5000
     rresp_input = 2'b00;
   rready_input = 1;
    #577
    rdata_input = 32'h6BBBBBBB;
    rready_input = 2'b11;
    #200
    rready_input = 1;
    #300
     rready_input = 1;
     #450
      rready_input = 1;
      rdata_input = 32'h00000000;
      rresp_input = 2'b00;
      rready_input = 1;
      #500
      rready_input = 1;
      #150
       rready_input = 1;
       #800
       rdata_input = 32'hCCCCCCCC;
       rresp_input = 2'b11;
       #300
       rready_input = 1;
       #500
      rready_input = 1;
    // End simulation
    #20000
    $finish;
end
    endmodule