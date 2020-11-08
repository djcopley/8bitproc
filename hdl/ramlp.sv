//EE 310 Fundamentals of Computer Engineering
//Assignment: 
//Author: 
//Module Name:
//Module Function
//**************************************************************************************

//Module Declaration
module ramlp(input logic clock, wren, input logic [7:0] address, data, output logic [7:0] q);

logic [30:0][7:0] ram;

initial begin
    ram[0] = 'h02;
    ram[1] = 'hE7;
    ram[2] = 'h03;
    ram[3] = 'h10;
    ram[4] = 'h09;
    ram[5] = 'h0B;
    ram[6] = 'h10;
    ram[7] = 'h0A;
    ram[8] = 'h0E;
    ram[9] = 'h03;
    ram[10] = 'h0F;
    ram[11] = 'h93;
    ram[12] = 'h04;
    ram[13] = 'h01;
    ram[14] = 'h10;
end

always @(posedge clock) begin
    if (wren) begin
        ram[address] <= data;
    end else begin
        q <= ram[address];
    end
end

endmodule

