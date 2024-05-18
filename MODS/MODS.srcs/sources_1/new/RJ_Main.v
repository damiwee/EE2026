`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 15:48:25
// Design Name: 
// Module Name: RJ_Main
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


module RJ_Main(
    input clk,
    input [7:0]control,
    input [15:0]height_weight_pic,
    input [15:0]page2,
    input [15:0]sw,
    output [7:0]seg,
    output [3:0]an,
    input btnC,btnL,btnR,btnD,btnU,
    input [7:0]X,
    input [6:0]Y,   
    output[15:0]oled_data,
    output RJ_control,
    output [15:0]TDEE,
    output[15:0]deficit
    );
   
    wire [1:0] gender_confirm,page;
    wire [5:0] state;
    wire [3:0] height_1st_digit,height_2nd_digit,height_3rd_digit,weight_1st_digit,weight_2nd_digit,weight_3rd_digit;
    wire [3:0] age_1st_digit,age_2nd_digit,age_3rd_digit;
    wire [3:0] wLOSS_1st_digit,wLOSS_2nd_digit,Months_1st_digit,Months_2nd_digit; 
  
    RJ_menu Btn_control (clk,control,
                      sw[15:0],btnC,btnL,btnR,seg[7:0],an[3:0],
                      state,gender_confirm,
                      age_1st_digit,age_2nd_digit,age_3rd_digit,
                      height_1st_digit,height_2nd_digit,height_3rd_digit,
                      weight_1st_digit,weight_2nd_digit,weight_3rd_digit,
                      wLOSS_1st_digit,wLOSS_2nd_digit,Months_1st_digit,Months_2nd_digit,
                      page,RJ_control);
    
    RJ_OLED_Control OLED_control(clk,height_weight_pic[15:0],page2[15:0],
                         X[7:0],Y[6:0],
                         state,gender_confirm,page,
                         age_1st_digit,age_2nd_digit,age_3rd_digit,
                         height_1st_digit,height_2nd_digit,height_3rd_digit,
                         weight_1st_digit,weight_2nd_digit,weight_3rd_digit,
                         wLOSS_1st_digit,wLOSS_2nd_digit,Months_1st_digit,Months_2nd_digit,
                         oled_data,TDEE,deficit);
   
endmodule
