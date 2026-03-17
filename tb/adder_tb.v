`timescale 1ns/1ps

module adder_tb;

    reg  [7:0] a, b;
    wire [7:0] sum;
    wire carry, overflow, zero;

    adder_8bit uut (
        a, b, sum,
        carry, overflow, zero
    );
    
    initial begin
        $dumpfile("waves/adder.vcd");
        $dumpvars(0, uut);

        a = 8'h00; b = 8'h00; #10;  // Zero + Zero
        a = 8'hFF; b = 8'hFF; #10;  // Full overflow
        a = 8'hFF; b = 8'h01; #10;  // Carry through all bits
        a = 8'hAA; b = 8'h55; #10;  // Alternating pattern
        a = 8'h3C; b = 8'hA7; #10;  // Mixed random
        a = 8'h00; b = 8'h7F; #10;  // One operand zero
        a = 8'h81; b = 8'h7E; #10;  // MSB/LSB combination

        $finish;
    end

endmodule
