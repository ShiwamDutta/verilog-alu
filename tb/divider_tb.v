`timescale 1ns/1ps

module divider_tb;

    reg  signed [7:0] d, m;
    wire signed [7:0] q, r;
    wire div_by_zero, overflow;

    divider #(8) uut (d, m, q, r, div_by_zero, overflow);

    initial begin
        $dumpfile("waves/divider.vcd");
        $dumpvars(0, uut);

        $monitor("%d = %d * %d + %d", d, m, q, r);
        d =  25; m =  5; #10;
        d =  99; m =  7; #10;
        d = 120; m =  8; #10;
        d =-100; m = 15; #10; // negative quotient
        d =-110; m =-13; #10; // negative remainder
        d =-128; m =- 1; #10; // overflow condition
        d =  64; m =  3; #10;
        d = 100; m =  0; #10; // divided by 0

        $finish;

    end

endmodule
