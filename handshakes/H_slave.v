module Handshake_slave(
 input clk,
 input rst, 
 input valid, 
 input ready_in,
 input  wire [7:0] data_in,
 output reg ready_out
);
  reg reset =  0;
  reg  [7:0] data;

always @(posedge clk) begin
    if (rst)
        reset <= 1;
    else
    begin
        reset <= 0;
        ready_out <= ready_in;
    end
end

always @(*)begin
    if (reset)begin
        data = 0;
        ready_out = 0;
    end
    if (ready_out && valid)
        data = data_in;
    else
        data = data;
end   
endmodule 
