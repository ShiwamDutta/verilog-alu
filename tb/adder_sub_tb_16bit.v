
`timescale 1ns/1ps

module adder_sub_tb_16bit;
    localparam WIDTH = 16;

    reg  signed [WIDTH-1:0] x, y;
    wire signed [WIDTH-1:0] z;

    reg  sub;
    wire c, v, zero;

    adder_sub #(WIDTH) uut (x, y, sub, z, c, v, zero);

    initial begin
        $dumpfile("waves/adder_sub_16bit.vcd");
        $dumpvars(0, uut);

        // Test addition
        $monitor("%d + %d = %d", x, y, z);
        sub = 0;
        x =   425; y = 275;  #10;
        x =  -545; y = 420;  #10;  // negative result
        x =    -1; y =   1;  #10;  // zero + carry
        x = 32767; y =   1;  #10;  // signed overflow

        // Test subtraction
        $monitor("%d - %d = %d", x, y, z);
        sub = 1;
        x =    350; y = 550;  #10;  // negative result
        x =    225; y = 225;  #10;  // zero
        x =  32767; y =  -1;  #10;  // signed overflow
        x = -32768; y =   1;  #10;  // signed overflow

        $finish;
    end

endmodule
