`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 14:18:23
// Design Name: 
// Module Name: flexible_clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flexible_clock( input basys_clk,input [31:0] m , output reg slow_clock = 0 );

        reg [31:0] COUNT = 0;

always @ (posedge basys_clk)

begin
COUNT <= (COUNT == m) ? 0 : COUNT + 1;
slow_clock <= (COUNT == 0) ? ~slow_clock : slow_clock;
end
   
endmodule
