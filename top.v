`timescale 1ns / 1ns
`include "display.v"
`include "ps2.v"
`include "bcd_adder.v"
`include "bcd_subtractor.v"

module top(input clk_i, input rst_i, input ps2_clk_i, input ps2_data_i, 
           output [7:0] led7_seg_o, output [7:0] led7_an_o);

    reg [3:0] dig1, dig10, dig100, dig1000;
    display disp(clk_i, rst_i, dig1, dig10, dig100, dig1000, led7_seg_o, led7_an_o);

    reg [3:0] a1, a10, a100, a1000;
    reg [3:0] b1, b10, b100, b1000;

    wire [3:0] sum1, sum10, sum100, sum1000;
    wire carry1, carry10, carry100, carry1000;

    wire [3:0] diff1, diff10, diff100, diff1000;
    wire borrow1, borrow10, borrow100;

    bcd_adder adder1(a1, b1, sum1, 1'b0, carry1);
    bcd_adder adder10(a10, b10, sum10, carry1, carry10);
    bcd_adder adder100(a100, b100, sum100, carry10, carry100);
    bcd_adder adder1000(a1000, b1000, sum1000, carry100, carry1000);

    bcd_subtractor subtractor1(a1, b1, diff1, 1'b0, borrow1);
    bcd_subtractor subtractor10(a10, b10, diff10, borrow1, borrow10);
    bcd_subtractor subtractor100(a100, b100, diff100, borrow10, borrow100);
    bcd_subtractor subtractor1000(a1000, b1000, diff1000, borrow100, borrow1000);

    wire [3:0] digit_o;
    wire new_data_o;

    ps2 keyboard(clk_i, rst_i, ps2_clk_i, ps2_data_i, digit_o, new_data_o);

    reg [1:0] stage;
    reg add_sub;

    always @(posedge clk_i, posedge rst_i) begin
        if(rst_i) begin
            a1 <= 0;
            a10 <= 0;
            a100 <= 0;
            a1000 <= 0;

            b1 <= 0;
            b10 <= 0;
            b100 <= 0;
            b1000 <= 0;

            stage <= 0;
        end
        else if(clk_i && new_data_o) begin
            if(digit_o < 10 && stage == 2'b00) begin
                a1000 <= a100;
                a100 <= a10;
                a10 <= a1;
                a1 <= digit_o;

                dig1000 <= a100;
                dig100 <= a10;
                dig10 <= a1;
                dig1 <= digit_o;
            end
            else if(digit_o < 10 && stage == 2'b01) begin
                b1000 <= b100;
                b100 <= b10;
                b10 <= b1;
                b1 <= digit_o;

                dig1000 <= b100;
                dig100 <= b10;
                dig10 <= b1;
                dig1 <= digit_o;
            end
            else if(digit_o == 10 && stage == 2'b00) begin
                stage <= 2'b01;
                add_sub <= 0;
            end
            else if(digit_o == 11) begin
                stage <= 2'b01;
                add_sub <= 1;
            end
            else if(digit_o == 12) begin
                stage <= 2'b10;

                if(add_sub) begin
                    dig1 <= sum1;
                    dig10 <= sum10;
                    dig100 <= sum100;
                    dig1000 <= sum1000;
                end
                else begin
                    dig1 <= diff1;
                    dig10 <= diff10;
                    dig100 <= diff100;
                    dig1000 <= diff1000;
                end
            end
            else if(digit_o == 13) begin
                a1 <= 0;
                a10 <= 0;
                a100 <= 0;
                a1000 <= 0;

                b1 <= 0;
                b10 <= 0;
                b100 <= 0;
                b1000 <= 0;

                stage <= 0;

                dig1 <= 0;
                dig10 <= 0;
                dig100 <= 0;
                dig1000 <= 0;
            end
            else begin

            end
        end
    end
endmodule