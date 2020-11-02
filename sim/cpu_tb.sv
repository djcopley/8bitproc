// EE 310 Fundamentals of Computer Engineering
// Assignment: 
// Author: 
// Module Name:
// Module Function
// **************************************************************************************

`timescale 1ns/1ns

// Module Declaration
module cpu_tb();

// 100 MHz
const integer CLK_PERIOD = 10;

// Internal Signal Declarations
logic clk = 0;
logic rst = 1;

cpu cpu0(.clk(clk), .rst(rst));

always #(CLK_PERIOD/2) clk <= ~clk;

initial begin
    #(CLK_PERIOD) rst <= 0;
end

endmodule

