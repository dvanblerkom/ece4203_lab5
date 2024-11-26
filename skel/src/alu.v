module alu #(parameter WIDTH = 32) (
    input wire clk,				    
    input wire [WIDTH-1:0] A, // Operand A
    input wire [WIDTH-1:0] B, // Operand B
    input wire [2:0] 	   alu_op, // ALU operation selector
    output reg [WIDTH-1:0] result   // ALU result
);

// ALU operation codes
localparam ALU_ADD  = 3'b0000; // Addition
localparam ALU_SUB  = 3'b0001; // Subtraction
localparam ALU_AND  = 3'b0010; // Bitwise AND
localparam ALU_OR   = 3'b0011; // Bitwise OR
localparam ALU_XOR  = 3'b0100; // Bitwise XOR
localparam ALU_SLL  = 3'b0101; // Shift Left Logical
localparam ALU_SRL  = 3'b0110; // Shift Right Logical
localparam ALU_SRA  = 3'b0111; // Shift Right Arithmetic

reg [WIDTH-1:0] 	    calc;
reg [WIDTH-1:0] 	    inA;
reg [WIDTH-1:0] 	    inB;
   
always @(posedge clk) begin
   result <= calc;
   inA <= A;
   inB <= B;
end
   
always @(*) begin
    case (alu_op)
        ALU_ADD: calc = inA + inB;
        ALU_SUB: calc = inA - inB;
        ALU_AND: calc = inA & inB;
        ALU_OR:  calc = inA | inB;
        ALU_XOR: calc = inA ^ inB;
        ALU_SLL: calc = inA << inB[3:0];                // Shift amount is lower 5 bits
        ALU_SRL: calc = inA >> inB[3:0];
        ALU_SRA: calc = $signed(inA) >>> inB[3:0];
        default: calc = {WIDTH{1'b0}};              // Default to zero
    endcase
end

endmodule
