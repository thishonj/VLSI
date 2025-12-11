`timescale 1ns/1ps

module par2ser (
    input logic clk,
    input logic reset_n,
    input logic [3:0] data_parallel,
    output logic data_serial
);

    // Define the needed internal signals
    logic [3:0] sample_shifter, sample_shifter_next;
    logic [1:0] counter, counter_next;
    logic conversion_start;
    // For output signal
    logic serial;

    // Type: sequential
    // Purpose: Implement the registers in the sequence decoder
    always_ff @(posedge clk or negedge reset_n) begin : registers
        if (!reset_n) begin
            sample_shifter <= '0;
            counter <= '0;
        end else begin
            sample_shifter <= sample_shifter_next;
            counter <= counter_next;
        end
    end

    // Increment code
  	// ???

    // Output logic
    // ???

    // Type: Combinational
    // Purpose: Parallel to serial conversion
    always_comb begin : combinational_shifter
        // Default values (why are they needed?)
        sample_shifter_next = sample_shifter;
		counter_next = counter;
      	conversion_start = 1'b0;

        // Write the code for parallel to serial conversion
      serial = sample_shifter[0];
      
      if(counter == 2'd0) begin
        sample_shifter_next = data_parallel;
        counter_next = 2'd3;
      end else begin
        sample_shifter_next = sample_shifter >> 1;
        counter_next = counter - 1;
      end
      end 
  	  assign data_serial = serial;
endmodule
