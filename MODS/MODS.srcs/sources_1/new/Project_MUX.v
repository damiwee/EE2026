`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2024 11:42:11
// Design Name: 
// Module Name: Project_MUX
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


module Project_MUX(input clk,
                   input [5:0] control,
                   
                   input [15:0]oled_data_D,
                   input [15:0]oled_data_K,
                   input [15:0]oled_data_ari,
                   input [15:0]oled_data_RJ,
                   input [7:0]anA0,input [7:0]anA1,input [7:0]anA2,input [7:0]anA3,
                   input [7:0]anK0,input [7:0]anK1,input [7:0]anK2,input [7:0]anK3,
                   input [7:0]anD0,input [7:0]anD1,input [7:0]anD2,input [7:0]anD3,
                   input [7:0]seg_RJ,input[3:0]an_RJ,
                   output reg [3:0]an, output reg[7:0]seg,
                   output reg [15:0]oled_data,
                   input [15:0] led_d,
                   input [15:0] led_ari,
                   output reg [15:0] led
    );
    reg [31:0] count = 0;
    reg [5:0] state = 0;
    reg [7:0] an0_out;
    reg [7:0] an1_out;
    reg [7:0] an2_out;
    reg [7:0] an3_out;
    always @ (posedge clk)
    begin
    if (control == 0) begin
    oled_data <= oled_data_K;
    an0_out <= anK0;
    an1_out <= anK1;
    an2_out <= anK2;
    an3_out <= anK3;
    led <= 16'b00000_000000_00000;
    end
    
    else if (control == 1) begin
    oled_data <= oled_data_D;
    an0_out <= anD0;
    an1_out <= anD1;
    an2_out <= anD2;
    an3_out <= anD3;
    led <= led_d;
    end
    
    else if (control == 2) begin
    oled_data <= oled_data_ari;
    an0_out <= anA0;
    an1_out <= anA1;
    an2_out <= anA2;
    an3_out <= anA3;
    led <= led_ari;
    end else if (control == 3) begin  //ruijie part
        oled_data <= oled_data_RJ;
        seg[7:0] <= seg_RJ;
        an[3:0] <=an_RJ;
        led <= 16'b00000_000000_00000;
    end
    if (control==0||control==1||control==2)begin
    count <= count + 1;
    if(state == 0) begin
    an[3:0] <= 4'b1110;
    seg <= an0_out;
    if (count > 10000)begin
    count <= 0;
    state <= 1;
    end
    end
    else if (state == 1) begin
    an[3:0] <= 4'b1101;
    seg <= an1_out;
    if (count > 10000)begin
    count <= 0;
    state <= 2;
    end        
    end
    else if (state == 2) begin
    an[3:0] <= 4'b1011;
    seg <= an2_out;
    if (count > 10000)begin
    count <= 0;
    state <= 3;
    end        
    end
    else if (state == 3) begin
    an[3:0] <= 4'b0111;
    seg <= an3_out;
    if (count > 10000)begin
    count <= 0;
    state <= 0;
    end        
    end
    
    end
    
    
    
    end
endmodule
