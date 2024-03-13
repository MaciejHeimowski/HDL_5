`timescale 1ns / 1ns

module ps2(input clk_i, input rst_i, input ps2_clk_i, input ps2_data_i, output reg [3:0] digit_o, output reg new_data_o);
    function [3:0] ps2_conv;
        input [7:0] code_i;

        case(code_i)
            8'h45: ps2_conv = 4'd0;
            8'h16: ps2_conv = 4'd1;
            8'h1e: ps2_conv = 4'd2;
            8'h26: ps2_conv = 4'd3;
            8'h25: ps2_conv = 4'd4;
            8'h23: ps2_conv = 4'd5;
            8'h36: ps2_conv = 4'd6;
            8'h3d: ps2_conv = 4'd7;
            8'h3e: ps2_conv = 4'd8;
            8'h46: ps2_conv = 4'd9;
            8'h7b: ps2_conv = 4'd10;
            8'h79: ps2_conv = 4'd11;
            8'h55: ps2_conv = 4'd12;
            default: ps2_conv = 4'd0;
        endcase
    endfunction

    reg [4:0] counter;

    reg [7:0] digit;

    reg prev_ps2_clk, curr_ps2_clk;

    initial begin
        $dumpfile("ps2_tb.vcd");
        $dumpvars(0, prev_ps2_clk, curr_ps2_clk, digit, digit_o);
    end

    always @(posedge clk_i, posedge rst_i) begin
        if(rst_i) begin
            counter <= 0;
            digit <= 0;
            digit_o <= 0;
            prev_ps2_clk <= 0;
            curr_ps2_clk <= 0;
            new_data_o <= 0;
        end
        else if(clk_i) begin
            prev_ps2_clk <= curr_ps2_clk;
            curr_ps2_clk <= ps2_clk_i;

            new_data_o <= 0;

            if(prev_ps2_clk == 1 && curr_ps2_clk == 0) begin
                if(counter >= 10) begin
                    counter <= 0;
                    digit_o <= ps2_conv(digit);
                    new_data_o <= 1;
                end
                else begin
                    counter <= counter + 1;

                    if(counter == 1) begin
                        digit <= 0;
                    end
                    else if(counter >= 1 && counter <= 8) begin
                        digit <= (digit << 1) | ps2_data_i;
                    end
                end
            end
        end
    end
endmodule