module round_robin_arbiter(
  input wire [2:0] req,
  output wire [2:0] grant
);

  // Internal signals
  reg [2:0] priority; // Priority encoder output
  reg [1:0] counter;  // Round-robin counter

  // Priority encoder logic
  always_comb begin
    case (req)
      3'b001: priority = 3'b100; // req_0 has highest priority
      3'b010: priority = 3'b010; // req_1 has highest priority
      3'b100: priority = 3'b001; // req_2 has highest priority
      default: priority = 3'b000; // No requests
    endcase
  end

  // Round-robin counter logic
  always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n)
      counter <= 2'b00;
    else
      counter <= (counter == 2'b11) ? 2'b00 : counter + 1;
  end

  // Grant logic
  assign grant = (priority == counter);

endmodule