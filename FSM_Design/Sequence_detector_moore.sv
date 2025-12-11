`timescale 1ns/1ps

module sequence_detector_moore (
    input logic clk,
    input logic reset_n,
    input logic data_serial,
    input logic data_valid,
    output logic data_out
    );

    // Define an enumeration type for the states
  typedef enum logic [2:0] {S_0, S_1, S_2, S_3, S_4} state_type; 
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
    
    case (current_state)
      S_0: begin
        if(data_serial == 1'b1)
          next_state = S_1;
        else
          next_state = S_0;
      end
      
      S_1: begin
        if(data_serial == 1'b0)
          next_state = S_2;
        else
          next_state = S_1;
      end
      
      S_2: begin
        if(data_serial == 1'b1) 
          next_state = S_3;
        else
          next_state = S_0;
      end
      
      S_3: begin
        if(data_serial == 1'b1)
          next_state = S_4;
     	 else
			next_state = S_2;
      end
        
       S_4: begin
        if(data_serial == 1'b1)
          next_state = S_1;
     	 else
			next_state = S_2;
      end
      
      default: begin
        next_state = S_0;
      end
    endcase
  end
  assign data_out = (current_state == S_4) ? 1'b1 : 1'b0;
  
endmodule

