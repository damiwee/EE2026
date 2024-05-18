`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2024 21:29:34
// Design Name: 
// Module Name: calorie_menu
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

module calorie_menu(
    input basys_clk, 
    input [7:0] control,
    input isSnack,
    input isMain_A,
    input isMain_B,
    input isMain_C,
    input isMainMenu,
    input [12:0] pixel_index,
    input btnL,
    input btnR,
    input btnC,
    input btnU,
    input btnD,
    input [15:0] calorie_countA,
    input [15:0] calorie_countB,
    input [15:0] calorie_countC,
    input [15:0] calorie_tdee,
    output reg [15:0] oled_data,
    output reg isNumpadA = 0,
    output reg isNumpadB = 0,
    output reg isNumpadC = 0,
    output reg isMain = 0,
    output reg isSnackMenu = 0,
    output reg ari_rj_control= 0
    );
    
    wire [6:0] x, y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    parameter DIGITCOLOR = 16'hE441;
    parameter BACKGROUND = 16'h0000;
    parameter DELETECOLOR = 16'hF800;
    parameter TICKCOLOR = 16'h0F48;
    parameter BOXCOLOR = 16'h0F48;
    parameter ALPHABETCOLOR = 16'h2458; 
    
    
    reg [15:0] digit0 [6:0][3:0];
    reg [15:0] digit1 [6:0][3:0];
    reg [15:0] digit2 [6:0][3:0];
    reg [15:0] digit3 [6:0][3:0];
    reg [15:0] digit4 [6:0][3:0];
    reg [15:0] digit5 [6:0][3:0];
    reg [15:0] digit6 [6:0][3:0];
    reg [15:0] digit7 [6:0][3:0];
    reg [15:0] digit8 [6:0][3:0];
    reg [15:0] digit9 [6:0][3:0];
    reg [15:0] digitBackGround [6:0][3:0];
    reg [15:0] dashline [6:0][3:0];
    
    reg [15:0] bfast [4:0][22:0];
    reg [15:0] lunch [4:0][22:0];
    reg [15:0] dinner [4:0][25:0];
    reg [15:0] cal [4:0][12:0];
    reg [15:0] tdee [4:0][19:0];
        
    reg [4:0] displayTDEE_num[3:0];    
    reg [4:0] displayA_num[3:0];
    reg [4:0] displayB_num[3:0];
    reg [4:0] displayC_num[3:0];
    
    
    initial begin
    
        //////////////////////////////// tdee
        
        tdee[0][0] <= ALPHABETCOLOR;
        tdee[0][1] <= ALPHABETCOLOR;
        tdee[0][2] <= ALPHABETCOLOR;
        tdee[0][3] <= BACKGROUND;
        tdee[0][4] <= ALPHABETCOLOR;
        tdee[0][5] <= ALPHABETCOLOR;
        tdee[0][6] <= ALPHABETCOLOR;
        tdee[0][7] <= BACKGROUND;
        tdee[0][8] <= BACKGROUND;
        tdee[0][9] <= ALPHABETCOLOR;
        tdee[0][10] <= ALPHABETCOLOR;
        tdee[0][11] <= ALPHABETCOLOR;
        tdee[0][12] <= ALPHABETCOLOR;
        tdee[0][13] <= BACKGROUND;
        tdee[0][14] <= ALPHABETCOLOR;
        tdee[0][15] <= ALPHABETCOLOR;
        tdee[0][16] <= ALPHABETCOLOR;
        tdee[0][17] <= ALPHABETCOLOR;
        tdee[0][18] <= BACKGROUND;
        tdee[0][19] <= BACKGROUND;
 
        tdee[1][0] <= BACKGROUND;
        tdee[1][1] <= ALPHABETCOLOR;
        tdee[1][2] <= BACKGROUND;
        tdee[1][3] <= BACKGROUND;
        tdee[1][4] <= ALPHABETCOLOR;
        tdee[1][5] <= BACKGROUND;
        tdee[1][6] <= BACKGROUND;
        tdee[1][7] <= ALPHABETCOLOR;
        tdee[1][8] <= BACKGROUND;
        tdee[1][9] <= ALPHABETCOLOR;
        tdee[1][10] <= BACKGROUND;
        tdee[1][11] <= BACKGROUND;
        tdee[1][12] <= BACKGROUND;
        tdee[1][13] <= BACKGROUND;
        tdee[1][14] <= ALPHABETCOLOR;
        tdee[1][15] <= BACKGROUND;
        tdee[1][16] <= BACKGROUND;
        tdee[1][17] <= BACKGROUND;
        tdee[1][18] <= BACKGROUND;
        tdee[1][19] <= ALPHABETCOLOR;
        
        tdee[2][0] <= BACKGROUND;
        tdee[2][1] <= ALPHABETCOLOR;
        tdee[2][2] <= BACKGROUND;
        tdee[2][3] <= BACKGROUND;
        tdee[2][4] <= ALPHABETCOLOR;
        tdee[2][5] <= BACKGROUND;
        tdee[2][6] <= BACKGROUND;
        tdee[2][7] <= ALPHABETCOLOR;
        tdee[2][8] <= BACKGROUND;
        tdee[2][9] <= ALPHABETCOLOR;
        tdee[2][10] <= ALPHABETCOLOR;
        tdee[2][11] <= ALPHABETCOLOR;
        tdee[2][12] <= BACKGROUND;
        tdee[2][13] <= BACKGROUND;
        tdee[2][14] <= ALPHABETCOLOR;
        tdee[2][15] <= ALPHABETCOLOR;
        tdee[2][16] <= ALPHABETCOLOR;
        tdee[2][17] <= BACKGROUND;
        tdee[2][18] <= BACKGROUND;
        tdee[2][19] <= BACKGROUND;
        
        tdee[3][0] <= BACKGROUND;
        tdee[3][1] <= ALPHABETCOLOR;
        tdee[3][2] <= BACKGROUND;
        tdee[3][3] <= BACKGROUND;
        tdee[3][4] <= ALPHABETCOLOR;
        tdee[3][5] <= BACKGROUND;
        tdee[3][6] <= BACKGROUND;
        tdee[3][7] <= ALPHABETCOLOR;
        tdee[3][8] <= BACKGROUND;
        tdee[3][9] <= ALPHABETCOLOR;
        tdee[3][10] <= BACKGROUND;
        tdee[3][11] <= BACKGROUND;
        tdee[3][12] <= BACKGROUND;
        tdee[3][13] <= BACKGROUND;
        tdee[3][14] <= ALPHABETCOLOR;
        tdee[3][15] <= BACKGROUND;
        tdee[3][16] <= BACKGROUND;
        tdee[3][17] <= BACKGROUND;
        tdee[3][18] <= BACKGROUND;
        tdee[3][19] <= ALPHABETCOLOR;
        
        tdee[4][0] <= BACKGROUND;
        tdee[4][1] <= ALPHABETCOLOR;
        tdee[4][2] <= BACKGROUND;
        tdee[4][3] <= BACKGROUND;
        tdee[4][4] <= ALPHABETCOLOR;
        tdee[4][5] <= ALPHABETCOLOR;
        tdee[4][6] <= ALPHABETCOLOR;
        tdee[4][7] <= BACKGROUND;
        tdee[4][8] <= BACKGROUND;
        tdee[4][9] <= ALPHABETCOLOR;
        tdee[4][10] <= ALPHABETCOLOR;
        tdee[4][11] <= ALPHABETCOLOR;
        tdee[4][12] <= ALPHABETCOLOR;
        tdee[4][13] <= BACKGROUND;
        tdee[4][14] <= ALPHABETCOLOR;
        tdee[4][15] <= ALPHABETCOLOR;
        tdee[4][16] <= ALPHABETCOLOR;
        tdee[4][17] <= ALPHABETCOLOR;
        tdee[4][18] <= BACKGROUND;
        tdee[4][19] <= BACKGROUND;
                                      
    //////////////////////////////// 

        
    //////////////////////////////// fast
        
        bfast[0][0] <= ALPHABETCOLOR;
        bfast[0][1] <= ALPHABETCOLOR;
        bfast[0][2] <= ALPHABETCOLOR;
        bfast[0][3] <= BACKGROUND;
        bfast[0][4] <= BACKGROUND;
        bfast[0][5] <= ALPHABETCOLOR;
        bfast[0][6] <= ALPHABETCOLOR;
        bfast[0][7] <= ALPHABETCOLOR;
        bfast[0][8] <= ALPHABETCOLOR;
        bfast[0][9] <= BACKGROUND;
        bfast[0][10] <= BACKGROUND;
        bfast[0][11] <= ALPHABETCOLOR;
        bfast[0][12] <= ALPHABETCOLOR;
        bfast[0][13] <= BACKGROUND;
        bfast[0][14] <= BACKGROUND;
        bfast[0][15] <= BACKGROUND;
        bfast[0][16] <= ALPHABETCOLOR;
        bfast[0][17] <= ALPHABETCOLOR;
        bfast[0][18] <= ALPHABETCOLOR;
        bfast[0][19] <= BACKGROUND;
        bfast[0][20] <= ALPHABETCOLOR;
        bfast[0][21] <= ALPHABETCOLOR;
        bfast[0][22] <= ALPHABETCOLOR;
 
        bfast[1][0] <= ALPHABETCOLOR;
        bfast[1][1] <= BACKGROUND;
        bfast[1][2] <= BACKGROUND;
        bfast[1][3] <= ALPHABETCOLOR;
        bfast[1][4] <= BACKGROUND;
        bfast[1][5] <= ALPHABETCOLOR;
        bfast[1][6] <= BACKGROUND;
        bfast[1][7] <= BACKGROUND;
        bfast[1][8] <= BACKGROUND;
        bfast[1][9] <= BACKGROUND;
        bfast[1][10] <= ALPHABETCOLOR;
        bfast[1][11] <= BACKGROUND;
        bfast[1][12] <= BACKGROUND;
        bfast[1][13] <= ALPHABETCOLOR;
        bfast[1][14] <= BACKGROUND;
        bfast[1][15] <= ALPHABETCOLOR;
        bfast[1][16] <= BACKGROUND;
        bfast[1][17] <= BACKGROUND;
        bfast[1][18] <= BACKGROUND;
        bfast[1][19] <= BACKGROUND;
        bfast[1][20] <= BACKGROUND;
        bfast[1][21] <= ALPHABETCOLOR;
        bfast[1][22] <= BACKGROUND;
        
        bfast[2][0] <= ALPHABETCOLOR;
        bfast[2][1] <= ALPHABETCOLOR;
        bfast[2][2] <= ALPHABETCOLOR;
        bfast[2][3] <= BACKGROUND;
        bfast[2][4] <= BACKGROUND;
        bfast[2][5] <= ALPHABETCOLOR;
        bfast[2][6] <= ALPHABETCOLOR;
        bfast[2][7] <= ALPHABETCOLOR;
        bfast[2][8] <= BACKGROUND;
        bfast[2][9] <= BACKGROUND;
        bfast[2][10] <= ALPHABETCOLOR;
        bfast[2][11] <= ALPHABETCOLOR;
        bfast[2][12] <= ALPHABETCOLOR;
        bfast[2][13] <= ALPHABETCOLOR;
        bfast[2][14] <= BACKGROUND;
        bfast[2][15] <= BACKGROUND;
        bfast[2][16] <= ALPHABETCOLOR;
        bfast[2][17] <= ALPHABETCOLOR;
        bfast[2][18] <= BACKGROUND;
        bfast[2][19] <= BACKGROUND;
        bfast[2][20] <= BACKGROUND;
        bfast[2][21] <= ALPHABETCOLOR;
        bfast[2][22] <= BACKGROUND;
        
        bfast[3][0] <= ALPHABETCOLOR;
        bfast[3][1] <= BACKGROUND;
        bfast[3][2] <= BACKGROUND;
        bfast[3][3] <= ALPHABETCOLOR;
        bfast[3][4] <= BACKGROUND;
        bfast[3][5] <= ALPHABETCOLOR;
        bfast[3][6] <= BACKGROUND;
        bfast[3][7] <= BACKGROUND;
        bfast[3][8] <= BACKGROUND;
        bfast[3][9] <= BACKGROUND;
        bfast[3][10] <= ALPHABETCOLOR;
        bfast[3][11] <= BACKGROUND;
        bfast[3][12] <= BACKGROUND;
        bfast[3][13] <= ALPHABETCOLOR;
        bfast[3][14] <= BACKGROUND;
        bfast[3][15] <= BACKGROUND;
        bfast[3][16] <= BACKGROUND;
        bfast[3][17] <= BACKGROUND;
        bfast[3][18] <= ALPHABETCOLOR;
        bfast[3][19] <= BACKGROUND;
        bfast[3][20] <= BACKGROUND;
        bfast[3][21] <= ALPHABETCOLOR;
        bfast[3][22] <= BACKGROUND;
        
        bfast[4][0] <= ALPHABETCOLOR;
        bfast[4][1] <= ALPHABETCOLOR;
        bfast[4][2] <= ALPHABETCOLOR;
        bfast[4][3] <= BACKGROUND;
        bfast[4][4] <= BACKGROUND;
        bfast[4][5] <= ALPHABETCOLOR;
        bfast[4][6] <= BACKGROUND;
        bfast[4][7] <= BACKGROUND;
        bfast[4][8] <= BACKGROUND;
        bfast[4][9] <= BACKGROUND;
        bfast[4][10] <= ALPHABETCOLOR;
        bfast[4][11] <= BACKGROUND;
        bfast[4][12] <= BACKGROUND;
        bfast[4][13] <= ALPHABETCOLOR;
        bfast[4][14] <= BACKGROUND;
        bfast[4][15] <= ALPHABETCOLOR;
        bfast[4][16] <= ALPHABETCOLOR;
        bfast[4][17] <= ALPHABETCOLOR;
        bfast[4][18] <= BACKGROUND;
        bfast[4][19] <= BACKGROUND;
        bfast[4][20] <= BACKGROUND;
        bfast[4][21] <= ALPHABETCOLOR;
        bfast[4][22] <= BACKGROUND;                                
    ////////////////////////////////    
    
    //////////////////////////////// lunch
        
        lunch[0][0] <= ALPHABETCOLOR;
        lunch[0][1] <= BACKGROUND;
        lunch[0][2] <= BACKGROUND;
        lunch[0][3] <= BACKGROUND;
        lunch[0][4] <= ALPHABETCOLOR;
        lunch[0][5] <= BACKGROUND;
        lunch[0][6] <= BACKGROUND;
        lunch[0][7] <= ALPHABETCOLOR;
        lunch[0][8] <= BACKGROUND;
        lunch[0][9] <= ALPHABETCOLOR;
        lunch[0][10] <= BACKGROUND;
        lunch[0][11] <= BACKGROUND;
        lunch[0][12] <= ALPHABETCOLOR;
        lunch[0][13] <= BACKGROUND;
        lunch[0][14] <= BACKGROUND;
        lunch[0][15] <= ALPHABETCOLOR;
        lunch[0][16] <= ALPHABETCOLOR;
        lunch[0][17] <= ALPHABETCOLOR;
        lunch[0][18] <= BACKGROUND;
        lunch[0][19] <= ALPHABETCOLOR;
        lunch[0][20] <= BACKGROUND;
        lunch[0][21] <= BACKGROUND;
        lunch[0][22] <= ALPHABETCOLOR;
 
        lunch[1][0] <= ALPHABETCOLOR;
        lunch[1][1] <= BACKGROUND;
        lunch[1][2] <= BACKGROUND;
        lunch[1][3] <= BACKGROUND;
        lunch[1][4] <= ALPHABETCOLOR;
        lunch[1][5] <= BACKGROUND;
        lunch[1][6] <= BACKGROUND;
        lunch[1][7] <= ALPHABETCOLOR;
        lunch[1][8] <= BACKGROUND;
        lunch[1][9] <= ALPHABETCOLOR;
        lunch[1][10] <= ALPHABETCOLOR;
        lunch[1][11] <= BACKGROUND;
        lunch[1][12] <= ALPHABETCOLOR;
        lunch[1][13] <= BACKGROUND;
        lunch[1][14] <= ALPHABETCOLOR;
        lunch[1][15] <= BACKGROUND;
        lunch[1][16] <= BACKGROUND;
        lunch[1][17] <= BACKGROUND;
        lunch[1][18] <= BACKGROUND;
        lunch[1][19] <= ALPHABETCOLOR;
        lunch[1][20] <= BACKGROUND;
        lunch[1][21] <= BACKGROUND;
        lunch[1][22] <= ALPHABETCOLOR;
        
        lunch[2][0] <= ALPHABETCOLOR;
        lunch[2][1] <= BACKGROUND;
        lunch[2][2] <= BACKGROUND;
        lunch[2][3] <= BACKGROUND;
        lunch[2][4] <= ALPHABETCOLOR;
        lunch[2][5] <= BACKGROUND;
        lunch[2][6] <= BACKGROUND;
        lunch[2][7] <= ALPHABETCOLOR;
        lunch[2][8] <= BACKGROUND;
        lunch[2][9] <= ALPHABETCOLOR;
        lunch[2][10] <= BACKGROUND;
        lunch[2][11] <= ALPHABETCOLOR;
        lunch[2][12] <= ALPHABETCOLOR;
        lunch[2][13] <= BACKGROUND;
        lunch[2][14] <= ALPHABETCOLOR;
        lunch[2][15] <= BACKGROUND;
        lunch[2][16] <= BACKGROUND;
        lunch[2][17] <= BACKGROUND;
        lunch[2][18] <= BACKGROUND;
        lunch[2][19] <= ALPHABETCOLOR;
        lunch[2][20] <= ALPHABETCOLOR;
        lunch[2][21] <= ALPHABETCOLOR;
        lunch[2][22] <= ALPHABETCOLOR;
        
        lunch[3][0] <= ALPHABETCOLOR;
        lunch[3][1] <= BACKGROUND;
        lunch[3][2] <= BACKGROUND;
        lunch[3][3] <= BACKGROUND;
        lunch[3][4] <= ALPHABETCOLOR;
        lunch[3][5] <= BACKGROUND;
        lunch[3][6] <= BACKGROUND;
        lunch[3][7] <= ALPHABETCOLOR;
        lunch[3][8] <= BACKGROUND;
        lunch[3][9] <= ALPHABETCOLOR;
        lunch[3][10] <= BACKGROUND;
        lunch[3][11] <= BACKGROUND;
        lunch[3][12] <= ALPHABETCOLOR;
        lunch[3][13] <= BACKGROUND;
        lunch[3][14] <= ALPHABETCOLOR;
        lunch[3][15] <= BACKGROUND;
        lunch[3][16] <= BACKGROUND;
        lunch[3][17] <= BACKGROUND;
        lunch[3][18] <= BACKGROUND;
        lunch[3][19] <= ALPHABETCOLOR;
        lunch[3][20] <= BACKGROUND;
        lunch[3][21] <= BACKGROUND;
        lunch[3][22] <= ALPHABETCOLOR;
        
        lunch[4][0] <= ALPHABETCOLOR;
        lunch[4][1] <= ALPHABETCOLOR;
        lunch[4][2] <= ALPHABETCOLOR;
        lunch[4][3] <= BACKGROUND;
        lunch[4][4] <= BACKGROUND;
        lunch[4][5] <= ALPHABETCOLOR;
        lunch[4][6] <= ALPHABETCOLOR;
        lunch[4][7] <= BACKGROUND;
        lunch[4][8] <= BACKGROUND;
        lunch[4][9] <= ALPHABETCOLOR;
        lunch[4][10] <= BACKGROUND;
        lunch[4][11] <= BACKGROUND;
        lunch[4][12] <= ALPHABETCOLOR;
        lunch[4][13] <= BACKGROUND;
        lunch[4][14] <= BACKGROUND;
        lunch[4][15] <= ALPHABETCOLOR;
        lunch[4][16] <= ALPHABETCOLOR;
        lunch[4][17] <= ALPHABETCOLOR;
        lunch[4][18] <= BACKGROUND;
        lunch[4][19] <= ALPHABETCOLOR;
        lunch[4][20] <= BACKGROUND;
        lunch[4][21] <= BACKGROUND;
        lunch[4][22] <= ALPHABETCOLOR;                                
    ////////////////////////////////
    
    //////////////////////////////// dinner
        
        dinner[0][0] <= ALPHABETCOLOR;
        dinner[0][1] <= ALPHABETCOLOR;
        dinner[0][2] <= ALPHABETCOLOR;
        dinner[0][3] <= BACKGROUND;
        dinner[0][4] <= BACKGROUND;
        dinner[0][5] <= ALPHABETCOLOR;
        dinner[0][6] <= BACKGROUND;
        dinner[0][7] <= ALPHABETCOLOR;
        dinner[0][8] <= BACKGROUND;
        dinner[0][9] <= BACKGROUND;
        dinner[0][10] <= ALPHABETCOLOR;
        dinner[0][11] <= BACKGROUND;
        dinner[0][12] <= ALPHABETCOLOR;
        dinner[0][13] <= BACKGROUND;
        dinner[0][14] <= BACKGROUND;
        dinner[0][15] <= ALPHABETCOLOR;
        dinner[0][16] <= BACKGROUND;
        dinner[0][17] <= ALPHABETCOLOR;
        dinner[0][18] <= ALPHABETCOLOR;
        dinner[0][19] <= ALPHABETCOLOR;
        dinner[0][20] <= ALPHABETCOLOR;
        dinner[0][21] <= BACKGROUND;
        dinner[0][22] <= ALPHABETCOLOR;
        dinner[0][23] <= ALPHABETCOLOR;
        dinner[0][24] <= ALPHABETCOLOR;
        dinner[0][25] <= BACKGROUND;
 
        dinner[1][0] <= ALPHABETCOLOR;
        dinner[1][1] <= BACKGROUND;
        dinner[1][2] <= BACKGROUND;
        dinner[1][3] <= ALPHABETCOLOR;
        dinner[1][4] <= BACKGROUND;
        dinner[1][5] <= ALPHABETCOLOR;
        dinner[1][6] <= BACKGROUND;
        dinner[1][7] <= ALPHABETCOLOR;
        dinner[1][8] <= ALPHABETCOLOR;
        dinner[1][9] <= BACKGROUND;
        dinner[1][10] <= ALPHABETCOLOR;
        dinner[1][11] <= BACKGROUND;
        dinner[1][12] <= ALPHABETCOLOR;
        dinner[1][13] <= ALPHABETCOLOR;
        dinner[1][14] <= BACKGROUND;
        dinner[1][15] <= ALPHABETCOLOR;
        dinner[1][16] <= BACKGROUND;
        dinner[1][17] <= ALPHABETCOLOR;
        dinner[1][18] <= BACKGROUND;
        dinner[1][19] <= BACKGROUND;
        dinner[1][20] <= BACKGROUND;
        dinner[1][21] <= BACKGROUND;
        dinner[1][22] <= ALPHABETCOLOR;
        dinner[1][23] <= BACKGROUND;
        dinner[1][24] <= BACKGROUND;
        dinner[1][25] <= ALPHABETCOLOR;
        
        
        dinner[2][0] <= ALPHABETCOLOR;
        dinner[2][1] <= BACKGROUND;
        dinner[2][2] <= BACKGROUND;
        dinner[2][3] <= ALPHABETCOLOR;
        dinner[2][4] <= BACKGROUND;
        dinner[2][5] <= ALPHABETCOLOR;
        dinner[2][6] <= BACKGROUND;
        dinner[2][7] <= ALPHABETCOLOR;
        dinner[2][8] <= BACKGROUND;
        dinner[2][9] <= ALPHABETCOLOR;
        dinner[2][10] <= ALPHABETCOLOR;
        dinner[2][11] <= BACKGROUND;
        dinner[2][12] <= ALPHABETCOLOR;
        dinner[2][13] <= BACKGROUND;
        dinner[2][14] <= ALPHABETCOLOR;
        dinner[2][15] <= ALPHABETCOLOR;
        dinner[2][16] <= BACKGROUND;
        dinner[2][17] <= ALPHABETCOLOR;
        dinner[2][18] <= ALPHABETCOLOR;
        dinner[2][19] <= ALPHABETCOLOR;
        dinner[2][20] <= BACKGROUND;
        dinner[2][21] <= BACKGROUND;
        dinner[2][22] <= ALPHABETCOLOR;
        dinner[2][23] <= ALPHABETCOLOR;
        dinner[2][24] <= ALPHABETCOLOR;
        dinner[2][25] <= BACKGROUND;
        
        dinner[3][0] <= ALPHABETCOLOR;
        dinner[3][1] <= BACKGROUND;
        dinner[3][2] <= BACKGROUND;
        dinner[3][3] <= ALPHABETCOLOR;
        dinner[3][4] <= BACKGROUND;
        dinner[3][5] <= ALPHABETCOLOR;
        dinner[3][6] <= BACKGROUND;
        dinner[3][7] <= ALPHABETCOLOR;
        dinner[3][8] <= BACKGROUND;
        dinner[3][9] <= BACKGROUND;
        dinner[3][10] <= ALPHABETCOLOR;
        dinner[3][11] <= BACKGROUND;
        dinner[3][12] <= ALPHABETCOLOR;
        dinner[3][13] <= BACKGROUND;
        dinner[3][14] <= BACKGROUND;
        dinner[3][15] <= ALPHABETCOLOR;
        dinner[3][16] <= BACKGROUND;
        dinner[3][17] <= ALPHABETCOLOR;
        dinner[3][18] <= BACKGROUND;
        dinner[3][19] <= BACKGROUND;
        dinner[3][20] <= BACKGROUND;
        dinner[3][21] <= BACKGROUND;
        dinner[3][22] <= ALPHABETCOLOR;
        dinner[3][23] <= BACKGROUND;
        dinner[3][24] <= ALPHABETCOLOR;
        dinner[3][25] <= BACKGROUND;
        
        dinner[4][0] <= ALPHABETCOLOR;
        dinner[4][1] <= ALPHABETCOLOR;
        dinner[4][2] <= ALPHABETCOLOR;
        dinner[4][3] <= BACKGROUND;
        dinner[4][4] <= BACKGROUND;
        dinner[4][5] <= ALPHABETCOLOR;
        dinner[4][6] <= BACKGROUND;
        dinner[4][7] <= ALPHABETCOLOR;
        dinner[4][8] <= BACKGROUND;
        dinner[4][9] <= BACKGROUND;
        dinner[4][10] <= ALPHABETCOLOR;
        dinner[4][11] <= BACKGROUND;
        dinner[4][12] <= ALPHABETCOLOR;
        dinner[4][13] <= BACKGROUND;
        dinner[4][14] <= BACKGROUND;
        dinner[4][15] <= ALPHABETCOLOR;
        dinner[4][16] <= BACKGROUND;
        dinner[4][17] <= ALPHABETCOLOR;
        dinner[4][18] <= ALPHABETCOLOR;
        dinner[4][19] <= ALPHABETCOLOR;
        dinner[4][20] <= ALPHABETCOLOR;
        dinner[4][21] <= BACKGROUND;
        dinner[4][22] <= ALPHABETCOLOR;   
        dinner[4][23] <= BACKGROUND; 
        dinner[4][24] <= BACKGROUND; 
        dinner[4][25] <= ALPHABETCOLOR;                              
    ////////////////////////////////    
    
    //////////////////////////////// cal word
        
        cal[0][0] <= BACKGROUND;
        cal[0][1] <= ALPHABETCOLOR;
        cal[0][2] <= ALPHABETCOLOR;
        cal[0][3] <= ALPHABETCOLOR;
        cal[0][4] <= BACKGROUND;
        cal[0][5] <= BACKGROUND;
        cal[0][6] <= ALPHABETCOLOR;
        cal[0][7] <= ALPHABETCOLOR;
        cal[0][8] <= BACKGROUND;
        cal[0][9] <= BACKGROUND;
        cal[0][10] <= ALPHABETCOLOR;
        cal[0][11] <= BACKGROUND;
        cal[0][12] <= BACKGROUND;
 
        cal[1][0] <= ALPHABETCOLOR;
        cal[1][1] <= BACKGROUND;
        cal[1][2] <= BACKGROUND;
        cal[1][3] <= BACKGROUND;
        cal[1][4] <= BACKGROUND;
        cal[1][5] <= ALPHABETCOLOR;
        cal[1][6] <= BACKGROUND;
        cal[1][7] <= BACKGROUND;
        cal[1][8] <= ALPHABETCOLOR;
        cal[1][9] <= BACKGROUND;
        cal[1][10] <= ALPHABETCOLOR;
        cal[1][11] <= BACKGROUND;
        cal[1][12] <= BACKGROUND;
        
        cal[2][0] <= ALPHABETCOLOR;
        cal[2][1] <= BACKGROUND;
        cal[2][2] <= BACKGROUND;
        cal[2][3] <= BACKGROUND;
        cal[2][4] <= BACKGROUND;
        cal[2][5] <= ALPHABETCOLOR;
        cal[2][6] <= ALPHABETCOLOR;
        cal[2][7] <= ALPHABETCOLOR;
        cal[2][8] <= ALPHABETCOLOR;
        cal[2][9] <= BACKGROUND;
        cal[2][10] <= ALPHABETCOLOR;
        cal[2][11] <= BACKGROUND;
        cal[2][12] <= BACKGROUND;
        
        cal[3][0] <= ALPHABETCOLOR;
        cal[3][1] <= BACKGROUND;
        cal[3][2] <= BACKGROUND;
        cal[3][3] <= BACKGROUND;
        cal[3][4] <= BACKGROUND;
        cal[3][5] <= ALPHABETCOLOR;
        cal[3][6] <= BACKGROUND;
        cal[3][7] <= BACKGROUND;
        cal[3][8] <= ALPHABETCOLOR;
        cal[3][9] <= BACKGROUND;
        cal[3][10] <= ALPHABETCOLOR;
        cal[3][11] <= BACKGROUND;
        cal[3][12] <= BACKGROUND;
        
        cal[4][0] <= BACKGROUND;
        cal[4][1] <= ALPHABETCOLOR;
        cal[4][2] <= ALPHABETCOLOR;
        cal[4][3] <= ALPHABETCOLOR;
        cal[4][4] <= BACKGROUND;
        cal[4][5] <= ALPHABETCOLOR;
        cal[4][6] <= BACKGROUND;
        cal[4][7] <= BACKGROUND;
        cal[4][8] <= ALPHABETCOLOR;
        cal[4][9] <= BACKGROUND;
        cal[4][10] <= ALPHABETCOLOR;
        cal[4][11] <= ALPHABETCOLOR;
        cal[4][12] <= ALPHABETCOLOR;                           
    ////////////////////////////////       
        
    //////////////////////////////// Digit 0
       digit0[0][0] <= BACKGROUND;
       digit0[0][1] <= DIGITCOLOR;
       digit0[0][2] <= DIGITCOLOR;
       digit0[0][3] <= BACKGROUND;
    
       digit0[1][0] <= DIGITCOLOR;
       digit0[1][1] <= BACKGROUND;
       digit0[1][2] <= BACKGROUND;
       digit0[1][3] <= DIGITCOLOR;
    
       digit0[2][0] <= DIGITCOLOR;
       digit0[2][1] <= BACKGROUND;
       digit0[2][2] <= BACKGROUND;
       digit0[2][3] <= DIGITCOLOR;       
    
       digit0[3][0] <= DIGITCOLOR;
       digit0[3][1] <= BACKGROUND;
       digit0[3][2] <= BACKGROUND;
       digit0[3][3] <= DIGITCOLOR; 
    
       digit0[4][0] <= DIGITCOLOR;
       digit0[4][1] <= BACKGROUND;
       digit0[4][2] <= BACKGROUND;
       digit0[4][3] <= DIGITCOLOR;       
    
       digit0[5][0] <= DIGITCOLOR;
       digit0[5][1] <= BACKGROUND;
       digit0[5][2] <= BACKGROUND;
       digit0[5][3] <= DIGITCOLOR;       
    
       digit0[6][0] <= BACKGROUND;
       digit0[6][1] <= DIGITCOLOR;
       digit0[6][2] <= DIGITCOLOR;
       digit0[6][3] <= BACKGROUND;    
    /////////////////////////////////  
    
    //////////////////////////////// Digit 1
       digit1[0][0] <= BACKGROUND;
       digit1[0][1] <= BACKGROUND;
       digit1[0][2] <= DIGITCOLOR;
       digit1[0][3] <= BACKGROUND;
    
       digit1[1][0] <= BACKGROUND;
       digit1[1][1] <= DIGITCOLOR;
       digit1[1][2] <= DIGITCOLOR;
       digit1[1][3] <= BACKGROUND;
    
       digit1[2][0] <= DIGITCOLOR;
       digit1[2][1] <= BACKGROUND;
       digit1[2][2] <= DIGITCOLOR;
       digit1[2][3] <= BACKGROUND;       
    
       digit1[3][0] <= BACKGROUND;
       digit1[3][1] <= BACKGROUND;
       digit1[3][2] <= DIGITCOLOR;
       digit1[3][3] <= BACKGROUND; 
    
       digit1[4][0] <= BACKGROUND;
       digit1[4][1] <= BACKGROUND;
       digit1[4][2] <= DIGITCOLOR;
       digit1[4][3] <= BACKGROUND;       
    
       digit1[5][0] <= BACKGROUND;
       digit1[5][1] <= BACKGROUND;
       digit1[5][2] <= DIGITCOLOR;
       digit1[5][3] <= BACKGROUND;       
    
       digit1[6][0] <= BACKGROUND;
       digit1[6][1] <= BACKGROUND;
       digit1[6][2] <= DIGITCOLOR;
       digit1[6][3] <= BACKGROUND;    
    /////////////////////////////////    
  
    //////////////////////////////// Digit 2
       digit2[0][0] <= BACKGROUND;
       digit2[0][1] <= DIGITCOLOR;
       digit2[0][2] <= DIGITCOLOR;
       digit2[0][3] <= BACKGROUND;
    
       digit2[1][0] <= DIGITCOLOR;
       digit2[1][1] <= BACKGROUND;
       digit2[1][2] <= BACKGROUND;
       digit2[1][3] <= DIGITCOLOR;
    
       digit2[2][0] <= BACKGROUND;
       digit2[2][1] <= BACKGROUND;
       digit2[2][2] <= BACKGROUND;
       digit2[2][3] <= DIGITCOLOR;       
    
       digit2[3][0] <= BACKGROUND;
       digit2[3][1] <= BACKGROUND;
       digit2[3][2] <= DIGITCOLOR;
       digit2[3][3] <= BACKGROUND; 
    
       digit2[4][0] <= BACKGROUND;
       digit2[4][1] <= DIGITCOLOR;
       digit2[4][2] <= BACKGROUND;
       digit2[4][3] <= BACKGROUND;       
    
       digit2[5][0] <= DIGITCOLOR;
       digit2[5][1] <= BACKGROUND;
       digit2[5][2] <= BACKGROUND;
       digit2[5][3] <= BACKGROUND;       
    
       digit2[6][0] <= DIGITCOLOR;
       digit2[6][1] <= DIGITCOLOR;
       digit2[6][2] <= DIGITCOLOR;
       digit2[6][3] <= DIGITCOLOR;    
    /////////////////////////////////  
    
    //////////////////////////////// Digit 3
       digit3[0][0] <= BACKGROUND;
       digit3[0][1] <= DIGITCOLOR;
       digit3[0][2] <= DIGITCOLOR;
       digit3[0][3] <= BACKGROUND;
    
       digit3[1][0] <= DIGITCOLOR;
       digit3[1][1] <= BACKGROUND;
       digit3[1][2] <= BACKGROUND;
       digit3[1][3] <= DIGITCOLOR;
    
       digit3[2][0] <= BACKGROUND;
       digit3[2][1] <= BACKGROUND;
       digit3[2][2] <= BACKGROUND;
       digit3[2][3] <= DIGITCOLOR;       
    
       digit3[3][0] <= BACKGROUND;
       digit3[3][1] <= DIGITCOLOR;
       digit3[3][2] <= DIGITCOLOR;
       digit3[3][3] <= BACKGROUND; 
    
       digit3[4][0] <= BACKGROUND;
       digit3[4][1] <= BACKGROUND;
       digit3[4][2] <= BACKGROUND;
       digit3[4][3] <= DIGITCOLOR;       
    
       digit3[5][0] <= DIGITCOLOR;
       digit3[5][1] <= BACKGROUND;
       digit3[5][2] <= BACKGROUND;
       digit3[5][3] <= DIGITCOLOR;       
    
       digit3[6][0] <= BACKGROUND;
       digit3[6][1] <= DIGITCOLOR;
       digit3[6][2] <= DIGITCOLOR;
       digit3[6][3] <= BACKGROUND;    
    ///////////////////////////////// 
    
    //////////////////////////////// Digit 4
       digit4[0][0] <= BACKGROUND;
       digit4[0][1] <= BACKGROUND;
       digit4[0][2] <= BACKGROUND;
       digit4[0][3] <= DIGITCOLOR;
    
       digit4[1][0] <= BACKGROUND;
       digit4[1][1] <= BACKGROUND;
       digit4[1][2] <= DIGITCOLOR;
       digit4[1][3] <= DIGITCOLOR;
    
       digit4[2][0] <= BACKGROUND;
       digit4[2][1] <= DIGITCOLOR;
       digit4[2][2] <= BACKGROUND;
       digit4[2][3] <= DIGITCOLOR;       
    
       digit4[3][0] <= DIGITCOLOR;
       digit4[3][1] <= BACKGROUND;
       digit4[3][2] <= BACKGROUND;
       digit4[3][3] <= DIGITCOLOR; 
    
       digit4[4][0] <= DIGITCOLOR;
       digit4[4][1] <= DIGITCOLOR;
       digit4[4][2] <= DIGITCOLOR;
       digit4[4][3] <= DIGITCOLOR;       
    
       digit4[5][0] <= BACKGROUND;
       digit4[5][1] <= BACKGROUND;
       digit4[5][2] <= BACKGROUND;
       digit4[5][3] <= DIGITCOLOR;       
    
       digit4[6][0] <= BACKGROUND;
       digit4[6][1] <= BACKGROUND;
       digit4[6][2] <= BACKGROUND;
       digit4[6][3] <= DIGITCOLOR;    
    ///////////////////////////////// 
    
    //////////////////////////////// Digit 5
       digit5[0][0] <= DIGITCOLOR;
       digit5[0][1] <= DIGITCOLOR;
       digit5[0][2] <= DIGITCOLOR;
       digit5[0][3] <= DIGITCOLOR;
    
       digit5[1][0] <= DIGITCOLOR;
       digit5[1][1] <= BACKGROUND;
       digit5[1][2] <= BACKGROUND;
       digit5[1][3] <= BACKGROUND;
    
       digit5[2][0] <= DIGITCOLOR;
       digit5[2][1] <= DIGITCOLOR;
       digit5[2][2] <= DIGITCOLOR;
       digit5[2][3] <= BACKGROUND;       
    
       digit5[3][0] <= BACKGROUND;
       digit5[3][1] <= BACKGROUND;
       digit5[3][2] <= BACKGROUND;
       digit5[3][3] <= DIGITCOLOR; 
    
       digit5[4][0] <= BACKGROUND;
       digit5[4][1] <= BACKGROUND;
       digit5[4][2] <= BACKGROUND;
       digit5[4][3] <= DIGITCOLOR;       
    
       digit5[5][0] <= DIGITCOLOR;
       digit5[5][1] <= BACKGROUND;
       digit5[5][2] <= BACKGROUND;
       digit5[5][3] <= DIGITCOLOR;       
    
       digit5[6][0] <= BACKGROUND;
       digit5[6][1] <= DIGITCOLOR;
       digit5[6][2] <= DIGITCOLOR;
       digit5[6][3] <= BACKGROUND;    
    /////////////////////////////////     
    
    //////////////////////////////// Digit 6
       digit6[0][0] <= BACKGROUND;
       digit6[0][1] <= DIGITCOLOR;
       digit6[0][2] <= DIGITCOLOR;
       digit6[0][3] <= BACKGROUND;
    
       digit6[1][0] <= DIGITCOLOR;
       digit6[1][1] <= BACKGROUND;
       digit6[1][2] <= BACKGROUND;
       digit6[1][3] <= DIGITCOLOR;
    
       digit6[2][0] <= DIGITCOLOR;
       digit6[2][1] <= BACKGROUND;
       digit6[2][2] <= BACKGROUND;
       digit6[2][3] <= BACKGROUND;       
    
       digit6[3][0] <= DIGITCOLOR;
       digit6[3][1] <= DIGITCOLOR;
       digit6[3][2] <= DIGITCOLOR;
       digit6[3][3] <= BACKGROUND; 
    
       digit6[4][0] <= DIGITCOLOR;
       digit6[4][1] <= BACKGROUND;
       digit6[4][2] <= BACKGROUND;
       digit6[4][3] <= DIGITCOLOR;       
    
       digit6[5][0] <= DIGITCOLOR;
       digit6[5][1] <= BACKGROUND;
       digit6[5][2] <= BACKGROUND;
       digit6[5][3] <= DIGITCOLOR;       
    
       digit6[6][0] <= BACKGROUND;
       digit6[6][1] <= DIGITCOLOR;
       digit6[6][2] <= DIGITCOLOR;
       digit6[6][3] <= BACKGROUND;    
    /////////////////////////////////     
    
    //////////////////////////////// Digit 7
       digit7[0][0] <= DIGITCOLOR;
       digit7[0][1] <= DIGITCOLOR;
       digit7[0][2] <= DIGITCOLOR;
       digit7[0][3] <= DIGITCOLOR;
    
       digit7[1][0] <= BACKGROUND;
       digit7[1][1] <= BACKGROUND;
       digit7[1][2] <= BACKGROUND;
       digit7[1][3] <= DIGITCOLOR;
    
       digit7[2][0] <= BACKGROUND;
       digit7[2][1] <= BACKGROUND;
       digit7[2][2] <= BACKGROUND;
       digit7[2][3] <= DIGITCOLOR;       
   
       digit7[3][0] <= BACKGROUND;
       digit7[3][1] <= BACKGROUND;
       digit7[3][2] <= DIGITCOLOR;
       digit7[3][3] <= BACKGROUND; 
    
       digit7[4][0] <= BACKGROUND;
       digit7[4][1] <= DIGITCOLOR;
       digit7[4][2] <= BACKGROUND;
       digit7[4][3] <= BACKGROUND;       
    
       digit7[5][0] <= BACKGROUND;
       digit7[5][1] <= DIGITCOLOR;
       digit7[5][2] <= BACKGROUND;
       digit7[5][3] <= BACKGROUND;       
    
       digit7[6][0] <= BACKGROUND;
       digit7[6][1] <= DIGITCOLOR;
       digit7[6][2] <= BACKGROUND;
       digit7[6][3] <= BACKGROUND;    
    /////////////////////////////////            
    
    //////////////////////////////// Digit 8
       digit8[0][0] <= BACKGROUND;
       digit8[0][1] <= DIGITCOLOR;
       digit8[0][2] <= DIGITCOLOR;
       digit8[0][3] <= BACKGROUND;
    
       digit8[1][0] <= DIGITCOLOR;
       digit8[1][1] <= BACKGROUND;
       digit8[1][2] <= BACKGROUND;
       digit8[1][3] <= DIGITCOLOR;
    
       digit8[2][0] <= DIGITCOLOR;
       digit8[2][1] <= BACKGROUND;
       digit8[2][2] <= BACKGROUND;
       digit8[2][3] <= DIGITCOLOR;       
    
       digit8[3][0] <= BACKGROUND;
       digit8[3][1] <= DIGITCOLOR;
       digit8[3][2] <= DIGITCOLOR;
       digit8[3][3] <= BACKGROUND; 
    
       digit8[4][0] <= DIGITCOLOR;
       digit8[4][1] <= BACKGROUND;
       digit8[4][2] <= BACKGROUND;
       digit8[4][3] <= DIGITCOLOR;       
    
       digit8[5][0] <= DIGITCOLOR;
       digit8[5][1] <= BACKGROUND;
       digit8[5][2] <= BACKGROUND;
       digit8[5][3] <= DIGITCOLOR;       
    
       digit8[6][0] <= BACKGROUND;
       digit8[6][1] <= DIGITCOLOR;
       digit8[6][2] <= DIGITCOLOR;
       digit8[6][3] <= BACKGROUND;    
    /////////////////////////////////         
   
    //////////////////////////////// Digit 9
       digit9[0][0] <= BACKGROUND;
       digit9[0][1] <= DIGITCOLOR;
       digit9[0][2] <= DIGITCOLOR;
       digit9[0][3] <= BACKGROUND;
    
       digit9[1][0] <= DIGITCOLOR;
       digit9[1][1] <= BACKGROUND;
       digit9[1][2] <= BACKGROUND;
       digit9[1][3] <= DIGITCOLOR;
    
       digit9[2][0] <= DIGITCOLOR;
       digit9[2][1] <= BACKGROUND;
       digit9[2][2] <= BACKGROUND;
       digit9[2][3] <= DIGITCOLOR;       
    
       digit9[3][0] <= BACKGROUND;
       digit9[3][1] <= DIGITCOLOR;
       digit9[3][2] <= DIGITCOLOR;
       digit9[3][3] <= DIGITCOLOR; 
    
       digit9[4][0] <= BACKGROUND;
       digit9[4][1] <= BACKGROUND;
       digit9[4][2] <= BACKGROUND;
       digit9[4][3] <= DIGITCOLOR;       
    
       digit9[5][0] <= DIGITCOLOR;
       digit9[5][1] <= BACKGROUND;
       digit9[5][2] <= BACKGROUND;
       digit9[5][3] <= DIGITCOLOR;       
    
       digit9[6][0] <= BACKGROUND;
       digit9[6][1] <= DIGITCOLOR;
       digit9[6][2] <= DIGITCOLOR;
       digit9[6][3] <= BACKGROUND;    
    /////////////////////////////////  
    
    //////////////////////////////// Digit Background
       digitBackGround [0][0] <= BACKGROUND;
       digitBackGround [0][1] <= BACKGROUND;
       digitBackGround [0][2] <= BACKGROUND;
       digitBackGround [0][3] <= BACKGROUND;
    
       digitBackGround [1][0] <= BACKGROUND;
       digitBackGround [1][1] <= BACKGROUND;
       digitBackGround [1][2] <= BACKGROUND;
       digitBackGround [1][3] <= BACKGROUND;
    
       digitBackGround [2][0] <= BACKGROUND;
       digitBackGround [2][1] <= BACKGROUND;
       digitBackGround [2][2] <= BACKGROUND;
       digitBackGround [2][3] <= BACKGROUND;       
    
       digitBackGround [3][0] <= BACKGROUND;
       digitBackGround [3][1] <= BACKGROUND;
       digitBackGround [3][2] <= BACKGROUND;
       digitBackGround [3][3] <= BACKGROUND; 
    
       digitBackGround [4][0] <= BACKGROUND;
       digitBackGround [4][1] <= BACKGROUND;
       digitBackGround [4][2] <= BACKGROUND;
       digitBackGround [4][3] <= BACKGROUND;       
    
       digitBackGround [5][0] <= BACKGROUND;
       digitBackGround [5][1] <= BACKGROUND;
       digitBackGround[5][2] <= BACKGROUND;
       digitBackGround[5][3] <= BACKGROUND;       
    
       digitBackGround[6][0] <= BACKGROUND;
       digitBackGround[6][1] <= BACKGROUND;
       digitBackGround[6][2] <= BACKGROUND;
       digitBackGround[6][3] <= BACKGROUND;    
    /////////////////////////////////   
    
        //////////////////////////////// dashline
       dashline [0][0] <= BACKGROUND;
       dashline [0][1] <= BACKGROUND;
       dashline [0][2] <= BACKGROUND;
       dashline [0][3] <= BACKGROUND;
    
       dashline [1][0] <= BACKGROUND;
       dashline [1][1] <= BACKGROUND;
       dashline [1][2] <= BACKGROUND;
       dashline [1][3] <= BACKGROUND;
    
       dashline [2][0] <= BACKGROUND;
       dashline [2][1] <= BACKGROUND;
       dashline [2][2] <= BACKGROUND;
       dashline [2][3] <= BACKGROUND;       
    
       dashline [3][0] <= BACKGROUND;
       dashline [3][1] <= DIGITCOLOR;
       dashline [3][2] <= DIGITCOLOR;
       dashline [3][3] <= BACKGROUND; 
    
       dashline [4][0] <= BACKGROUND;
       dashline [4][1] <= BACKGROUND;
       dashline [4][2] <= BACKGROUND;
       dashline [4][3] <= BACKGROUND;       
    
       dashline [5][0] <= BACKGROUND;
       dashline [5][1] <= BACKGROUND;
       dashline[5][2] <= BACKGROUND;
       dashline[5][3] <= BACKGROUND;       
    
       dashline[6][0] <= BACKGROUND;
       dashline[6][1] <= BACKGROUND;
       dashline[6][2] <= BACKGROUND;
       dashline[6][3] <= BACKGROUND;    
    /////////////////////////////////   
    
                           
    end
    
    //For button debouncing and forming of box
    reg [6:0] xLeft = 36;
    reg [6:0] xRight = 61;
    reg [6:0] yUp = 22;
    reg [6:0] yDown = 32;
    reg [5:0] boxNum = 1;
    reg movedLeft = 0;
    reg movedRight = 0;
    reg movedUp = 0;
    reg movedDown = 0;
    reg movedCenter = 0;
    parameter DEBOUNCE_COUNT = 625000;
    reg[31:0] counter = 0;
    reg isBack = 0;
    
    reg isToggled = 1;
    reg isControl = 1;
    
    always @ (posedge basys_clk) begin
        
        if (control == 2 && isControl) begin
            isMain <= 1;
            isControl <= 0;
        end else if (control == 0 || control == 3) begin
            isControl <= 1;
        end
        
        
        if (ari_rj_control == 1) begin
            ari_rj_control <= 0;    
        end
        
        
    
        displayA_num[0] <= (calorie_countA / 1000) % 10;
        displayA_num[1] <= (calorie_countA / 100) % 10;
        displayA_num[2] <= (calorie_countA / 10) % 10;
        displayA_num[3] <= calorie_countA % 10;
        
        displayB_num[0] <= (calorie_countB / 1000) % 10;
        displayB_num[1] <= (calorie_countB / 100) % 10;
        displayB_num[2] <= (calorie_countB / 10) % 10;
        displayB_num[3] <= calorie_countB % 10;
        
        displayC_num[0] <= (calorie_countC / 1000) % 10;
        displayC_num[1] <= (calorie_countC / 100) % 10;
        displayC_num[2] <= (calorie_countC / 10) % 10;
        displayC_num[3] <= calorie_countC % 10;        
        
        displayTDEE_num[0] <= (calorie_tdee / 1000) % 10;
        displayTDEE_num[1] <= (calorie_tdee / 100) % 10;
        displayTDEE_num[2] <= (calorie_tdee / 10) % 10;
        displayTDEE_num[3] <= calorie_tdee % 10;


        if (13 <= x && x <= 32 && 8 <= y && y <= 12) begin
            oled_data <= tdee[y-8][x-13]; //TDEE word  
        end else if (8 <= x && x <= 30 && 24 <= y && y <= 28) begin
            oled_data <= bfast[y-24][x-8]; //bfast word          
        end else if (8 <= x && x <= 30 && 37 <= y && y <= 41) begin
            oled_data <= lunch[y-37][x-8]; //lunch word
        end else if (7 <= x && x <= 32 && 50 <= y && y <= 54) begin
            oled_data <= dinner[y-50][x-7]; //dinner word
        end else if (xLeft <= x && x <= xRight && yUp <= y && y <= yDown && !((xLeft+1) <= x && x <= (xRight-1) && (yUp+1) <= y && y <= (yDown-1))) begin   
            if (isBack) begin
                oled_data <= BACKGROUND;
            end else begin
                oled_data <= BOXCOLOR;    //green border box
            end              
        end else if (64 <= x && x <= 76 && 8 <= y && y <= 12) begin    
            oled_data <= cal[y-8][x-64]; //cal tdee word            
        end else if (65 <= x && x <= 77 && 25 <= y && y <= 29) begin    
            oled_data <= cal[y-25][x-65]; //cal A word
        end else if (65 <= x && x <= 77 && 38 <= y && y <= 42) begin    
            oled_data <= cal[y-38][x-65]; //cal B word
        end else if (65 <= x && x <= 77 && 51 <= y && y <= 55) begin    
            oled_data <= cal[y-51][x-65]; // cal C word 
        end else if (8 <= x && x <= 30 && (x%2 == 1) && (y == 30 || y == 43)) begin   
            oled_data <= ALPHABETCOLOR;  //underline for bfast and lunch
        end else if (7 <= x && x <= 32 && (x%2 == 1) && y == 56) begin   
            oled_data <= ALPHABETCOLOR;  //underline for dinner
        end else if (10 <= x && x <= 80 && 4 <= y && y <= 16 && !((10+1) <= x && x <= (80-1) && (4+1) <= y && y <= (16-1)) && (x%2 == 0) && (y%2 == 0)) begin   
            oled_data <= 16'hFFFF;    //TDEE box            
        end else if ((y==7 && 3 <= x && x <= 4) ||
                     (y==8 && 2 <= x && x <= 3 ) || 
                     (y==9 && 1 <= x && x <= 2) || 
                     (y==10 && 0 <= x && x <= 1) ||
                     (y==11 && 1 <= x && x <= 2) ||
                     (y==12 && 2 <= x && x <= 3) || 
                     (y==13 && 3 <= x && x <= 4)) begin   //for back arrow
            if (isBack) begin
                oled_data <= BOXCOLOR;    
            end else begin
                oled_data <= 16'hFFFF;                
            end            
        end else if (38 <= x && x <= 41 && 7 <= y && y <= 13) begin //display TDEE 0
                
                if (calorie_tdee == 0) begin
                    oled_data <= dashline[y-7][x-38];
                end else if (displayTDEE_num[0] == 0) begin 
                    oled_data <= digitBackGround[y-7][x-38];
                end else if (displayTDEE_num[0] == 1) begin
                    oled_data <= digit1[y-7][x-38];
                end else if (displayTDEE_num[0] == 2) begin
                    oled_data <= digit2[y-7][x-38];
                end else if (displayTDEE_num[0] == 3) begin
                    oled_data <= digit3[y-7][x-38];
                end else if (displayTDEE_num[0] == 4) begin
                    oled_data <= digit4[y-7][x-38];
                end else if (displayTDEE_num[0] == 5) begin
                    oled_data <= digit5[y-7][x-38];
                end else if (displayTDEE_num[0] == 6) begin
                    oled_data <= digit6[y-7][x-38];
                end else if (displayTDEE_num[0] == 7) begin
                    oled_data <= digit7[y-7][x-38];
                end else if (displayTDEE_num[0] == 8) begin
                    oled_data <= digit8[y-7][x-38];
                end else if (displayTDEE_num[0] == 9) begin
                    oled_data <= digit9[y-7][x-38];
                end else begin
                    oled_data <= digitBackGround[y-7][x-38];
                end                
                
            end else if (44 <= x && x <= 47 && 7 <= y && y <= 13) begin //display TDEE 1
    
                if (calorie_tdee == 0) begin
                    oled_data <= dashline[y-7][x-44];
                end else if (displayTDEE_num[0] == 0 && displayTDEE_num[1] == 0) begin
                    oled_data <= digitBackGround[y-7][x-44];
                end else if (displayTDEE_num[1] == 0) begin 
                    oled_data <= digit0[y-7][x-44];
                end else if (displayTDEE_num[1] == 1) begin
                    oled_data <= digit1[y-7][x-44];
                end else if (displayTDEE_num[1] == 2) begin
                    oled_data <= digit2[y-7][x-44];
                end else if (displayTDEE_num[1] == 3) begin
                    oled_data <= digit3[y-7][x-44];
                end else if (displayTDEE_num[1] == 4) begin
                    oled_data <= digit4[y-7][x-44];
                end else if (displayTDEE_num[1] == 5) begin
                    oled_data <= digit5[y-7][x-44];
                end else if (displayTDEE_num[1] == 6) begin
                    oled_data <= digit6[y-7][x-44];
                end else if (displayTDEE_num[1] == 7) begin
                    oled_data <= digit7[y-7][x-44];
                end else if (displayTDEE_num[1] == 8) begin
                    oled_data <= digit8[y-7][x-44];
                end else if (displayTDEE_num[1] == 9) begin
                    oled_data <= digit9[y-7][x-44];
                end else begin
                    oled_data <= digitBackGround[y-7][x-44];
                end                  
                      
            end else if (50 <= x && x <= 53 && 7 <= y && y <= 13) begin //display TDEE 2
                
                if (calorie_tdee == 0) begin
                    oled_data <= dashline[y-7][x-50];
                end else if (displayTDEE_num[0] == 0 && displayTDEE_num[1] == 0 && displayTDEE_num[2] == 0) begin
                    oled_data <= digitBackGround[y-7][x-50];        
                end else if (displayTDEE_num[2] == 0) begin 
                    oled_data <= digit0[y-7][x-50];
                end else if (displayTDEE_num[2] == 1) begin
                    oled_data <= digit1[y-7][x-50];
                end else if (displayTDEE_num[2] == 2) begin
                    oled_data <= digit2[y-7][x-50];
                end else if (displayTDEE_num[2] == 3) begin
                    oled_data <= digit3[y-7][x-50];
                end else if (displayTDEE_num[2] == 4) begin
                    oled_data <= digit4[y-7][x-50];
                end else if (displayTDEE_num[2] == 5) begin
                    oled_data <= digit5[y-7][x-50];
                end else if (displayTDEE_num[2] == 6) begin
                    oled_data <= digit6[y-7][x-50];
                end else if (displayTDEE_num[2] == 7) begin
                    oled_data <= digit7[y-7][x-50];
                end else if (displayTDEE_num[2] == 8) begin
                    oled_data <= digit8[y-7][x-50];
                end else if (displayTDEE_num[2] == 9) begin
                    oled_data <= digit9[y-7][x-50];
                end else begin
                    oled_data <= digitBackGround[y-7][x-50];
                end               
                 
            end else if (56 <= x && x <= 59 && 7 <= y && y <= 13) begin //display TDEE 3
    
                if (calorie_tdee == 0) begin
                    oled_data <= dashline[y-7][x-56];
                end else if (displayTDEE_num[0] == 0 && displayTDEE_num[1] == 0 && displayTDEE_num[2] == 0 && displayTDEE_num[3] == 0) begin
                    oled_data <= digitBackGround[y-7][x-56];        
                end else if (displayTDEE_num[3] == 0) begin 
                    oled_data <= digit0[y-7][x-56];
                end else if (displayTDEE_num[3] == 1) begin
                    oled_data <= digit1[y-7][x-56];
                end else if (displayTDEE_num[3] == 2) begin
                    oled_data <= digit2[y-7][x-56];
                end else if (displayTDEE_num[3] == 3) begin
                    oled_data <= digit3[y-7][x-56];
                end else if (displayTDEE_num[3] == 4) begin
                    oled_data <= digit4[y-7][x-56];
                end else if (displayTDEE_num[3] == 5) begin
                    oled_data <= digit5[y-7][x-56];
                end else if (displayTDEE_num[3] == 6) begin
                    oled_data <= digit6[y-7][x-56];
                end else if (displayTDEE_num[3] == 7) begin
                    oled_data <= digit7[y-7][x-56];
                end else if (displayTDEE_num[3] == 8) begin
                    oled_data <= digit8[y-7][x-56];
                end else if (displayTDEE_num[3] == 9) begin
                    oled_data <= digit9[y-7][x-56];
                end else begin
                    oled_data <= digitBackGround[y-7][x-56];
                end             
                
        end else if (38 <= x && x <= 41 && 24 <= y && y <= 30) begin //display A0
            
            if (calorie_countA == 0) begin
                oled_data <= dashline[y-24][x-38];
            end else if (displayA_num[0] == 0) begin 
                oled_data <= digitBackGround[y-24][x-38];
            end else if (displayA_num[0] == 1) begin
                oled_data <= digit1[y-24][x-38];
            end else if (displayA_num[0] == 2) begin
                oled_data <= digit2[y-24][x-38];
            end else if (displayA_num[0] == 3) begin
                oled_data <= digit3[y-24][x-38];
            end else if (displayA_num[0] == 4) begin
                oled_data <= digit4[y-24][x-38];
            end else if (displayA_num[0] == 5) begin
                oled_data <= digit5[y-24][x-38];
            end else if (displayA_num[0] == 6) begin
                oled_data <= digit6[y-24][x-38];
            end else if (displayA_num[0] == 7) begin
                oled_data <= digit7[y-24][x-38];
            end else if (displayA_num[0] == 8) begin
                oled_data <= digit8[y-24][x-38];
            end else if (displayA_num[0] == 9) begin
                oled_data <= digit9[y-24][x-38];
            end else begin
                oled_data <= digitBackGround[y-24][x-38];
            end                
            
        end else if (44 <= x && x <= 47 && 24 <= y && y <= 30) begin //display A1

            if (calorie_countA == 0) begin
                oled_data <= dashline[y-24][x-44];
            end else if (displayA_num[0] == 0 && displayA_num[1] == 0) begin
                oled_data <= digitBackGround[y-24][x-44];
            end else if (displayA_num[1] == 0) begin 
                oled_data <= digit0[y-24][x-44];
            end else if (displayA_num[1] == 1) begin
                oled_data <= digit1[y-24][x-44];
            end else if (displayA_num[1] == 2) begin
                oled_data <= digit2[y-24][x-44];
            end else if (displayA_num[1] == 3) begin
                oled_data <= digit3[y-24][x-44];
            end else if (displayA_num[1] == 4) begin
                oled_data <= digit4[y-24][x-44];
            end else if (displayA_num[1] == 5) begin
                oled_data <= digit5[y-24][x-44];
            end else if (displayA_num[1] == 6) begin
                oled_data <= digit6[y-24][x-44];
            end else if (displayA_num[1] == 7) begin
                oled_data <= digit7[y-24][x-44];
            end else if (displayA_num[1] == 8) begin
                oled_data <= digit8[y-24][x-44];
            end else if (displayA_num[1] == 9) begin
                oled_data <= digit9[y-24][x-44];
            end else begin
                oled_data <= digitBackGround[y-24][x-44];
            end                  
                  
        end else if (50 <= x && x <= 53 && 24 <= y && y <= 30) begin //display A2
            
            if (calorie_countA == 0) begin
                oled_data <= dashline[y-24][x-50];
            end else if (displayA_num[0] == 0 && displayA_num[1] == 0 && displayA_num[2] == 0) begin
                oled_data <= digitBackGround[y-24][x-50];        
            end else if (displayA_num[2] == 0) begin 
                oled_data <= digit0[y-24][x-50];
            end else if (displayA_num[2] == 1) begin
                oled_data <= digit1[y-24][x-50];
            end else if (displayA_num[2] == 2) begin
                oled_data <= digit2[y-24][x-50];
            end else if (displayA_num[2] == 3) begin
                oled_data <= digit3[y-24][x-50];
            end else if (displayA_num[2] == 4) begin
                oled_data <= digit4[y-24][x-50];
            end else if (displayA_num[2] == 5) begin
                oled_data <= digit5[y-24][x-50];
            end else if (displayA_num[2] == 6) begin
                oled_data <= digit6[y-24][x-50];
            end else if (displayA_num[2] == 7) begin
                oled_data <= digit7[y-24][x-50];
            end else if (displayA_num[2] == 8) begin
                oled_data <= digit8[y-24][x-50];
            end else if (displayA_num[2] == 9) begin
                oled_data <= digit9[y-24][x-50];
            end else begin
                oled_data <= digitBackGround[y-24][x-50];
            end               
             
        end else if (56 <= x && x <= 59 && 24 <= y && y <= 30) begin //display A3

            if (calorie_countA == 0) begin
                oled_data <= dashline[y-24][x-56];
            end else if (displayA_num[0] == 0 && displayA_num[1] == 0 && displayA_num[2] == 0 && displayA_num[3] == 0) begin
                oled_data <= digitBackGround[y-24][x-56];        
            end else if (displayA_num[3] == 0) begin 
                oled_data <= digit0[y-24][x-56];
            end else if (displayA_num[3] == 1) begin
                oled_data <= digit1[y-24][x-56];
            end else if (displayA_num[3] == 2) begin
                oled_data <= digit2[y-24][x-56];
            end else if (displayA_num[3] == 3) begin
                oled_data <= digit3[y-24][x-56];
            end else if (displayA_num[3] == 4) begin
                oled_data <= digit4[y-24][x-56];
            end else if (displayA_num[3] == 5) begin
                oled_data <= digit5[y-24][x-56];
            end else if (displayA_num[3] == 6) begin
                oled_data <= digit6[y-24][x-56];
            end else if (displayA_num[3] == 7) begin
                oled_data <= digit7[y-24][x-56];
            end else if (displayA_num[3] == 8) begin
                oled_data <= digit8[y-24][x-56];
            end else if (displayA_num[3] == 9) begin
                oled_data <= digit9[y-24][x-56];
            end else begin
                oled_data <= digitBackGround[y-24][x-56];
            end                    
                
        end else if (38 <= x && x <= 41 && 37 <= y && y <= 43) begin //display B0
            
            if (calorie_countB == 0) begin
                oled_data <= dashline[y-37][x-38];
            end else if (displayB_num[0] == 0) begin 
                oled_data <= digitBackGround[y-37][x-38];
            end else if (displayB_num[0] == 1) begin
                oled_data <= digit1[y-37][x-38];
            end else if (displayB_num[0] == 2) begin
                oled_data <= digit2[y-37][x-38];
            end else if (displayB_num[0] == 3) begin
                oled_data <= digit3[y-37][x-38];
            end else if (displayB_num[0] == 4) begin
                oled_data <= digit4[y-37][x-38];
            end else if (displayB_num[0] == 5) begin
                oled_data <= digit5[y-37][x-38];
            end else if (displayB_num[0] == 6) begin
                oled_data <= digit6[y-37][x-38];
            end else if (displayB_num[0] == 7) begin
                oled_data <= digit7[y-37][x-38];
            end else if (displayB_num[0] == 8) begin
                oled_data <= digit8[y-37][x-38];
            end else if (displayB_num[0] == 9) begin
                oled_data <= digit9[y-37][x-38];
            end else begin
                oled_data <= digitBackGround[y-37][x-38];
            end              
            
        end else if (44 <= x && x <= 47 && 37 <= y && y <= 43) begin //display B1
            
            if (calorie_countB == 0) begin
                oled_data <= dashline[y-37][x-44];
            end else if (displayB_num[0] == 0 && displayB_num[1] == 0) begin 
                oled_data <= digitBackGround[y-37][x-44];            
            end else if (displayB_num[1] == 0) begin 
                oled_data <= digit0[y-37][x-44];
            end else if (displayB_num[1] == 1) begin
                oled_data <= digit1[y-37][x-44];
            end else if (displayB_num[1] == 2) begin
                oled_data <= digit2[y-37][x-44];
            end else if (displayB_num[1] == 3) begin
                oled_data <= digit3[y-37][x-44];
            end else if (displayB_num[1] == 4) begin
                oled_data <= digit4[y-37][x-44];
            end else if (displayB_num[1] == 5) begin
                oled_data <= digit5[y-37][x-44];
            end else if (displayB_num[1] == 6) begin
                oled_data <= digit6[y-37][x-44];
            end else if (displayB_num[1] == 7) begin
                oled_data <= digit7[y-37][x-44];
            end else if (displayB_num[1] == 8) begin
                oled_data <= digit8[y-37][x-44];
            end else if (displayB_num[1] == 9) begin
                oled_data <= digit9[y-37][x-44];
            end else begin
                oled_data <= digitBackGround[y-37][x-44];
            end       
                    
        end else if (50 <= x && x <= 53 && 37 <= y && y <= 43) begin //display B2
            
            if (calorie_countB == 0) begin
                oled_data <= dashline[y-37][x-50];
            end else if (displayB_num[0] == 0 && displayB_num[1] == 0 && displayB_num[2] == 0) begin 
                oled_data <= digitBackGround[y-37][x-50];            
            end else if (displayB_num[2] == 0) begin 
                oled_data <= digit0[y-37][x-50];
            end else if (displayB_num[2] == 1) begin
                oled_data <= digit1[y-37][x-50];
            end else if (displayB_num[2] == 2) begin
                oled_data <= digit2[y-37][x-50];
            end else if (displayB_num[2] == 3) begin
                oled_data <= digit3[y-37][x-50];
            end else if (displayB_num[2] == 4) begin
                oled_data <= digit4[y-37][x-50];
            end else if (displayB_num[2] == 5) begin
                oled_data <= digit5[y-37][x-50];
            end else if (displayB_num[2] == 6) begin
                oled_data <= digit6[y-37][x-50];
            end else if (displayB_num[2] == 7) begin
                oled_data <= digit7[y-37][x-50];
            end else if (displayB_num[2] == 8) begin
                oled_data <= digit8[y-37][x-50];
            end else if (displayB_num[2] == 9) begin
                oled_data <= digit9[y-37][x-50];
            end else begin
                oled_data <= digitBackGround[y-37][x-50];
            end 
                                      
        end else if (56 <= x && x <= 59 && 37 <= y && y <= 43) begin //display B3
        
            if (calorie_countB == 0) begin
                oled_data <= dashline[y-37][x-56];
            end else if (displayB_num[0] == 0 && displayB_num[1] == 0 && displayB_num[2] == 0 && displayB_num[3] == 0) begin 
                oled_data <= digitBackGround[y-37][x-56];
            end else if (displayB_num[3] == 0) begin 
                oled_data <= digit0[y-37][x-56];
            end else if (displayB_num[3] == 1) begin
                oled_data <= digit1[y-37][x-56];
            end else if (displayB_num[3] == 2) begin
                oled_data <= digit2[y-37][x-56];
            end else if (displayB_num[3] == 3) begin
                oled_data <= digit3[y-37][x-56];
            end else if (displayB_num[3] == 4) begin
                oled_data <= digit4[y-37][x-56];
            end else if (displayB_num[3] == 5) begin
                oled_data <= digit5[y-37][x-56];
            end else if (displayB_num[3] == 6) begin
                oled_data <= digit6[y-37][x-56];
            end else if (displayB_num[3] == 7) begin
                oled_data <= digit7[y-37][x-56];
            end else if (displayB_num[3] == 8) begin
                oled_data <= digit8[y-37][x-56];
            end else if (displayB_num[3] == 9) begin
                oled_data <= digit9[y-37][x-56];
            end else begin
                oled_data <= digitBackGround[y-37][x-56];
            end             
            
        end else if (38 <= x && x <= 41 && 50 <= y && y <= 56) begin //display C0
            
            if (calorie_countC == 0) begin
                oled_data <= dashline[y-50][x-38];            
            end else if (displayC_num[0] == 0) begin 
                oled_data <= digitBackGround[y-50][x-38];
            end else if (displayC_num[0] == 1) begin
                oled_data <= digit1[y-50][x-38];
            end else if (displayC_num[0] == 2) begin
                oled_data <= digit2[y-50][x-38];
            end else if (displayC_num[0] == 3) begin
                oled_data <= digit3[y-50][x-38];
            end else if (displayC_num[0] == 4) begin
                oled_data <= digit4[y-50][x-38];
            end else if (displayC_num[0] == 5) begin
                oled_data <= digit5[y-50][x-38];
            end else if (displayC_num[0] == 6) begin
                oled_data <= digit6[y-50][x-38];
            end else if (displayC_num[0] == 7) begin
                oled_data <= digit7[y-50][x-38];
            end else if (displayC_num[0] == 8) begin
                oled_data <= digit8[y-50][x-38];
            end else if (displayC_num[0] == 9) begin
                oled_data <= digit9[y-50][x-38];
            end else begin
                oled_data <= digitBackGround[y-50][x-38];
            end     
                    
        end else if (44 <= x && x <= 47 && 50 <= y && y <= 56) begin //display C1
         
            if (calorie_countC == 0) begin
                oled_data <= dashline[y-50][x-44];            
            end else if (displayC_num[0] == 0 && displayC_num[1] == 0) begin 
                oled_data <= digitBackGround[y-50][x-44];            
            end else if (displayC_num[1] == 0) begin 
                oled_data <= digit0[y-50][x-44];
            end else if (displayC_num[1] == 1) begin
                oled_data <= digit1[y-50][x-44];
            end else if (displayC_num[1] == 2) begin
                oled_data <= digit2[y-50][x-44];
            end else if (displayC_num[1] == 3) begin
                oled_data <= digit3[y-50][x-44];
            end else if (displayC_num[1] == 4) begin
                oled_data <= digit4[y-50][x-44];
            end else if (displayC_num[1] == 5) begin
                oled_data <= digit5[y-50][x-44];
            end else if (displayC_num[1] == 6) begin
                oled_data <= digit6[y-50][x-44];
            end else if (displayC_num[1] == 7) begin
                oled_data <= digit7[y-50][x-44];
            end else if (displayC_num[1] == 8) begin
                oled_data <= digit8[y-50][x-44];
            end else if (displayC_num[1] == 9) begin
                oled_data <= digit9[y-50][x-44];
            end else begin
                oled_data <= digitBackGround[y-50][x-44];
            end 
                                
        end else if (50 <= x && x <= 53 && 50 <= y && y <= 56) begin //display C2
            
            if (calorie_countC == 0) begin
                oled_data <= dashline[y-50][x-50];            
            end else if (displayC_num[0] == 0 && displayC_num[1] == 0 && displayC_num[2] == 0) begin 
                oled_data <= digitBackGround[y-50][x-50];            
            end else if (displayC_num[2] == 0) begin 
                oled_data <= digit0[y-50][x-50];
            end else if (displayC_num[2] == 1) begin
                oled_data <= digit1[y-50][x-50];
            end else if (displayC_num[2] == 2) begin
                oled_data <= digit2[y-50][x-50];
            end else if (displayC_num[2] == 3) begin
                oled_data <= digit3[y-50][x-50];
            end else if (displayC_num[2] == 4) begin
                oled_data <= digit4[y-50][x-50];
            end else if (displayC_num[2] == 5) begin
                oled_data <= digit5[y-50][x-50];
            end else if (displayC_num[2] == 6) begin
                oled_data <= digit6[y-50][x-50];
            end else if (displayC_num[2] == 7) begin
                oled_data <= digit7[y-50][x-50];
            end else if (displayC_num[2] == 8) begin
                oled_data <= digit8[y-50][x-50];
            end else if (displayC_num[2] == 9) begin
                oled_data <= digit9[y-50][x-50];
            end else begin
                oled_data <= digitBackGround[y-50][x-50];
            end        
                         
        end else if (56 <= x && x <= 59 && 50 <= y && y <= 56) begin

            if (calorie_countC == 0) begin
                oled_data <= dashline[y-50][x-56];            
            end else if (displayC_num[0] == 0 && displayC_num[1] == 0 && displayC_num[2] == 0 && displayC_num[3] == 0) begin 
                oled_data <= digitBackGround[y-50][x-56]; 
            end else if (displayC_num[3] == 0) begin //display C3
                oled_data <= digit0[y-50][x-56];
            end else if (displayC_num[3] == 1) begin
                oled_data <= digit1[y-50][x-56];
            end else if (displayC_num[3] == 2) begin
                oled_data <= digit2[y-50][x-56];
            end else if (displayC_num[3] == 3) begin
                oled_data <= digit3[y-50][x-56];
            end else if (displayC_num[3] == 4) begin
                oled_data <= digit4[y-50][x-56];
            end else if (displayC_num[3] == 5) begin
                oled_data <= digit5[y-50][x-56];
            end else if (displayC_num[3] == 6) begin
                oled_data <= digit6[y-50][x-56];
            end else if (displayC_num[3] == 7) begin
                oled_data <= digit7[y-50][x-56];
            end else if (displayC_num[3] == 8) begin
                oled_data <= digit8[y-50][x-56];
            end else if (displayC_num[3] == 9) begin
                oled_data <= digit9[y-50][x-56];
            end else begin
                oled_data <= digitBackGround[y-50][x-56];
            end 
                            
        end else begin
            oled_data <= BACKGROUND;
        end 
        
        
        counter <= counter + 1;
        
        if (btnL && boxNum == 0 && ~movedLeft && isMain) begin
            ari_rj_control <= 1;
            isMain <= 0;       
            
            movedLeft <= 1;
            counter <= 0; 
        end        
        
        /*
        if (btnR && boxNum != 3 && boxNum != 7 && boxNum != 11 && ~movedRight) begin
            xLeft <= xLeft + 13;
            xRight <= xRight + 13;
            boxNum <= boxNum + 1;
            movedRight <= 1;
            counter <= 0;
        end*/
        
        if (btnU && boxNum > 1 && ~movedUp && !(isNumpadA || isNumpadB || isNumpadC) && isMain && isToggled) begin
            yUp <= yUp - 13;
            yDown <= yDown - 13;
            boxNum <= boxNum - 1;
            movedUp <= 1;
            counter <= 0;
        end else if (btnU && boxNum == 1 && ~movedUp && !(isNumpadA || isNumpadB || isNumpadC) && isMain && isToggled) begin
            isBack <= 1;
            boxNum <= boxNum - 1;
            movedUp <= 1;
            counter <= 0;
        end
        
        
        if (btnD && boxNum == 0 && ~movedDown && !(isNumpadA || isNumpadB || isNumpadC) && isMain) begin
            isBack <= 0;
            boxNum <= boxNum + 1;
            movedDown <= 1;
            counter <= 0;        
        end else if (btnD && boxNum < 3 && ~movedDown && !(isNumpadA || isNumpadB || isNumpadC) && isMain) begin
            yUp <= yUp + 13;
            yDown <= yDown + 13;
            boxNum <= boxNum + 1;
            movedDown <= 1;
            counter <= 0;
        end else if (btnD && boxNum == 3 && ~movedDown && !(isNumpadA || isNumpadB || isNumpadC) && isMain) begin
            isSnackMenu <= 1;
            isMain <= 0;
        end
        
        if (isSnack) begin
            isSnackMenu <= 0;
        end
        
        if (counter >= DEBOUNCE_COUNT*2) begin
            isToggled <= 1;
        end        
        
        if (isMain_A || isMain_B || isMain_C || isMainMenu) begin
            isToggled <= 0;
            counter <= 0;
                        
            isNumpadA <= 0;
            isNumpadB <= 0;
            isNumpadC <= 0;
            isMain <= 1;
        end        

        
        if (btnC && ~movedCenter && !(isNumpadA || isNumpadB || isNumpadC) && isMain) begin

                
            if (boxNum == 1) begin
                isNumpadA = 1;
                isMain = 0;
                
            end else if (boxNum == 2) begin
                isNumpadB = 1;
                isMain = 0; 
    
            end else begin //boxNum == 3
                isNumpadC = 1;
                isMain = 0;
       
            end
              
            movedCenter <= 1;
            counter <= 0;
        end 
        
        
        if (~btnL && counter >= DEBOUNCE_COUNT) begin
            movedLeft <= 0;
        end
        /*
        if (~btnR && counter >= DEBOUNCE_COUNT) begin
            movedRight <= 0;
        end*/
        
        if (~btnU && counter >= DEBOUNCE_COUNT) begin
            movedUp <= 0;
        end        
        
        if (~btnD && counter >= DEBOUNCE_COUNT) begin
            movedDown <= 0;
        end
        
        if (~btnC && counter >= DEBOUNCE_COUNT) begin
            movedCenter <= 0;
        end
        
   
              
    end //basys_clk end block
    
    
    
endmodule


