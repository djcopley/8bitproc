//EE 310 Fundamentals of Computer Engineering
//Assignment: Lab 04
//Author: Daniel Copley
//Module Name: ac
//Module Function: 8 bit accumulatr register
//**************************************************************************************

//Module Declaration
module ac(
    input logic clk, en,
    input logic [7:0]d,
    output logic [7:0]q
);

    always_ff @(posedge clk) begin
        if (en) begin
            q <= d;
        end
    end

endmodule
