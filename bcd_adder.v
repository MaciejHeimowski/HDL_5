`timescale 1ns / 1ns

module bcd_adder(input [3:0] a_i, input [3:0] b_i, output reg [3:0] sum_o, input carry_i, output reg carry_o);
    always @* begin
        if(a_i + b_i + carry_i < 10) begin
            sum_o <= a_i + b_i + carry_i;
            carry_o <= 0;
        end
        else begin
            sum_o <= a_i + b_i + carry_i - 5'd10;
            carry_o <= 1;      
        end
    end
endmodule