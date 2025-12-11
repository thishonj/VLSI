`timescale 1ns/1ps

module sequence_detector_mealy (
    input logic clk,
    input logic reset_n,
    input logic data_serial,
    input logic data_valid,
    output logic data_out
    );

    // Define an enumeration type for the states
  typedef enum logic [2:0] {S_0, S_1, S_2, S_3 } state_type; 
  state_type current_state, next_state;
  
  logic mealy_output;//internal signal for mealy output
  
  always_ff @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
      current_state <= S_0;
    end else if (data_valid) begin
      current_state <= next_state;
      end
  end
  
  always_comb begin
    next_state = current_state;
   // mealy_output = 1'b0;
    
    case (current_state)
      S_0: begin
        if(data_serial == 1'b1) begin
          next_state = S_1;
          data_out = 1'b0;
        end else begin
          next_state = S_0;
          data_out = 1'b0;
        end
      end
      
      S_1: begin
        if(data_serial == 1'b1) begin
          next_state = S_1;
          data_out = 1'b0;
        end else begin
          next_state = S_2;
          data_out = 1'b0;
        end
      end
      
      S_2: begin
        if(data_serial == 1'b1) begin
          next_state = S_3;
          data_out = 1'b0;
        end else begin
          next_state = S_0;
          data_out = 1'b0;
        end
      end
      
      S_3: begin
        if(data_serial == 1'b1) begin
          next_state = S_1;
          data_out = 1'b1;
      end else begin
			next_state = S_2;
        	data_out = 1'b0;
      end
      end
      
      default: begin
        next_state = S_0;
        data_out = 1'b0;
      end
    endcase
  end
      
   //assign data_out = mealy_output;
  
endmodule
