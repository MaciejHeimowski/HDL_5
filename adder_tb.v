`timescale 1ns / 1ns
`include "bcd_adder.v"

module adder_tb;
    wire [3:0] sum_o;
    reg [3:0] a_i, b_i;

    wire carry_o;
    reg carry_i;

    bcd_adder adder(a_i, b_i, sum_o, carry_i, carry_o);

    initial begin
        $dumpfile("adder_tb.vcd");
        $dumpvars(0, a_i, b_i, carry_i, sum_o, carry_o);

        a_i = 0;
        b_i = 0;
        carry_i = 0;

        for(integer i = 0; i < 200; i = i + 1) begin
            #1
            if(i < 100) begin
                a_i = i / 10;
                b_i = i % 10;
                carry_i = 0;
            end
            else begin
                a_i = (i - 100) / 10;
                b_i = (i - 100) % 10;
                carry_i = 1;
            end
        end

        $finish;
    end
endmodule