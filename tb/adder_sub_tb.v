`timescale 1ns/1ps

module adder_sub_8bit_tb;
    localparam WIDTH = 8;

    reg  signed [WIDTH-1:0] x, y;
    wire signed [WIDTH-1:0] z;

    reg  sub;
    wire c, v, zero;

    adder_sub #(WIDTH) uut (x, y, sub, z, c, v, zero);

    initial begin
        $dumpfile("waves/adder_sub.vcd");
        $dumpvars(0, uut);

        // Test addition
        $monitor("%d + %d = %d", x, y, z);
        sub = 0;
        x = 10;   y = 5;   #10;
        x = 0;    y = 0;   #10;
        x = 127;  y = 1;   #10;   // overflow
        x = -1;   y = 1;   #10;   // carry

        // Test subtraction
        $monitor("%d - %d = %d", x, y, z);
        sub = 1;
        x = 10;   y = 5;   #10;
        x = 5;    y = 10;  #10;
        x = 0;    y = 0;   #10;
        x = -128; y = 2;   #10;   // overflow

        $finish;
    end

endmodule
