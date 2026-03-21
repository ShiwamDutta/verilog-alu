`timescale 1ns/1ps

module alu_8bit_tb;

    reg signed [7:0] a, b;
    reg [3:0] op;

    wire signed [15:0] result;
    wire carry, overflow, zero, div_by_zero;

    // DUT
    alu_8bit uut (
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
        $dumpfile("waves/alu.vcd");
        $dumpvars(0, uut);

        $monitor("%h  %d    %d    %d | %d  %d  %d  %d",
            op, a, b, result, overflow, carry, zero, div_by_zero);

        // ADD
        op=4'h0; a=10; b=5;    #10;
        op=4'h0; a=200; b=100; #10;  // overflow

        // SUB
        op=4'h1; a=20; b=5;  #10;
        op=4'h1; a=5; b=20;  #10;    // negative result

        // MUL
        op=4'h2; a=7; b=6;   #10;
        op=4'h2; a=15; b=15; #10;

        // DIV
        op=4'h3; a=20; b=4;  #10;
        op=4'h3; a=7;  b=2;  #10;
        op=4'h3; a=10; b=0;  #10;    // divide by zero

        $monitor("%h    %h      %h      %h | %d  %d  %d  %d",
            op, a, b, result, overflow, carry, zero, div_by_zero);
        
        // AND
        op=4'h4; a=8'hAA; b=8'h55; #10;

        // OR
        op=4'h5; a=8'hF0; b=8'h0F; #10;

        // XOR
        op=4'h6; a=8'hFF; b=8'h0F; #10;

        // NOT
        op=4'h7; a=8'h00; b=8'hFF; #10;
        op=4'h7; a=8'hFF; b=8'h00; #10;

        // PASS A
        op=4'hE; a=123; b=45; #10;

        // PASS B
        op=4'hF; a=123; b=45; #10;

        $finish;
    end

endmodule
