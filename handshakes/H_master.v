
module Handshake_master(
 input clk , rst , ready_inp,
 input   wire [7:0] data_in,
 output  reg [7:0] data,
 output  reg valid  
);
  reg reset = 0;
  reg dataChanged = 0;
  reg [7:0]  prevData ;

always @(posedge clk) begin
    if (rst)begin
        reset <= 1;
        data <= 0;
    end
    else
    begin
        reset <= 0;
        data <= data_in;
         if (data_in != data) begin
            dataChanged <= 1'b1;
      end else begin
            dataChanged <= 1'b0;
      end
      prevData <= data;
    end
    end

always @(*)begin
    if (reset)
        valid = 0;
    if (dataChanged)
        valid = 1;
        else
    if (ready_inp == 1 && dataChanged == 0)
        valid = 0 ;  
        else
        valid = valid;      
end 
endmodule 