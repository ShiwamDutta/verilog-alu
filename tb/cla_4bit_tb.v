`timescale 1ns/1ps

module cla_4bit_tb;

    reg [3:0] a, b;
    reg c0;

    wire [3:0] sum;
    wire c4;
    wire overflow;
    wire zero;

    cla_4bit uut (a, b, c0, sum, c4, overflow, zero);

    initial begin
        $dumpfile("waves/cla4.vcd");
        $dumpvars(0, uut);

        a = 4'h3; b = 4'h2; c0 = 0; #10;
        a = 4'hF; b = 4'h1; c0 = 0; #10;
        a = 4'h3; b = 4'h4; c0 = 1; #10; // carry-in
        a = 4'h5; b = 4'hB; c0 = 0; #10; // zero flag
        a = 4'h7; b = 4'h3; c0 = 0; #10; // overflow (signed)
        a = 4'h0; b = 4'h0; c0 = 0; #10; // all zeros

        $finish;
    end

endmodule
