module AXI4_Lite_slave(
 input clk , 
 input reset ,
// global_signals 

// write_address_channel_signals
 input  wire [31:0] awaddr_slave_input,
 input  wire awvalid_slave_input,
 output reg awready_slave_output,
 input  wire [2:0] awprot_slave_input,
 input  wire awready_slave_input,


// write_data_channel_signals
 input  wire [31:0] wdata_slave_input,
 input  wire wvalid_slave_input,
 output reg wready_slave_output,
 input  wire [3:0] wstrb_slave_input,
 input  wire wready_slave_input,


// write_response_channel_signals
 output   reg     bvalid_slave_output,
 input    wire    bready_slave_input,
 input    wire    [1:0] bresp_slave_input,
output    reg     [1:0] bresp_slave_output,

// read_address_channel_signals
 input  wire [31:0] araddr_slave_input,
 input  wire arvalid_slave_input,
 output reg arready_slave_output,
 input  wire [2:0] arprot_slave_input,
 input  wire arready_slave_input,


// read_data_channel_signals
 output   reg     rvalid_slave_output,
 input    wire    rready_slave_input,
 input    wire    [1:0] rresp_slave_input,
output    reg     [1:0] rresp_slave_output,
 output  reg   [31:0] rdata_slave_output,
 input  wire   [31:0] rdata_slave_input

);






 
 // write_address_channel_code
 reg rst = 0;
 reg [31:0] awaddr_save_reg = 0;
 reg [2:0]  awprot_save_reg = 3'bxxx;

 always @(posedge clk) begin
     if (reset == 0) begin
        rst <= 1;
        awready_slave_output = 0;
     end
     else
     begin
       rst <= 0;
        awready_slave_output <= awready_slave_input;
     end
    end

 always @(*)begin
    if (rst)begin
         awaddr_save_reg = 0;
         awprot_save_reg = 0;
        end
    if (awready_slave_output && awvalid_slave_input)begin
        awprot_save_reg = awprot_slave_input;
        awaddr_save_reg = awaddr_slave_input;  
    end
    else begin
        awaddr_save_reg = awaddr_save_reg;
        awprot_save_reg = awprot_save_reg;
    end
 end

// write_address_channel_code_ends







// write_data_channel_code_starts
 reg [31:0] wdata_save_reg = 0;
 reg [3:0]  wstrb_save_reg = 0;
reg  delay = 0 , delay1 = 0 , delay2 = 0;

  always @(posedge clk) begin
     if (reset == 0) begin
        wready_slave_output = 0;
        bresp_slave_output = 0;
     end
     else
     begin
        wready_slave_output <= wready_slave_input;
        bresp_slave_output <= bresp_slave_input;
     end
     if (bvalid_slave_output == 1)
      delay = 1; 
      else
      delay = 0;
    
      if (delay1 == 1)
      delay2 = 1; 
      else
      delay2 = 0;
end


 always @(*)begin
    if (rst)begin
         wdata_save_reg = 0;
         wstrb_save_reg = 0;
         bvalid_slave_output = 0; 
        end
    if (wready_slave_output && wvalid_slave_input)begin
         wstrb_save_reg = wstrb_slave_input;
         wdata_save_reg = wdata_slave_input;
         // write_data_channel_code_ends

         // write_dataresponse_channel_code_starts
         bvalid_slave_output = 1; 
    end
    else begin
        wdata_save_reg = wdata_save_reg;
        wstrb_save_reg = wstrb_save_reg;
    end

     if (delay == 1)
        delay1 = 1;
        else
        delay1 = 0; 
     
     if (delay2 == 1)
      bvalid_slave_output  = 0; 
      else
      bvalid_slave_output = bvalid_slave_output ; 

 end
 // write_response_channel_code_ends










 // write_address_channel_code
 reg [2:0]  arprot_save_reg = 3'bxxx;
reg  rdelay = 0 , rdelay1 = 0 , rdelay2 = 0;
reg [31:0] araddr_save_reg = 0 ;

 always @(posedge clk) begin
     if (reset == 0) begin
        arready_slave_output = 0;
        rresp_slave_output = 0;
        rdata_slave_output = 0;
     end
     else
     begin
        arready_slave_output <= arready_slave_input;
        rdata_slave_output <= rdata_slave_input;
        rresp_slave_output <= rresp_slave_input;
     end
      
     if (rvalid_slave_output == 1)
      rdelay = 1; 
      else
      rdelay = 0;
    
      if (rdelay1 == 1)
      rdelay2 = 1; 
      else
      rdelay2 = 0;
    end

 always @(*)begin
    if (rst)begin
         araddr_save_reg = 0;
         arprot_save_reg = 0;
         rvalid_slave_output = 0;
        end
    if (arready_slave_output && arvalid_slave_input)begin
        arprot_save_reg = arprot_slave_input;
        araddr_save_reg = araddr_slave_input;  
        rvalid_slave_output = 1;
    end
    else begin
        araddr_save_reg = araddr_save_reg;
        arprot_save_reg = arprot_save_reg;
    end
     if (rdelay == 1)
        rdelay1 = 1;
        else
        rdelay1 = 0; 
     
     if (rdelay2 == 1)
      rvalid_slave_output  = 0; 
      else
      rvalid_slave_output = rvalid_slave_output ; 

 end

// read_data_channel_code_ends
endmodule

