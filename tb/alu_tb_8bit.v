`timescale 1ns/1ps

module alu_tb_8bit;
    localparam WIDTH = 8;

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
        $dumpfile("waves/alu_8bit.vcd");
        $dumpvars(0, uut);

        $monitor(
            "%h  %d    %d    %d | %d  %d  %d  %d",
            op, a, b, result, overflow, carry, zero, div_by_zero
        );
        op = 4'h0; a = 127; b =  1;  #10; // ADD -> overflow
        op = 4'h1; a =  25; b = 25;  #10; // SUB -> zero
        op = 4'h2; a =  -5; b =  3;  #10; // MUL
        op = 4'h3; a = 100; b =  0;  #10; // DIV -> div by zero

        $monitor(
            "%h    %h      %h      %h | %d  %d  %d  %d",
            op, a, b, result, overflow, carry, zero, div_by_zero
        );
        op = 4'h4; a = 8'hAA; b = 8'h55;  #10; // AND -> alternating pattern
        op = 4'h5; a = 8'hF0; b = 8'h0F;  #10; // OR -> all set
        op = 4'h6; a = 8'h26; b = 8'h26;  #10; // XOR -> all zero
        op = 4'h7; a = 8'hAA; b = 8'hxx;  #10; // NOT
        op = 4'hE; a = 8'h76; b = 8'h13;  #10; // return A
        op = 4'hF; a = 8'h76; b = 8'h13;  #10; // return B

        $finish;
    end

endmodule
