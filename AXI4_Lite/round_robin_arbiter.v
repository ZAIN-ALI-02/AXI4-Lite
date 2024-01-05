`timescale 1ns / 1ps

module round_robin_arbiter(
    
    input [7:0] data_input,
    input ready_input,
    output reg [7:0] data_output,
    output reg ready_output,
    input [7:0] address_of_register,
    input clk, 
    input wire rst,
    // // round robin
    input [1:0] req_sigs,
    output reg [1:0] grant_sigs,

     // handshaking for master1 
      output reg  out_ready_m1,  
      input   [7:0] in_data_m1,
      input    wire in_valid_m1,
     // handshaking for salve1 
      output reg   [7:0] out_data_s1,
      output reg     out_valid_s1,
      input wire in_ready_s1,


     // handshaking for master2 
      output reg  out_ready_m2,  
      input   [7:0] in_data_m2,
      input    wire in_valid_m2,
     // handshaking for slave2 
      output reg   [7:0] out_data_s2,
      output reg     out_valid_s2,
      input wire    in_ready_s2


     );

reg [1:0] curr_state = 0; 
reg [1:0] next_state;
reg [7:0] slave_address_1 = 8'hAA;
reg [7:0] slave_address_2 = 8'hBB;

parameter [1:0] IDLE = 3'b00;
parameter [1:0] STATE_0 = 3'b01;
parameter [1:0] STATE_1 = 3'b10;


always @(posedge clk or posedge rst) begin
  if(rst)
    curr_state <= IDLE;
  else 
    curr_state <= next_state;
end

always @(*) begin
  
  case(curr_state)

    IDLE: begin
            if(req_sigs[0])
              next_state = STATE_0;
            else if(req_sigs[1])
              next_state = STATE_1;  
            else
              next_state = IDLE;
          end

    STATE_0: begin
               if(req_sigs[1])
                 next_state = STATE_1;  
               else if(req_sigs[0])
                 next_state = STATE_0;
               else
                 next_state = IDLE;
             end

    STATE_1: begin
            if(req_sigs[0])
              next_state = STATE_0;
            else if(req_sigs[1])
              next_state = STATE_1;  
            else
              next_state = IDLE;
          end

   default: begin
             if(req_sigs[0])
               next_state = STATE_0;
             else if(req_sigs[1])
               next_state = STATE_1;
             else
               next_state = IDLE;
           end

  endcase
end

always @(*) begin
  
  case(curr_state)

  IDLE : begin
      grant_sigs = 2'b00;
      out_valid_s2   = 0;
      out_data_s2    = 0;
      out_ready_m2   = 0;
      out_valid_s1   = 0;
      out_data_s1    = 0;
      out_ready_m1   = 0;
      data_output    = 0;
      ready_output   = 0;
  end
  

    
    STATE_0 : begin
        grant_sigs = 2'b01; // master1
      
        if (address_of_register == slave_address_1)begin // master1 to slave1
       out_ready_m1   =  in_ready_s1;
       out_data_s1    =  in_data_m1;
       out_valid_s1   =  in_valid_m1;
       data_output = data_input;
       ready_output = ready_input;
        end
    

        else if (address_of_register == slave_address_2) begin // master1 with slave 2
       out_ready_m1   =  in_ready_s2;
       out_data_s2    =  in_data_m1;
       out_valid_s2   =  in_valid_m1;
       data_output = data_input;
       ready_output = ready_input;
        end
        end

    STATE_1 : begin
    grant_sigs = 2'b10; 
     if (address_of_register == slave_address_1)begin // master1 to slave1
       out_ready_m2   =  in_ready_s1;
       out_data_s1    =  in_data_m2;
       out_valid_s1   =  in_valid_m2;
       data_output = data_input;
       ready_output = ready_input;
        end
    

        else if (address_of_register == slave_address_2) begin // master1 with slave 2
       out_ready_m2   =  in_ready_s2;
       out_data_s2    =  in_data_m2;
       out_valid_s2   =  in_valid_m2;
       data_output = data_input;
       ready_output = ready_input; 
        end
        end

    default : begin 
       grant_sigs = 2'b00;
      out_valid_s2 = out_valid_s2;
      out_data_s2 = out_data_s2;
      out_ready_m2 = out_ready_m2;
      out_valid_s1 = out_valid_s1;
      out_data_s1 = out_data_s1;
      out_ready_m1 = out_ready_m1;
      data_output = data_output;
      ready_output = ready_output;
    end 
    
  endcase
end


endmodule
