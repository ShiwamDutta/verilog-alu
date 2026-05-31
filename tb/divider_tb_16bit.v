`timescale 1ns/1ps

module divider_tb_16bit;
    localparam WIDTH = 16;

    reg  signed [WIDTH-1:0] d, m;
    wire signed [WIDTH-1:0] q, r;
    wire div_by_zero, overflow;

    divider #(WIDTH) uut (d, m, q, r, div_by_zero, overflow);

    initial begin
        $dumpfile("waves/divider_16bit.vcd");
        $dumpvars(0, uut);

        $monitor("%d = %d * %d + %d", d, m, q, r);
        d =   1750; m =  250;  #10;  // zero remainder
        d =   1859; m =  256;  #10;  // non-zero remainder
        d =   8549; m = -785;  #10;  // negative quotient, positive remainder
        d =  -8549; m =  785;  #10;  // negative quotient, negative remainder
        d = -14508; m = -355;  #10;  // positive quotient, negative remainder
        d =      0; m = 5867;  #10;  // zero dividend
        d = -32768; m =   -1;  #10;  // signed overflow
        d =  14525; m =    0;  #10;  // divided by zero

        $finish;

    end

endmodule
