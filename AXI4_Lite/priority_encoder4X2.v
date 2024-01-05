module BinaryEncoder_4to2 (
  input wire [3:0] binary_input,
  output reg [1:0] encoded_output
);


always @ (binary_input) begin
    casex(binary_input)
        4'b1XXX: encoded_output = 2'b11; // Highest priority input A
        4'b01XX: encoded_output = 2'b10; // Second priority input B
        4'b001X: encoded_output = 2'b01; // Third priority input C
        4'b0001: encoded_output = 2'b00; // Lowest priority input D
    endcase
end

endmodule

