`timescale 1ns/1ps

module adder_sub_8bit_tb;

    reg  signed [7:0] x, y;
    wire signed [7:0] z;

    reg  sub;
    wire c, v, zero;

    adder_sub_8bit uut (x, y, sub, z, c, v, zero);

    initial begin
        $dumpfile("waves/adder_sub.vcd");
        $dumpvars(0, uut);

        // Test addition
        $monitor("%d + %d = %d", x, y, z);
        sub = 0;
        x = 8'd010; y = 8'd005; #10;
        x = 8'd000; y = 8'd000; #10;        // zero result
        x = 8'd127; y = 8'd001; #10;        // signed overflow
        x = 8'd200; y = 8'd100; #10;        // unsigned carry

        // Test subtraction
        $monitor("%d - %d = %d", x, y, z);
        sub = 1;
        x = 8'd010; y = 8'd005; #10;        // normal subtraction
        x = 8'd005; y = 8'd010; #10;        // negative result
        x = 8'd000; y = 8'd000; #10;        // zero result
        x = 8'd128; y = 8'd002; #10;        // signed overflow in subtraction

        $finish;
    end

endmodule
