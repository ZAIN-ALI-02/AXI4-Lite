module AXI4_Lite_master(
   // global_signals 
 input clk, 
 input reset,


 // write_address_channel_signals
 output  reg   [31:0] awaddr_master_output,
 output  reg   awvalid_master_output,
 input   wire  awready_master_input,
 input  wire   [31:0] awaddr_master_input,
 output  reg   [2:0] awprot_master_output,
 input  wire   [2:0] awprot_master_input,



 // write_data_channel_signals
 output  reg   [31:0] wdata_master_output,
 output  reg   wvalid_master_output,
 input   wire  wready_master_input,
 input  wire   [31:0] wdata_master_input,
 output  reg   [3:0] wstrb_master_output,
 input  wire   [3:0] wstrb_master_input,

 // write_response_channel_signals
 input   wire   bvalid_master_input,
 output  reg    bready_master_output,
 input   wire   [1:0] bresp_master_input,



 // read_address_channel_signals
 output  reg   [31:0] araddr_master_output,
 output  reg   arvalid_master_output,
 input   wire  arready_master_input,
 input  wire   [31:0] araddr_master_input,
 output  reg   [2:0] arprot_master_output,
 input  wire   [2:0] arprot_master_input,


 // read_data_channel_signals
 input   wire   rvalid_master_input,
 output  reg    rready_master_output,
 input   wire   [1:0] rresp_master_input,
input  wire   [31:0] rdata_master_input,
input wire rready_master_input

);


 // write_address_channel_code
 reg rst = 0;
 reg addressChanged = 0;

 always @(posedge clk) begin
     if (reset == 0)begin
        awaddr_master_output <= 32'h00000000;
        awprot_master_output <= 0;
        rst <= 1;
     end
     else
     begin
       rst = 0;
       awaddr_master_output <= awaddr_master_input;
       awprot_master_output <= awprot_master_input;
     end
       if (awaddr_master_output != awaddr_master_input)begin
           addressChanged <= 1'b1;
      end else begin
            addressChanged <= 1'b0;
      end
 end

 always @(*)begin
    if (rst)
        awvalid_master_output  = 0;
    if (addressChanged)begin
        awvalid_master_output  = 1;
    end
    else
    if (awready_master_input == 1 && addressChanged == 0)
        awvalid_master_output = 0;
    else
        awvalid_master_output = awvalid_master_output; 
 end
 
// write_address_channel_code_ends





// write_data_channel_code_starts
reg dataChanged = 0;
reg [1:0]  bresp_master_save_register = 0;

always @(posedge clk) begin
     if (reset == 0)begin
        wdata_master_output <= 32'h00000000;
        wstrb_master_output <= 0;
     end
     else
     begin
       wdata_master_output <= wdata_master_input;
       wstrb_master_output <= wstrb_master_input;
     end
       if (wdata_master_output != wdata_master_input)begin
           dataChanged <= 1'b1;
      end else begin
            dataChanged <= 1'b0;
      end
 end

 always @(*)begin
    bready_master_output = 1;
    if (rst)
        wvalid_master_output  = 0;
    if (dataChanged)begin
        wvalid_master_output  = 1;
    end
    else
    if (wready_master_input == 1 && dataChanged == 0)begin
        wvalid_master_output = 0;
        
    end
    else
        wvalid_master_output = wvalid_master_output; 

    if (bvalid_master_input && bready_master_output)begin
       bresp_master_save_register = bresp_master_input;
    end
    else begin
       bresp_master_save_register = bresp_master_save_register;
       bready_master_output = bready_master_output;  
    end
end
 // write_data_channel_code_ends
// write_response_channel_code_starts
// write_response_channel_code_ends




 // read_address_channel_code
 reg [31:0] rdata_master_save_register ;
 reg  [1:0] rresp_master_save_register ;
 reg read_addressChanged = 0;

 always @(posedge clk) begin
     if (reset == 0)begin
        araddr_master_output <= 32'h00000000;
        arprot_master_output <= 0;
        rready_master_output <=0;
     end
     else
     begin
        rready_master_output <= rready_master_input;
       araddr_master_output <= araddr_master_input;
       arprot_master_output <= arprot_master_input;
     end
       if (araddr_master_output != araddr_master_input)begin
           read_addressChanged <= 1'b1;
      end else begin
            read_addressChanged <= 1'b0;
      end
 end

 always @(*)begin
    if (rst)begin
        arvalid_master_output  = 0;
        rdata_master_save_register = 0;
        rresp_master_save_register = 0;
    end
    if (read_addressChanged)begin
        arvalid_master_output  = 1;
    end
    else
    if (arready_master_input == 1 && read_addressChanged == 0)
        arvalid_master_output = 0;
    else
        arvalid_master_output = arvalid_master_output; 

    if (rvalid_master_input == 1 && rready_master_output == 1) begin
        rdata_master_save_register = rdata_master_input;
        rresp_master_save_register = rresp_master_input;
    end
    else begin
       rdata_master_save_register = rdata_master_save_register; 
       rresp_master_save_register = rresp_master_save_register;
    end
 end
 
// read_address_channel_code_ends
endmodule
