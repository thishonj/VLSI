`timescale 1ns/1ps

module sequence_detector_tb();

    localparam int CLOCK_PERIOD_NS = 100;
    localparam int RESET_STOP_NS = 150;

    logic clk;
    logic reset_n;

    // Output signals from modules
    logic [3:0] bit_stream;
    logic data_serial;
    logic data_valid;
    logic moore_detected;
    logic mealy_detected;

    // Counters are sequential elements (registers)
    int moore_count = 0;
    int mealy_count = 0;

    // Clock generation
    initial begin : clock_gen
        clk = 0;
        forever #(CLOCK_PERIOD_NS/2) clk = ~clk;
    end

    // Reset Generation and Simulation Termination
    initial begin : rst_gen
        $display("Time: %0t - Starting simulation and holding reset low.", $time);
        reset_n = 0;
        // Assert reset (set reset_n high) after the set amount of ns
        #RESET_STOP_NS reset_n = 1;
        $display("Time: %0t - Reset released. Data streaming should begin.", $time);

        // Wait for the first data_valid signal (data starts being streamed)
        @(posedge data_valid)

        // Wait until data_valid goes low (data finished streaming)
        @(negedge data_valid)
        // Wait an extra clock cycle for the final Moore detection and count
        repeat(2) @(posedge clk);
        
        // Finish the simulation and report results
        $display("-------------------------------------------------------");
        $display("Time: %0t - Simulation complete.", $time);
        $display("Sequence Detection Report (Sequence: 1011)");
        $display("Mealy Total Occurrences: %0d", mealy_count);
        $display("Moore Total Occurrences: %0d", moore_count);
        $display("-------------------------------------------------------");
        $finish;
    end

    // ************ FIXED COUNTER LOGIC ************
    // The counter must be sequential (always_ff) and triggered by the clock.
    always_ff @(posedge clk or negedge reset_n) begin : counters
        if (!reset_n) begin
            mealy_count <= 0;
            moore_count <= 0;
        end else if (data_valid) begin
            // Mealy Counter: Count every time mealy_detected is high
            if (mealy_detected) begin
                mealy_count <= mealy_count + 1;
            end
            
            // Moore Counter: Count every time moore_detected is high
            if (moore_detected) begin
                moore_count <= moore_count + 1;
            end
        end
    end
    // ********************************************

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, sequence_detector_tb);
    end

    // Module instantiations (Cleaned up indentation)
    stimulus_generator #(.FILE_NAME("stimuli.txt"), .SAMPLE_WIDTH(4)) stim_gen (
        // inputs
        .clk(clk),
        .reset_n(reset_n),
        // outputs
        .data_valid(data_valid),
        .stimulus_stream(bit_stream)
    );

    par2ser p2s_conv (
        // inputs
        .clk(clk),
        .reset_n(reset_n),
        .data_parallel(bit_stream),
        // outputs
        .data_serial(data_serial)
    );

    sequence_detector_moore uut_moore (
        // inputs
        .clk(clk),
        .reset_n(reset_n),
        .data_serial(data_serial),
        .data_valid(data_valid),
        // outputs
        .data_out(moore_detected)
    );

    sequence_detector_mealy uut_mealy (
        // inputs
        .clk(clk),
        .reset_n(reset_n),
        .data_serial(data_serial),
        .data_valid(data_valid),
        // outputs
        .data_out(mealy_detected)
    );

endmodule



// `timescale 1ns/1ps

// module sequence_detector_tb();
    
//     localparam int CLOCK_PERIOD_NS = 100;
//     localparam int RESET_STOP_NS = 150;

//     logic clk;
//     logic reset_n;

//     // Output signals from modules
//     logic [3:0] bit_stream;
//     logic data_serial;
//     logic data_valid;
//     logic moore_detected;
//     logic mealy_detected;

//     int moore_count = 0;
//     int mealy_count = 0; 

//     // Clock generation
//     initial begin : clock_gen
//         clk = 0;
//         forever #(CLOCK_PERIOD_NS/2) clk = ~clk;
//     end

//     initial begin : rst_gen
// 	$display("Time: %0t - Starting simulation and holding reset low.", $time);
//         reset_n = 0;
//         // Assert reset after the set amount of ns
//         // (since it's active low reset, 1 will disable it)
//         #RESET_STOP_NS reset_n = 1;
//         $display("Time: %0t - Reset released. Data streaming should begin.", $time);

//         // Data starts being streamed
//         @(data_valid)
//         // Wait for data to finish streaming
//         @(!data_valid)
//         // Finish the simulation
//         $display("-------------------------------------------------------");
//         $display("Time: %0t - Simulation complete.", $time);
//         $display("Sequence Detection Report (Sequence: 1011)");
//         $display("Mealy Total Occurrences: %0d", mealy_count);
//         $display("Moore Total Occurrences: %0d", moore_count);
//         $display("-------------------------------------------------------");
//         $finish;
//     end

//     always_comb begin : counters
// 	//always_ff @(posedge clk) begin : counters
//         // Create counters here to count sequence occurrences for both Mealy and Moore implementations
//       if (mealy_detected && data_valid) begin
//             mealy_count <= mealy_count + 1;
//         end
      
//       if (moore_detected && data_valid) begin
//             moore_count <= moore_count + 1;
//         end
//     end

    
//   	initial begin
//   		$dumpfile("dump.vcd");
//   		$dumpvars(0, sequence_detector_tb);
// 	end


//     // Module instantiations
//     stimulus_generator #(.FILE_NAME("stimuli.txt"), .SAMPLE_WIDTH(4)) stim_gen (
//         // inputs
//         .clk(clk),
//         .reset_n(reset_n),
//         // outputs
//         .data_valid(data_valid),
//         .stimulus_stream(bit_stream)
//         );

//     par2ser p2s_conv (
//         // inputs
//         .clk(clk),
//         .reset_n(reset_n),
//         .data_parallel(bit_stream),
//         // outputs
//         .data_serial(data_serial)
//         );

//     sequence_detector_moore uut_moore (
//         // inputs
//         .clk(clk),
//         .reset_n(reset_n),
//         .data_serial(data_serial),
//         .data_valid(data_valid),
//         // outputs
//         .data_out(moore_detected)
//         );

//     sequence_detector_mealy uut_mealy (
//         // inputs
//         .clk(clk),
//         .reset_n(reset_n),
//         .data_serial(data_serial),
//         .data_valid(data_valid),
//         // outputs
//         .data_out(mealy_detected)
//         );

// endmodule




