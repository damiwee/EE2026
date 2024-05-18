`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2024 23:36:32
// Design Name: 
// Module Name: calorie_led
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


module calorie_led(
    input basys_clk,
    input [15:0] ideal_calorie,
    input [15:0] calorie_total,
    output reg [15:0] led = 16'b000000_00000_00000
    );
    
    reg [15:0] cal;
    
    always @ (posedge basys_clk) begin
    
        cal <= ideal_calorie / 16;       
        
        if (calorie_total < cal) begin
            led = 16'b000000_00000_00000;
        end else if (calorie_total < cal*2) begin
            led = 16'b000000_00000_00001;
        end else if (calorie_total < cal*3) begin
            led = 16'b000000_00000_00011;       
        end else if (calorie_total < cal*4) begin
            led = 16'b000000_00000_00111;
        end else if (calorie_total < cal*5) begin
            led = 16'b000000_00000_01111;
        end else if (calorie_total < cal*6) begin
            led = 16'b000000_00000_11111;
        end else if (calorie_total < cal*7) begin
            led = 16'b000000_00001_11111;
        end else if (calorie_total < cal*8) begin
            led = 16'b000000_00011_11111;
        end else if (calorie_total < cal*9) begin
            led = 16'b000000_00111_11111;
        end else if (calorie_total < cal*10) begin
            led = 16'b000000_01111_11111;
        end else if (calorie_total < cal*11) begin
            led = 16'b000000_11111_11111;
        end else if (calorie_total < cal*12) begin
            led = 16'b000001_11111_11111;
        end else if (calorie_total < cal*13) begin
            led = 16'b000011_11111_11111;
        end else if (calorie_total < cal*14) begin
            led = 16'b000111_11111_11111;
        end else if (calorie_total < cal*15) begin
            led = 16'b001111_11111_11111;
        end else if (calorie_total < ideal_calorie) begin
            led = 16'b011111_11111_11111;
        end else begin
            led = 16'b111111_11111_11111;
        end        
        
    end
    
endmodule
