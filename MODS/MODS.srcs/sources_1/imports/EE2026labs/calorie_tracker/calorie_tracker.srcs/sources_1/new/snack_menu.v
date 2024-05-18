`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2024 21:29:34
// Design Name: 
// Module Name: snack_menu
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

module snack_menu(
    input basys_clk, 
    input [7:0] control,
    input isMain,
    input isMain_D,
    input isMain_E,
    input isMain_F,
    input isSnackMenu,
    input [12:0] pixel_index,
    input btnL,
    input btnR,
    input btnC,
    input btnU,
    input btnD,
    input [15:0] calorie_countD,
    input [15:0] calorie_countE,
    input [15:0] calorie_countF,
    output reg [15:0] oled_data,
    output reg isNumpadD = 0,
    output reg isNumpadE = 0,
    output reg isNumpadF = 0,
    output reg isSnack = 0,
    output reg isMainMenu = 0,
    output reg ari_control = 0
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
    

    reg [15:0] snack [4:0][23:0];
    reg [15:0] cal [4:0][12:0];
    

    
    
    reg [4:0] displayD_num[3:0];
    reg [4:0] displayE_num[3:0];
    reg [4:0] displayF_num[3:0];
    
    
    initial begin
    //////////////////////////////// snack
        
        snack[0][0] <= BACKGROUND;
        snack[0][1] <= ALPHABETCOLOR;
        snack[0][2] <= ALPHABETCOLOR;
        snack[0][3] <= ALPHABETCOLOR;
        snack[0][4] <= BACKGROUND;
        snack[0][5] <= ALPHABETCOLOR;
        snack[0][6] <= BACKGROUND;
        snack[0][7] <= BACKGROUND;
        snack[0][8] <= ALPHABETCOLOR;
        snack[0][9] <= BACKGROUND;
        snack[0][10] <= BACKGROUND;
        snack[0][11] <= ALPHABETCOLOR;
        snack[0][12] <= ALPHABETCOLOR;
        snack[0][13] <= BACKGROUND;
        snack[0][14] <= BACKGROUND;
        snack[0][15] <= BACKGROUND;
        snack[0][16] <= ALPHABETCOLOR;
        snack[0][17] <= ALPHABETCOLOR;
        snack[0][18] <= ALPHABETCOLOR;
        snack[0][19] <= BACKGROUND;
        snack[0][20] <= ALPHABETCOLOR;
        snack[0][21] <= BACKGROUND;
        snack[0][22] <= BACKGROUND;
        snack[0][23] <= ALPHABETCOLOR;
 
        snack[1][0] <= ALPHABETCOLOR;
        snack[1][1] <= BACKGROUND;
        snack[1][2] <= BACKGROUND;
        snack[1][3] <= BACKGROUND;
        snack[1][4] <= BACKGROUND;
        snack[1][5] <= ALPHABETCOLOR;
        snack[1][6] <= ALPHABETCOLOR;
        snack[1][7] <= BACKGROUND;
        snack[1][8] <= ALPHABETCOLOR;
        snack[1][9] <= BACKGROUND;
        snack[1][10] <= ALPHABETCOLOR;
        snack[1][11] <= BACKGROUND;
        snack[1][12] <= BACKGROUND;
        snack[1][13] <= ALPHABETCOLOR;
        snack[1][14] <= BACKGROUND;
        snack[1][15] <= ALPHABETCOLOR;
        snack[1][16] <= BACKGROUND;
        snack[1][17] <= BACKGROUND;
        snack[1][18] <= BACKGROUND;
        snack[1][19] <= BACKGROUND;
        snack[1][20] <= ALPHABETCOLOR;
        snack[1][21] <= BACKGROUND;
        snack[1][22] <= ALPHABETCOLOR;
        snack[1][23] <= BACKGROUND;
        
        snack[2][0] <= BACKGROUND;
        snack[2][1] <= ALPHABETCOLOR;
        snack[2][2] <= ALPHABETCOLOR;
        snack[2][3] <= BACKGROUND;
        snack[2][4] <= BACKGROUND;
        snack[2][5] <= ALPHABETCOLOR;
        snack[2][6] <= BACKGROUND;
        snack[2][7] <= ALPHABETCOLOR;
        snack[2][8] <= ALPHABETCOLOR;
        snack[2][9] <= BACKGROUND;
        snack[2][10] <= ALPHABETCOLOR;
        snack[2][11] <= ALPHABETCOLOR;
        snack[2][12] <= ALPHABETCOLOR;
        snack[2][13] <= ALPHABETCOLOR;
        snack[2][14] <= BACKGROUND;
        snack[2][15] <= ALPHABETCOLOR;
        snack[2][16] <= BACKGROUND;
        snack[2][17] <= BACKGROUND;
        snack[2][18] <= BACKGROUND;
        snack[2][19] <= BACKGROUND;
        snack[2][20] <= ALPHABETCOLOR;
        snack[2][21] <= ALPHABETCOLOR;
        snack[2][22] <= BACKGROUND;
        snack[2][23] <= BACKGROUND;
        
        snack[3][0] <= BACKGROUND;
        snack[3][1] <= BACKGROUND;
        snack[3][2] <= BACKGROUND;
        snack[3][3] <= ALPHABETCOLOR;
        snack[3][4] <= BACKGROUND;
        snack[3][5] <= ALPHABETCOLOR;
        snack[3][6] <= BACKGROUND;
        snack[3][7] <= BACKGROUND;
        snack[3][8] <= ALPHABETCOLOR;
        snack[3][9] <= BACKGROUND;
        snack[3][10] <= ALPHABETCOLOR;
        snack[3][11] <= BACKGROUND;
        snack[3][12] <= BACKGROUND;
        snack[3][13] <= ALPHABETCOLOR;
        snack[3][14] <= BACKGROUND;
        snack[3][15] <= ALPHABETCOLOR;
        snack[3][16] <= BACKGROUND;
        snack[3][17] <= BACKGROUND;
        snack[3][18] <= BACKGROUND;
        snack[3][19] <= BACKGROUND;
        snack[3][20] <= ALPHABETCOLOR;
        snack[3][21] <= BACKGROUND;
        snack[3][22] <= ALPHABETCOLOR;
        snack[3][23] <= BACKGROUND;
        
        snack[4][0] <= ALPHABETCOLOR;
        snack[4][1] <= ALPHABETCOLOR;
        snack[4][2] <= ALPHABETCOLOR;
        snack[4][3] <= BACKGROUND;
        snack[4][4] <= BACKGROUND;
        snack[4][5] <= ALPHABETCOLOR;
        snack[4][6] <= BACKGROUND;
        snack[4][7] <= BACKGROUND;
        snack[4][8] <= ALPHABETCOLOR;
        snack[4][9] <= BACKGROUND;
        snack[4][10] <= ALPHABETCOLOR;
        snack[4][11] <= BACKGROUND;
        snack[4][12] <= BACKGROUND;
        snack[4][13] <= ALPHABETCOLOR;
        snack[4][14] <= BACKGROUND;
        snack[4][15] <= BACKGROUND;
        snack[4][16] <= ALPHABETCOLOR;
        snack[4][17] <= ALPHABETCOLOR;
        snack[4][18] <= ALPHABETCOLOR;
        snack[4][19] <= BACKGROUND;
        snack[4][20] <= ALPHABETCOLOR;
        snack[4][21] <= BACKGROUND;
        snack[4][22] <= BACKGROUND;    
        snack[4][23] <= ALPHABETCOLOR;                           
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
    reg [6:0] yUp = 14;
    reg [6:0] yDown = 24;
    reg [5:0] boxNum = 0;
    reg movedLeft = 0;
    reg movedRight = 0;
    reg movedUp = 0;
    reg movedDown = 0;
    reg movedCenter = 0;
    parameter DEBOUNCE_COUNT = 625000;
    //parameter DEBOUNCE_COUNT = 1000000;
    reg[31:0] counter = 0;
    
    reg isToggled = 1;
    reg isNext = 0; //for switching arrow color 
    
    always @ (posedge basys_clk) begin
    
        if (ari_control == 1) begin
            ari_control <= 0;
        end
    
        displayD_num[0] <= (calorie_countD / 1000) % 10;
        displayD_num[1] <= (calorie_countD / 100) % 10;
        displayD_num[2] <= (calorie_countD / 10) % 10;
        displayD_num[3] <= calorie_countD % 10;
        
        displayE_num[0] <= (calorie_countE / 1000) % 10;
        displayE_num[1] <= (calorie_countE / 100) % 10;
        displayE_num[2] <= (calorie_countE / 10) % 10;
        displayE_num[3] <= calorie_countE % 10;
        
        displayF_num[0] <= (calorie_countF / 1000) % 10;
        displayF_num[1] <= (calorie_countF / 100) % 10;
        displayF_num[2] <= (calorie_countF / 10) % 10;
        displayF_num[3] <= calorie_countF % 10;        


        if (7 <= x && x <= 30 && 16 <= y && y <= 20) begin
            oled_data <= snack[y-16][x-7]; //snack word D
        end else if (7 <= x && x <= 30 && 29 <= y && y <= 33) begin
            oled_data <= snack[y-29][x-7]; //snack word E
        end else if (7 <= x && x <= 30 && 42 <= y && y <= 46) begin
            oled_data <= snack[y-42][x-7]; //snack word F
        end else if (xLeft <= x && x <= xRight && yUp <= y && y <= yDown && !((xLeft+1) <= x && x <= (xRight-1) && (yUp+1) <= y && y <= (yDown-1))) begin   
            if (isNext) begin                //green border box
                oled_data <= BACKGROUND;
            end else begin 
                oled_data <= BOXCOLOR;    
            end
        end else if (65 <= x && x <= 77 && 17 <= y && y <= 21) begin    
            oled_data <= cal[y-17][x-65]; //cal A word
        end else if (65 <= x && x <= 77 && 30 <= y && y <= 34) begin    
            oled_data <= cal[y-30][x-65]; //cal B word
        end else if (65 <= x && x <= 77 && 43 <= y && y <= 47) begin    
            oled_data <= cal[y-43][x-65]; // cal C word             
        end else if (7 <= x && x <= 30 && (x%2 == 1) && (y == 22 || y == 35 || y == 48)) begin   
            oled_data <= ALPHABETCOLOR;  //underline for snack                          
        end else if ((y==54 && 84 <= x && x <= 86) ||
                     (y==55 && 86 <= x && x <= 87 ) || 
                     (y==56 && 79 <= x && x <= 88) || 
                     (y==57 && 86 <= x && x <= 87) || 
                     (y==58 && 84 <= x && x <= 86)) begin   //for next arrow
            if (isNext) begin
                oled_data <= BOXCOLOR;    
            end else begin
                oled_data <= 16'hFFFF;                
            end
            
        end else if (38 <= x && x <= 41 && 16 <= y && y <= 22) begin //display D0
            
            if (calorie_countD == 0) begin
                oled_data <= dashline[y-16][x-38];
            end else if (displayD_num[0] == 0) begin 
                oled_data <= digitBackGround[y-16][x-38];
            end else if (displayD_num[0] == 1) begin
                oled_data <= digit1[y-16][x-38];
            end else if (displayD_num[0] == 2) begin
                oled_data <= digit2[y-16][x-38];
            end else if (displayD_num[0] == 3) begin
                oled_data <= digit3[y-16][x-38];
            end else if (displayD_num[0] == 4) begin
                oled_data <= digit4[y-16][x-38];
            end else if (displayD_num[0] == 5) begin
                oled_data <= digit5[y-16][x-38];
            end else if (displayD_num[0] == 6) begin
                oled_data <= digit6[y-16][x-38];
            end else if (displayD_num[0] == 7) begin
                oled_data <= digit7[y-16][x-38];
            end else if (displayD_num[0] == 8) begin
                oled_data <= digit8[y-16][x-38];
            end else if (displayD_num[0] == 9) begin
                oled_data <= digit9[y-16][x-38];
            end else begin
                oled_data <= digitBackGround[y-16][x-38];
            end                
            
        end else if (44 <= x && x <= 47 && 16 <= y && y <= 22) begin //display D1

            if (calorie_countD == 0) begin
                oled_data <= dashline[y-16][x-44];
            end else if (displayD_num[0] == 0 && displayD_num[1] == 0) begin
                oled_data <= digitBackGround[y-16][x-44];
            end else if (displayD_num[1] == 0) begin 
                oled_data <= digit0[y-16][x-44];
            end else if (displayD_num[1] == 1) begin
                oled_data <= digit1[y-16][x-44];
            end else if (displayD_num[1] == 2) begin
                oled_data <= digit2[y-16][x-44];
            end else if (displayD_num[1] == 3) begin
                oled_data <= digit3[y-16][x-44];
            end else if (displayD_num[1] == 4) begin
                oled_data <= digit4[y-16][x-44];
            end else if (displayD_num[1] == 5) begin
                oled_data <= digit5[y-16][x-44];
            end else if (displayD_num[1] == 6) begin
                oled_data <= digit6[y-16][x-44];
            end else if (displayD_num[1] == 7) begin
                oled_data <= digit7[y-16][x-44];
            end else if (displayD_num[1] == 8) begin
                oled_data <= digit8[y-16][x-44];
            end else if (displayD_num[1] == 9) begin
                oled_data <= digit9[y-16][x-44];
            end else begin
                oled_data <= digitBackGround[y-16][x-44];
            end                  
                  
        end else if (50 <= x && x <= 53 && 16 <= y && y <= 22) begin //display D2
            
            if (calorie_countD == 0) begin
                oled_data <= dashline[y-16][x-50];
            end else if (displayD_num[0] == 0 && displayD_num[1] == 0 && displayD_num[2] == 0) begin
                oled_data <= digitBackGround[y-16][x-50];        
            end else if (displayD_num[2] == 0) begin 
                oled_data <= digit0[y-16][x-50];
            end else if (displayD_num[2] == 1) begin
                oled_data <= digit1[y-16][x-50];
            end else if (displayD_num[2] == 2) begin
                oled_data <= digit2[y-16][x-50];
            end else if (displayD_num[2] == 3) begin
                oled_data <= digit3[y-16][x-50];
            end else if (displayD_num[2] == 4) begin
                oled_data <= digit4[y-16][x-50];
            end else if (displayD_num[2] == 5) begin
                oled_data <= digit5[y-16][x-50];
            end else if (displayD_num[2] == 6) begin
                oled_data <= digit6[y-16][x-50];
            end else if (displayD_num[2] == 7) begin
                oled_data <= digit7[y-16][x-50];
            end else if (displayD_num[2] == 8) begin
                oled_data <= digit8[y-16][x-50];
            end else if (displayD_num[2] == 9) begin
                oled_data <= digit9[y-16][x-50];
            end else begin
                oled_data <= digitBackGround[y-16][x-50];
            end               
             
        end else if (56 <= x && x <= 59 && 16 <= y && y <= 22) begin //display D3

            if (calorie_countD == 0) begin
                oled_data <= dashline[y-16][x-56];
            end else if (displayD_num[0] == 0 && displayD_num[1] == 0 && displayD_num[2] == 0 && displayD_num[3] == 0) begin
                oled_data <= digitBackGround[y-16][x-56];        
            end else if (displayD_num[3] == 0) begin 
                oled_data <= digit0[y-16][x-56];
            end else if (displayD_num[3] == 1) begin
                oled_data <= digit1[y-16][x-56];
            end else if (displayD_num[3] == 2) begin
                oled_data <= digit2[y-16][x-56];
            end else if (displayD_num[3] == 3) begin
                oled_data <= digit3[y-16][x-56];
            end else if (displayD_num[3] == 4) begin
                oled_data <= digit4[y-16][x-56];
            end else if (displayD_num[3] == 5) begin
                oled_data <= digit5[y-16][x-56];
            end else if (displayD_num[3] == 6) begin
                oled_data <= digit6[y-16][x-56];
            end else if (displayD_num[3] == 7) begin
                oled_data <= digit7[y-16][x-56];
            end else if (displayD_num[3] == 8) begin
                oled_data <= digit8[y-16][x-56];
            end else if (displayD_num[3] == 9) begin
                oled_data <= digit9[y-16][x-56];
            end else begin
                oled_data <= digitBackGround[y-16][x-56];
            end                    
                
        end else if (38 <= x && x <= 41 && 29 <= y && y <= 35) begin //display E0
            
            if (calorie_countE == 0) begin
                oled_data <= dashline[y-29][x-38];
            end else if (displayE_num[0] == 0) begin 
                oled_data <= digitBackGround[y-29][x-38];
            end else if (displayE_num[0] == 1) begin
                oled_data <= digit1[y-29][x-38];
            end else if (displayE_num[0] == 2) begin
                oled_data <= digit2[y-29][x-38];
            end else if (displayE_num[0] == 3) begin
                oled_data <= digit3[y-29][x-38];
            end else if (displayE_num[0] == 4) begin
                oled_data <= digit4[y-29][x-38];
            end else if (displayE_num[0] == 5) begin
                oled_data <= digit5[y-29][x-38];
            end else if (displayE_num[0] == 6) begin
                oled_data <= digit6[y-29][x-38];
            end else if (displayE_num[0] == 7) begin
                oled_data <= digit7[y-29][x-38];
            end else if (displayE_num[0] == 8) begin
                oled_data <= digit8[y-29][x-38];
            end else if (displayE_num[0] == 9) begin
                oled_data <= digit9[y-29][x-38];
            end else begin
                oled_data <= digitBackGround[y-29][x-38];
            end              
            
        end else if (44 <= x && x <= 47 && 29 <= y && y <= 35) begin //display E1
            
            if (calorie_countE == 0) begin
                oled_data <= dashline[y-29][x-44];
            end else if (displayE_num[0] == 0 && displayE_num[1] == 0) begin 
                oled_data <= digitBackGround[y-29][x-44];            
            end else if (displayE_num[1] == 0) begin 
                oled_data <= digit0[y-29][x-44];
            end else if (displayE_num[1] == 1) begin
                oled_data <= digit1[y-29][x-44];
            end else if (displayE_num[1] == 2) begin
                oled_data <= digit2[y-29][x-44];
            end else if (displayE_num[1] == 3) begin
                oled_data <= digit3[y-29][x-44];
            end else if (displayE_num[1] == 4) begin
                oled_data <= digit4[y-29][x-44];
            end else if (displayE_num[1] == 5) begin
                oled_data <= digit5[y-29][x-44];
            end else if (displayE_num[1] == 6) begin
                oled_data <= digit6[y-29][x-44];
            end else if (displayE_num[1] == 7) begin
                oled_data <= digit7[y-29][x-44];
            end else if (displayE_num[1] == 8) begin
                oled_data <= digit8[y-29][x-44];
            end else if (displayE_num[1] == 9) begin
                oled_data <= digit9[y-29][x-44];
            end else begin
                oled_data <= digitBackGround[y-29][x-44];
            end       
                    
        end else if (50 <= x && x <= 53 && 29 <= y && y <= 35) begin //display E2
            
            if (calorie_countE == 0) begin
                oled_data <= dashline[y-29][x-50];
            end else if (displayE_num[0] == 0 && displayE_num[1] == 0 && displayE_num[2] == 0) begin 
                oled_data <= digitBackGround[y-29][x-50];            
            end else if (displayE_num[2] == 0) begin 
                oled_data <= digit0[y-29][x-50];
            end else if (displayE_num[2] == 1) begin
                oled_data <= digit1[y-29][x-50];
            end else if (displayE_num[2] == 2) begin
                oled_data <= digit2[y-29][x-50];
            end else if (displayE_num[2] == 3) begin
                oled_data <= digit3[y-29][x-50];
            end else if (displayE_num[2] == 4) begin
                oled_data <= digit4[y-29][x-50];
            end else if (displayE_num[2] == 5) begin
                oled_data <= digit5[y-29][x-50];
            end else if (displayE_num[2] == 6) begin
                oled_data <= digit6[y-29][x-50];
            end else if (displayE_num[2] == 7) begin
                oled_data <= digit7[y-29][x-50];
            end else if (displayE_num[2] == 8) begin
                oled_data <= digit8[y-29][x-50];
            end else if (displayE_num[2] == 9) begin
                oled_data <= digit9[y-29][x-50];
            end else begin
                oled_data <= digitBackGround[y-29][x-50];
            end 
                                      
        end else if (56 <= x && x <= 59 && 29 <= y && y <= 35) begin //display E3
        
            if (calorie_countE == 0) begin
                oled_data <= dashline[y-29][x-56];
            end else if (displayE_num[0] == 0 && displayE_num[1] == 0 && displayE_num[2] == 0 && displayE_num[3] == 0) begin 
                oled_data <= digitBackGround[y-29][x-56];
            end else if (displayE_num[3] == 0) begin 
                oled_data <= digit0[y-29][x-56];
            end else if (displayE_num[3] == 1) begin
                oled_data <= digit1[y-29][x-56];
            end else if (displayE_num[3] == 2) begin
                oled_data <= digit2[y-29][x-56];
            end else if (displayE_num[3] == 3) begin
                oled_data <= digit3[y-29][x-56];
            end else if (displayE_num[3] == 4) begin
                oled_data <= digit4[y-29][x-56];
            end else if (displayE_num[3] == 5) begin
                oled_data <= digit5[y-29][x-56];
            end else if (displayE_num[3] == 6) begin
                oled_data <= digit6[y-29][x-56];
            end else if (displayE_num[3] == 7) begin
                oled_data <= digit7[y-29][x-56];
            end else if (displayE_num[3] == 8) begin
                oled_data <= digit8[y-29][x-56];
            end else if (displayE_num[3] == 9) begin
                oled_data <= digit9[y-29][x-56];
            end else begin
                oled_data <= digitBackGround[y-29][x-56];
            end             
            
        end else if (38 <= x && x <= 41 && 42 <= y && y <= 48) begin //display F0
            
            if (calorie_countF == 0) begin
                oled_data <= dashline[y-42][x-38];            
            end else if (displayF_num[0] == 0) begin 
                oled_data <= digitBackGround[y-42][x-38];
            end else if (displayF_num[0] == 1) begin
                oled_data <= digit1[y-42][x-38];
            end else if (displayF_num[0] == 2) begin
                oled_data <= digit2[y-42][x-38];
            end else if (displayF_num[0] == 3) begin
                oled_data <= digit3[y-42][x-38];
            end else if (displayF_num[0] == 4) begin
                oled_data <= digit4[y-42][x-38];
            end else if (displayF_num[0] == 5) begin
                oled_data <= digit5[y-42][x-38];
            end else if (displayF_num[0] == 6) begin
                oled_data <= digit6[y-42][x-38];
            end else if (displayF_num[0] == 7) begin
                oled_data <= digit7[y-42][x-38];
            end else if (displayF_num[0] == 8) begin
                oled_data <= digit8[y-42][x-38];
            end else if (displayF_num[0] == 9) begin
                oled_data <= digit9[y-42][x-38];
            end else begin
                oled_data <= digitBackGround[y-42][x-38];
            end     
                    
        end else if (44 <= x && x <= 47 && 42 <= y && y <= 48) begin //display F1
         
            if (calorie_countF == 0) begin
                oled_data <= dashline[y-42][x-44];            
            end else if (displayF_num[0] == 0 && displayF_num[1] == 0) begin 
                oled_data <= digitBackGround[y-42][x-44];            
            end else if (displayF_num[1] == 0) begin 
                oled_data <= digit0[y-42][x-44];
            end else if (displayF_num[1] == 1) begin
                oled_data <= digit1[y-42][x-44];
            end else if (displayF_num[1] == 2) begin
                oled_data <= digit2[y-42][x-44];
            end else if (displayF_num[1] == 3) begin
                oled_data <= digit3[y-42][x-44];
            end else if (displayF_num[1] == 4) begin
                oled_data <= digit4[y-42][x-44];
            end else if (displayF_num[1] == 5) begin
                oled_data <= digit5[y-42][x-44];
            end else if (displayF_num[1] == 6) begin
                oled_data <= digit6[y-42][x-44];
            end else if (displayF_num[1] == 7) begin
                oled_data <= digit7[y-42][x-44];
            end else if (displayF_num[1] == 8) begin
                oled_data <= digit8[y-42][x-44];
            end else if (displayF_num[1] == 9) begin
                oled_data <= digit9[y-42][x-44];
            end else begin
                oled_data <= digitBackGround[y-42][x-44];
            end 
                                
        end else if (50 <= x && x <= 53 && 42 <= y && y <= 48) begin //display F2
            
            if (calorie_countF == 0) begin
                oled_data <= dashline[y-42][x-50];            
            end else if (displayF_num[0] == 0 && displayF_num[1] == 0 && displayF_num[2] == 0) begin 
                oled_data <= digitBackGround[y-42][x-50];            
            end else if (displayF_num[2] == 0) begin 
                oled_data <= digit0[y-42][x-50];
            end else if (displayF_num[2] == 1) begin
                oled_data <= digit1[y-42][x-50];
            end else if (displayF_num[2] == 2) begin
                oled_data <= digit2[y-42][x-50];
            end else if (displayF_num[2] == 3) begin
                oled_data <= digit3[y-42][x-50];
            end else if (displayF_num[2] == 4) begin
                oled_data <= digit4[y-42][x-50];
            end else if (displayF_num[2] == 5) begin
                oled_data <= digit5[y-42][x-50];
            end else if (displayF_num[2] == 6) begin
                oled_data <= digit6[y-42][x-50];
            end else if (displayF_num[2] == 7) begin
                oled_data <= digit7[y-42][x-50];
            end else if (displayF_num[2] == 8) begin
                oled_data <= digit8[y-42][x-50];
            end else if (displayF_num[2] == 9) begin
                oled_data <= digit9[y-42][x-50];
            end else begin
                oled_data <= digitBackGround[y-42][x-50];
            end        
                         
        end else if (56 <= x && x <= 59 && 42 <= y && y <= 48) begin //display F3

            if (calorie_countF == 0) begin
                oled_data <= dashline[y-42][x-56];            
            end else if (displayF_num[0] == 0 && displayF_num[1] == 0 && displayF_num[2] == 0 && displayF_num[3] == 0) begin 
                oled_data <= digitBackGround[y-42][x-56]; 
            end else if (displayF_num[3] == 0) begin 
                oled_data <= digit0[y-42][x-56];
            end else if (displayF_num[3] == 1) begin
                oled_data <= digit1[y-42][x-56];
            end else if (displayF_num[3] == 2) begin
                oled_data <= digit2[y-42][x-56];
            end else if (displayF_num[3] == 3) begin
                oled_data <= digit3[y-42][x-56];
            end else if (displayF_num[3] == 4) begin
                oled_data <= digit4[y-42][x-56];
            end else if (displayF_num[3] == 5) begin
                oled_data <= digit5[y-42][x-56];
            end else if (displayF_num[3] == 6) begin
                oled_data <= digit6[y-42][x-56];
            end else if (displayF_num[3] == 7) begin
                oled_data <= digit7[y-42][x-56];
            end else if (displayF_num[3] == 8) begin
                oled_data <= digit8[y-42][x-56];
            end else if (displayF_num[3] == 9) begin
                oled_data <= digit9[y-42][x-56];
            end else begin
                oled_data <= digitBackGround[y-42][x-56];
            end 
                            
        end else begin
            oled_data <= BACKGROUND;
        end 
        
        
        counter <= counter + 1;
        /*
        if (btnL && boxNum != 0 && boxNum != 4 && boxNum != 8 && ~movedLeft) begin
            xLeft <= xLeft - 13;
            xRight <= xRight - 13;
            boxNum <= boxNum - 1;
            movedLeft <= 1;
            counter <= 0;
        end        */
        
        if (btnR && boxNum == 3 && ~movedRight && isSnack) begin
            ari_control <= 1;
            isSnack <= 0;
        
            isNext <= 0;
            boxNum <= 0;
            yUp <= 14;
            yDown <= 24;
        end
        
        
        if (btnU && boxNum == 3 && ~movedUp && !(isNumpadD || isNumpadE || isNumpadF) && isSnack) begin
            isNext <= 0;
            
            boxNum <= boxNum - 1;
            movedUp <= 1;
            counter <= 0;
        end else if (btnU && boxNum != 0 && ~movedUp && !(isNumpadD || isNumpadE || isNumpadF) && isSnack) begin
            yUp <= yUp - 13;
            yDown <= yDown - 13;
            boxNum <= boxNum - 1;
            movedUp <= 1;
            counter <= 0;
        end else if (btnU && boxNum == 0 && ~movedUp && !(isNumpadD || isNumpadE || isNumpadF) && isSnack) begin
            isMainMenu <= 1;
            isSnack <= 0;
        end
        
        if (btnD && boxNum < 2 && ~movedDown && !(isNumpadD || isNumpadE || isNumpadF) && isSnack && isToggled) begin
            yUp <= yUp + 13;
            yDown <= yDown + 13;
            boxNum <= boxNum + 1;
            movedDown <= 1;
            counter <= 0;
        end else if (btnD && boxNum == 2 && ~movedDown && !(isNumpadD || isNumpadE || isNumpadF) && isSnack && isToggled) begin
            isNext <= 1;
            
            boxNum <= boxNum + 1;  //increment boxNum to 3
            movedDown <= 1;
            counter <= 0;            
        end
        
        if (isMain) begin
            isMainMenu <= 0;
        end         
        
        if (counter >= DEBOUNCE_COUNT*2) begin
            isToggled <= 1;
        end
        
        
        if (isMain_D || isMain_E || isMain_F || isSnackMenu) begin
            isToggled <= 0;
            counter <= 0;
                        
            isNumpadD <= 0;
            isNumpadE <= 0;
            isNumpadF <= 0;
            isSnack <= 1;
        end      
        
 

        /*
        if (btnC && ~movedCenter && !(isNumpadD || isNumpadE || isNumpadF) && isSnack) begin
            if (boxNum == 0) begin
                isNumpadD = 1;
                isSnack = 0;
                
            end else if (boxNum == 1) begin
                isNumpadE = 1;
                isSnack = 0; 
    
            end else if (boxNum == 2) begin 
                isNumpadF = 1;
                isSnack = 0;
       
            end else begin //boxNum == 3 arrow next
                //handle go next to ruijie module
                //isSnack <= 0;
                ari_control <= 1;
                isSnack <= 0;
                
                isNext <= 0;
                boxNum <= 0;
                yUp <= 14;
                yDown <= 24;
            end
              
            movedCenter <= 1;
            counter <= 0;
        end 
        */
        if (btnC && ~movedCenter && !(isNumpadD || isNumpadE || isNumpadF) && isSnack) begin
            if (boxNum == 0) begin
                isNumpadD = 1;
                isSnack = 0;
                
            end else if (boxNum == 1) begin
                isNumpadE = 1;
                isSnack = 0; 
    
            end else if (boxNum == 2) begin 
                isNumpadF = 1;
                isSnack = 0;
       
            end 
              
            movedCenter <= 1;
            counter <= 0;
        end         
        
        /*
        if (~btnL && counter >= DEBOUNCE_COUNT) begin
            movedLeft <= 0;
        end */
        
        if (~btnR && counter >= DEBOUNCE_COUNT) begin
            movedRight <= 0;
        end
        
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


