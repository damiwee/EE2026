`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 14:24:48
// Design Name: 
// Module Name: test_simulation
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


module test_simulation();

    reg A = 0 ;
    reg [31:0] C = 7;
    wire B;
    
    flexible_clock test1(A,C,B);
    
    initial begin
    A = 0;
    end 
    
    always begin
    #5 A = ~A;
    end

    
endmodule
