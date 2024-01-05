module PriorityArbiter_3to3 (
  input [2:0] request,
  output reg [2:0] grants
);

  always @(request) begin
    casex (request)
      3'bXX1: grants = 3'b001; // Priority 1
      3'bX10: grants = 3'b010; // Priority 2
      3'b100: grants = 3'b100; // Priority 3
      default: grants = 3'b000; // No request or invalid request, no grants
    endcase
  end

endmodule