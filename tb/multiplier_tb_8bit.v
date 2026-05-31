`timescale 1ns/1ps

module multiplier_tb_8bit;
    localparam WIDTH = 16;

    reg  signed [WIDTH-1:0] a, b;
    wire signed [2*WIDTH-1:0] product;
    wire zero;

    multiplier #(WIDTH) uut(a, b, product, zero);

    initial begin
        $dumpfile("waves/multiplier_8bit.vcd");
        $dumpvars(0, uut);

        $monitor("%d * %d = %d", a, b, product);
        a = 5;    b = 3;     #10;
        a = -5;   b = 3;     #10; // a = negative
        a = 7;    b = -4;    #10; // b = negative
        a = -6;   b = -6;    #10; // both negatives
        a = -128; b = 127;   #10; // minimum * maximum
        a = -128; b = -128;  #10; // both minimum
        a = 127;  b = 127;   #10; // both maximum
        a = 0;    b = 25;    #10; // a = 0
        a = -45;  b = 0;     #10; // b = 0
        a = 0;    b = 0;     #10; // both zero
        a = 1;    b = -128;  #10; // identity element
        a = -1;   b = 127;   #10; // sign change

        $finish;
    end

endmodule
