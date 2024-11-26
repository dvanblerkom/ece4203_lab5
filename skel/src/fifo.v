//=========================================================================
// FIFO Template
//-------------------------------------------------------------------------
//
//`include "EECS151.v"

module fifo #(parameter WIDTH = 8, parameter LOGDEPTH = 3) (
    input clk,
    input reset,

    input enq_val,
    input [WIDTH-1:0] enq_data,
    output enq_rdy,

    output deq_val,
    output [WIDTH-1:0] deq_data,
    input deq_rdy

);

localparam DEPTH = (1 << LOGDEPTH);

// the buffer itself. Take note of the 2D syntax.
reg [WIDTH-1:0] buffer [DEPTH-1:0];
// read pointer, write pointer
reg [LOGDEPTH-1:0] rptr, wptr;
// is the buffer full? This is needed for when rptr == wptr
reg full, empty;

// Define any additional regs or wires you need (if any) here

// use "fire" to indicate when a valid transaction has been made
wire enq_fire;
wire deq_fire;

wire wptr_next, rptr_next;

assign enq_fire = enq_val & enq_rdy;
assign deq_fire = deq_val & deq_rdy;

assign wptr_next = wptr + 1;
assign rptr_next = rptr + 1;

assign enq_rdy = ~full;
assign deq_val = ~empty;
assign deq_data = buffer[rptr];
   
// Your code here (don't forget the reset!)

always @(posedge clk or posedge reset)
  begin
     if (reset) begin
	wptr <= 0;
	rptr <= 0;
	full <= 0;
	empty <= 1;
     end else begin

	if (enq_fire) begin
	   buffer[wptr] <= enq_data;
	   wptr <= wptr_next; 
	end

	if (deq_fire) begin
	   rptr <= rptr_next;
	end 

	if (~(enq_fire & deq_fire)) begin 
	   if (enq_fire) begin
	      full <= (wptr_next == rptr);
	      empty <= 0;
	   end
	   if (deq_fire) begin
	      full <= 0;
	      empty <= (wptr == rptr_next);
	   end
	end
     end
  end

   
endmodule
