`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2024 21:37:56
// Design Name: 
// Module Name: display_smiley
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


module display_smiley(
    input clk,
    input [12:0] pixel_index,
    output reg [15:0] oled_data
    );
    
    wire clk_6p25m;
    wire clk_25m;
    wire [7:0]x;
    wire [6:0]y;
    
    flexible_clock clk25m(clk, 1, clk_25m);
                  
    assign x = pixel_index % 96;
    assign y = pixel_index / 96; 
    
    always @ (posedge clk_25m)
    begin
        if ((x >= 36 && x <= 59 && y >= 5 && y <= 5) || 
            (x >= 36 && x <= 59 && y >= 48 && y <= 48) ||
            (x >= 26 && x <= 26 && y >= 15 && y <= 38) ||
            (x >= 69 && x <= 69 && y >= 15 && y <= 38) ||
            
            (x >= 32 && x <= 35 && y >= 6 && y <= 6) ||
            (x >= 60 && x <= 63 && y >= 6 && y <= 6) ||
            
            (x >= 31 && x <= 31 && y >= 7 && y <= 7) ||
            (x >= 30 && x <= 30 && y >= 8 && y <= 8) ||
            (x >= 29 && x <= 29 && y >= 9 && y <= 9) ||
            (x >= 28 && x <= 28 && y >= 10 && y <= 10) ||
            
            (x >= 64 && x <= 64 && y >= 7 && y <= 7) ||
            (x >= 65 && x <= 65 && y >= 8 && y <= 8) ||
            (x >= 66 && x <= 66 && y >= 9 && y <= 9) ||
            (x >= 67 && x <= 67 && y >= 10 && y <= 10) ||
            
            (x >= 27 && x <= 27 && y >= 11 && y <= 14) ||
            (x >= 68 && x <= 68 && y >= 11 && y <= 14) ||
            
            (x >= 27 && x <= 27 && y >= 39 && y <= 42) ||
            (x >= 68 && x <= 68 && y >= 39 && y <= 42) ||
            
            (x >= 32 && x <= 35 && y >= 47 && y <= 47) ||
            (x >= 60 && x <= 63 && y >= 47 && y <= 47) ||
            
            (x >= 28 && x <= 28 && y >= 43 && y <= 43) ||
            (x >= 29 && x <= 29 && y >= 44 && y <= 44) ||
            (x >= 30 && x <= 30 && y >= 45 && y <= 45) ||
            (x >= 31 && x <= 31 && y >= 46 && y <= 46) ||
            
            (x >= 64 && x <= 64 && y >= 46 && y <= 46) ||
            (x >= 65 && x <= 65 && y >= 45 && y <= 45) ||
            (x >= 66 && x <= 66 && y >= 44 && y <= 44) ||
            (x >= 67 && x <= 67 && y >= 43 && y <= 43) ||
            
            (x >= 36 && x <= 39 && y >= 14 && y <= 17) ||
            (x >= 56 && x <= 59 && y >= 14 && y <= 17) ||
            
            (x >= 43 && x <= 51 && y >= 38 && y <= 39) ||
            
            (x >= 41 && x <= 42 && y >= 36 && y <= 37) ||
            (x >= 52 && x <= 53 && y >= 36 && y <= 37) ||
            
            (x >= 40 && x <= 40 && y >= 34 && y <= 35) ||
            (x >= 54 && x <= 54 && y >= 34 && y <= 35)
            ) begin
            oled_data <= 16'b1010100000000000;
        end 
        else begin
            oled_data <= 16'b0000000000000000; // Other pixels are off
        end
    end


endmodule
