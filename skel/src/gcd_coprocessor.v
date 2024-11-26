//=========================================================================
// Template for GCD coprocessor
//-------------------------------------------------------------------------
//

module gcd_coprocessor #( parameter W = 32 ) (
  input clk,
  input reset,

  input operands_val,
  input [W-1:0] operands_bits_A,
  input [W-1:0] operands_bits_B,
  output operands_rdy,

  output result_val,
  output [W-1:0] result_bits,
  input result_rdy

);

  // You should be able to build this with mostly structural verilog!

  // TODO: Define wires


   
  // TODO: Connect gcd_datapath
   gcd_datapath u1 (
		    // Outputs
		    .result_bits_data	(),
		    .B_zero		(),
		    .A_lt_B		(),
		    // Inputs
		    .operands_bits_A	(),
		    .operands_bits_B	(),
		    .clk		(clk),
		    .reset		(reset),
		    .B_mux_sel		(),
		    .A_en		(),
		    .B_en		(),
		    .A_mux_sel		());
   
  // TODO: Connect gcd_control
   gcd_control u2 (
		   // Outputs
		   .result_val		(),
		   .operands_rdy	(),
		   .A_mux_sel		(),
		   .B_mux_sel		(),
		   .A_en		(),
		   .B_en		(),
		   // Inputs
		   .clk			(clk),
		   .reset		(reset),
		   .operands_val	(),
		   .result_rdy		(),
		   .B_zero		().
		   .A_lt_B		());

  // TODO: Connect request FIFOs
   fifo #(.WIDTH((W)), .LOGDEPTH(3)) u3_1 (
	    // Outputs
	    .enq_rdy			(),
	    .deq_val			(),
	    .deq_data			(),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset),
	    .enq_val			(),
	    .enq_data			(),
	    .deq_rdy			());

   fifo #(.WIDTH((W)), .LOGDEPTH(3)) u3_2 (
	    // Outputs
	    .enq_rdy			(),
	    .deq_val			(),
	    .deq_data			(),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset),
	    .enq_val			(),
	    .enq_data			(),
	    .deq_rdy			());

  // TODO: Connect response FIFO
   fifo #(.WIDTH(W), .LOGDEPTH(3)) u4 (
	    // Outputs
	    .enq_rdy			(),
	    .deq_val			(),
	    .deq_data			(),
	    // Inputs
	    .clk			(clk),
	    .reset			(reset),
	    .enq_val			(),
	    .enq_data			(),
	    .deq_rdy			());

endmodule
