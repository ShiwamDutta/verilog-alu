`timescale 1ns/1ps

module alu_tb_16bit;
    localparam WIDTH = 16;

    reg signed [WIDTH-1:0] a, b;
    reg [3:0] op;

    wire signed [2*WIDTH-1:0] result;
    wire carry, overflow, zero, div_by_zero;

    // DUT
    alu #(WIDTH) uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .carry(carry),
        .overflow(overflow),
        .zero(zero),
        .div_by_zero(div_by_zero)
    );

    initial begin
        $dumpfile("waves/alu_16bit.vcd");
        $dumpvars(0, uut);

        // Arithmetic
        $monitor(
            "%h  %d    %d    %d | %d  %d  %d  %d",
            op, a, b, result, overflow, carry, zero, div_by_zero
        );
        op = 4'h0; a = 32767; b =    1;  #10; // ADD -> overflow
        op = 4'h1; a =  2545; b = 2545;  #10; // SUB -> zero
        op = 4'h2; a =  -485; b =  346;  #10; // MUL
        op = 4'h3; a = 10480; b =    0;  #10; // DIV -> div by zero

        // Logic / passthrough
        $monitor(
            "%h    %h      %h       %h | %d  %d  %d  %d",
            op, a, b, result, overflow, carry, zero, div_by_zero
        );
        op = 4'h4; a = 16'hAAAA; b = 16'h5555;  #10; // AND -> zero
        op = 4'h5; a = 16'hF0F0; b = 16'h0F0F;  #10; // OR
        op = 4'h6; a = 16'h1234; b = 16'h1234;  #10; // XOR -> zero
        op = 4'h7; a = 16'hAA55; b = 16'h1452;  #10; // NOT (b is ignored)
        op = 4'hE; a = 16'h7645; b = 16'h1346;  #10; // return A
        op = 4'hF; a = 16'h7645; b = 16'h1346;  #10; // return B

        $finish;
    end

endmodule
