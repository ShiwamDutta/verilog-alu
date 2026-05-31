`timescale 1ns/1ps

module divider_tb_8bit;
    localparam WIDTH = 8;

    reg  signed [WIDTH-1:0] d, m;
    wire signed [WIDTH-1:0] q, r;
    wire div_by_zero, overflow;

    divider #(WIDTH) uut (d, m, q, r, div_by_zero, overflow);

    initial begin
        $dumpfile("waves/divider_8bit.vcd");
        $dumpvars(0, uut);

        $monitor("%d = %d * %d + %d", d, m, q, r);
        d =   25; m =   5;  #10;  // zero remainder
        d =   99; m =   7;  #10;  // non-zero remainder
        d =  100; m = -15;  #10;  // negative quotient, positive remainder
        d = -100; m =  15;  #10;  // negative quotient, negative remainder
        d = -100; m = -15;  #10;  // positive quotient, negative remainder
        d =    0; m =  25;  #10;  // zero dividend
        d = -128; m =  -1;  #10;  // signed overflow
        d =  100; m =   0;  #10;  // divided by zero

        $finish;

    end

endmodule
