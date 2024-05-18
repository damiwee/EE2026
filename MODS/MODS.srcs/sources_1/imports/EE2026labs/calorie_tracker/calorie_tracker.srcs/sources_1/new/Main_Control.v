`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2024 13:23:12
// Design Name: 
// Module Name: Main_Control
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


module Ari_Main_Control(
    input basys_clk,
    input [12:0] pixel_index,
    input btnL,
    input btnR,
    input btnC,
    input btnU,
    input btnD,
    input [15:0] calorie_tdee,
    input [15:0] calorie_deficit,
    input [7:0] control,
    output [15:0] oled_data,
    output [15:0] led,
    output reg [7:0] seg0,
    output reg [7:0] seg1,
    output reg [7:0] seg2,
    output reg [7:0] seg3,
    output [15:0] calorie_burn,
    output ari_control,
    output ari_rj_control
    );
    
    wire oneMsClk;
    wire button_L, button_R, button_C, button_U, button_D;
    flexible_clock clk_1000hz(basys_clk, 49999, oneMsClk);
    dff left_button (oneMsClk, btnL, button_L);
    dff right_button (oneMsClk, btnR, button_R);
    dff center_button (oneMsClk, btnC, button_C);
    dff up_button (oneMsClk, btnU, button_U);
    dff down_button (oneMsClk, btnD, button_D);
    
    
    wire [15:0] oled_data_A;
    wire [15:0] oled_data_B;
    wire [15:0] oled_data_C;
    wire [15:0] oled_data_D;
    wire [15:0] oled_data_E;
    wire [15:0] oled_data_F;    
    wire [15:0] calorie_countA;
    wire [15:0] calorie_countB;
    wire [15:0] calorie_countC;
    wire [15:0] calorie_countD;
    wire [15:0] calorie_countE;
    wire [15:0] calorie_countF;    
    
    wire [15:0] calorie_total;
                      
    wire isNumpadA;
    wire isNumpadB;
    wire isNumpadC;
    wire isNumpadD;
    wire isNumpadE;
    wire isNumpadF;
    
    wire isMain_A;
    wire isMain_B;
    wire isMain_C;
    wire isMain_A1;
    wire isMain_B1;
    wire isMain_C1; 
    dff g1 (oneMsClk, isMain_A, isMain_A1);
    dff g2 (oneMsClk, isMain_B, isMain_B1);
    dff g3 (oneMsClk, isMain_C, isMain_C1);
    
    wire isMain_D;
    wire isMain_E;
    wire isMain_F;
    wire isMain_D1;
    wire isMain_E1;
    wire isMain_F1; 
    dff g4 (oneMsClk, isMain_D, isMain_D1);
    dff g5 (oneMsClk, isMain_E, isMain_E1);
    dff g6 (oneMsClk, isMain_F, isMain_F1);
    
  
    wire isMain;
    wire isMain2;
    dff mainff (oneMsClk, isMain, isMain2);
    
    wire isSnack;
    wire isSnack2;
    dff snackff (oneMsClk, isSnack, isSnack2);    

    wire [15:0] oled_data_main;
    wire [15:0] oled_data_snack;
    
    wire isSnackMenu;
    wire isSnackMenu2;
    dff snackmenuff (oneMsClk, isSnackMenu, isSnackMenu2); 
    
    wire isMainMenu;
    wire isMainMenu2;
    dff mainmenudff (oneMsClk, isMainMenu, isMainMenu2);    
    calorie_menu menuscreen (basys_clk, control, isSnack2, isMain_A1, isMain_B1, isMain_C1, isMainMenu2, pixel_index, button_L, button_R, button_C, button_U, button_D, calorie_countA, calorie_countB, calorie_countC, calorie_tdee, oled_data_main, isNumpadA, isNumpadB, isNumpadC, isMain, isSnackMenu, ari_rj_control);
    snack_menu snackscreen (basys_clk, control, isMain2, isMain_D1, isMain_E1, isMain_F1, isSnackMenu2, pixel_index, button_L, button_R, button_C, button_U, button_D, calorie_countD, calorie_countE, calorie_countF, oled_data_snack, isNumpadD, isNumpadE, isNumpadF, isSnack, isMainMenu, ari_control);
    
    numpad pad_A(basys_clk, isMain2, isNumpadA, pixel_index, button_L, button_R, button_C, button_U, button_D, oled_data_A, calorie_countA, isMain_A);
    numpad pad_B(basys_clk, isMain2, isNumpadB, pixel_index, button_L, button_R, button_C, button_U, button_D, oled_data_B, calorie_countB, isMain_B);
    numpad pad_C(basys_clk, isMain2, isNumpadC, pixel_index, button_L, button_R, button_C, button_U, button_D, oled_data_C, calorie_countC, isMain_C);
    numpad pad_D(basys_clk, isSnack2, isNumpadD, pixel_index, button_L, button_R, button_C, button_U, button_D, oled_data_D, calorie_countD, isMain_D);
    numpad pad_E(basys_clk, isSnack2, isNumpadE, pixel_index, button_L, button_R, button_C, button_U, button_D, oled_data_E, calorie_countE, isMain_E);
    numpad pad_F(basys_clk, isSnack2, isNumpadF, pixel_index, button_L, button_R, button_C, button_U, button_D, oled_data_F, calorie_countF, isMain_F);    
    
    oled_data_mux mux1(basys_clk, isMain, isSnack, isNumpadA, isNumpadB, isNumpadC, isNumpadD, isNumpadE, isNumpadF, oled_data_A, oled_data_B, oled_data_C, oled_data_D, oled_data_E, oled_data_F, oled_data_main, oled_data_snack, oled_data); //control state
    
    assign calorie_total = (calorie_countA + calorie_countB + calorie_countC + calorie_countD + calorie_countE + calorie_countF > 9999) ? 9999 : (calorie_countA + calorie_countB + calorie_countC + calorie_countD + calorie_countE + calorie_countF);                     
    
    calorie_led ledIndicator(basys_clk, calorie_tdee, calorie_total, led); 
    
    wire signed [15:0] cal_change;
    assign cal_change = calorie_total - calorie_tdee + calorie_deficit;
    assign calorie_burn = (cal_change < 0) ? 0 : 
                          (cal_change > 3000) ? 3000 :
                          calorie_total - calorie_tdee + calorie_deficit;
    
    reg [4:0] seg_num[3:0]; 
    
    parameter BLANK = 8'b11111111;
    parameter ZERO = 8'b11000000; 
    parameter ONE = 8'b11111001;
    parameter TWO = 8'b10100100;
    parameter THREE = 8'b10110000;
    parameter FOUR = 8'b10011001;
    parameter FIVE = 8'b10010010;
    parameter SIX = 8'b10000010;
    parameter SEVEN = 8'b11111000;
    parameter EIGHT = 8'b10000000;
    parameter NINE = 8'b10011000;
   
    
    always @ (posedge basys_clk) begin
    
        seg_num[3] <= (calorie_total / 1000) % 10;
        seg_num[2] <= (calorie_total / 100) % 10;
        seg_num[1] <= (calorie_total / 10) % 10;
        seg_num[0] <= calorie_total % 10;
        
        if (calorie_total == 0) begin
            seg0 <= BLANK;
        end else if (seg_num[0] == 0) begin 
            seg0 <= ZERO;
        end else if (seg_num[0] == 1) begin
            seg0 <= ONE;
        end else if (seg_num[0] == 2) begin
            seg0 <= TWO;
        end else if (seg_num[0] == 3) begin
            seg0 <= THREE;
        end else if (seg_num[0] == 4) begin
            seg0 <= FOUR;
        end else if (seg_num[0] == 5) begin
            seg0 <= FIVE;
        end else if (seg_num[0] == 6) begin
            seg0 <= SIX;
        end else if (seg_num[0] == 7) begin
            seg0 <= SEVEN;
        end else if (seg_num[0] == 8) begin
            seg0 <= EIGHT;
        end else if (seg_num[0] == 9) begin
            seg0 <= NINE;
        end else begin
            seg0 <= BLANK;
        end   
        
        
        if (calorie_total == 0) begin
            seg1 <= BLANK;
        end else if (seg_num[3] == 0 && seg_num[2] == 0 && seg_num[1] == 0) begin    
            seg1 <= BLANK;
        end else if (seg_num[1] == 0) begin 
            seg1 <= ZERO;
        end else if (seg_num[1] == 1) begin
            seg1 <= ONE;
        end else if (seg_num[1] == 2) begin
            seg1 <= TWO;
        end else if (seg_num[1] == 3) begin
            seg1 <= THREE;
        end else if (seg_num[1] == 4) begin
            seg1 <= FOUR;
        end else if (seg_num[1] == 5) begin
            seg1 <= FIVE;
        end else if (seg_num[1] == 6) begin
            seg1 <= SIX;
        end else if (seg_num[1] == 7) begin
            seg1 <= SEVEN;
        end else if (seg_num[1] == 8) begin
            seg1 <= EIGHT;
        end else if (seg_num[1] == 9) begin
            seg1 <= NINE;
        end else begin
            seg1 <= BLANK;
        end         
        
        if (calorie_total == 0) begin
            seg2 <= BLANK;
        end else if (seg_num[3] == 0 && seg_num[2] == 0) begin    
            seg2 <= BLANK;
        end else if (seg_num[2] == 0) begin 
            seg2 <= ZERO;
        end else if (seg_num[2] == 1) begin
            seg2 <= ONE;
        end else if (seg_num[2] == 2) begin
            seg2 <= TWO;
        end else if (seg_num[2] == 3) begin
            seg2 <= THREE;
        end else if (seg_num[2] == 4) begin
            seg2 <= FOUR;
        end else if (seg_num[2] == 5) begin
            seg2 <= FIVE;
        end else if (seg_num[2] == 6) begin
            seg2 <= SIX;
        end else if (seg_num[2] == 7) begin
            seg2 <= SEVEN;
        end else if (seg_num[2] == 8) begin
            seg2 <= EIGHT;
        end else if (seg_num[2] == 9) begin
            seg2 <= NINE;
        end else begin
            seg2 <= BLANK;
        end         
        
        
        if (calorie_total == 0) begin
            seg3 <= BLANK;
        end else if (seg_num[3] == 0) begin    
            seg3 <= BLANK;
        end else if (seg_num[3] == 1) begin
            seg3 <= ONE;
        end else if (seg_num[3] == 2) begin
            seg3 <= TWO;
        end else if (seg_num[3] == 3) begin
            seg3 <= THREE;
        end else if (seg_num[3] == 4) begin
            seg3 <= FOUR;
        end else if (seg_num[3] == 5) begin
            seg3 <= FIVE;
        end else if (seg_num[3] == 6) begin
            seg3 <= SIX;
        end else if (seg_num[3] == 7) begin
            seg3 <= SEVEN;
        end else if (seg_num[3] == 8) begin
            seg3 <= EIGHT;
        end else if (seg_num[3] == 9) begin
            seg3 <= NINE;
        end else begin
            seg3 <= BLANK;
        end         
            
    end
    
endmodule



    

