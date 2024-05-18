`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2024 12:28:14
// Design Name: 
// Module Name: Keith_module
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
// selected 
//////////////////////////////////////////////////////////////////////////////////


module Keith_module(
input clk, input btnC,btnL,btnR,btnU,btnD,
                 input [1:0]sw, 
                 input [12:0] pixel_index,
                 input [7:0]x,input[6:0]y,
                 input [7:0]control,input [15:0]Ari_kcal,
                 output reg [3:0] exercise_damien,output reg change_screen,output reg change_screen_Ari,
                 output reg[10:0] push_out,output reg[10:0] sit_out,output reg[10:0] pull_out,output reg[31:0] run_out,
                 output reg [7:0]an0,output reg [7:0]an1,output reg [7:0]an2,output reg [7:0]an3,
                 output reg [15:0] oled_data 
    );
    wire [15:0]pushup_up_pic;
    wire [15:0]pushup_up_pic1;
       BRAM_menu (.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pushup_up_pic));              
       BRAM_menu1 (.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pushup_up_pic1));              
                      
        reg digit0[0:6][0:3];
        reg digit1[0:6][0:3];
        reg digit2[0:6][0:3];
        reg digit3[0:6][0:3];
        reg digit4[0:6][0:3];
        reg digit5[0:6][0:3];
        reg digit6[0:6][0:3];
        reg digit7[0:6][0:3];
        reg digit8[0:6][0:3];
        reg digit9[0:6][0:3];
        
        reg num1[0:6][0:3];
        reg num2[0:6][0:3];
        reg num3[0:6][0:3];
        reg num4[0:6][0:3];
        reg num5[0:6][0:3];
        reg num6[0:6][0:3];
        reg num7[0:6][0:3];
        reg num8[0:6][0:3];            
        reg cross[0:8][0:12];
        reg tick[0:8][0:12];
        
        reg[5:0] state =0;
            
        reg[31:0] count = 0;
        reg[31:0] count1 = 0;
        reg[31:0] count2 = 0;
        reg[31:0] count3 = 0;
        reg[10:0] num_pushup = 0;    
        reg[10:0] num_situp = 0;
        reg[10:0] num_running = 0;
        reg[10:0] num_pullup = 0;
        reg[31:0] num_total;   
        reg[15:0] pushup_color;
        reg[15:0] situp_color;
        reg[15:0] pullup_color;
        reg[15:0] running_color;
        reg[31:0] flicker_count;
        reg[3:0] seed;
        reg[1:0] screen = 0; 
        
        reg[15:0] pushup_Scolor;
        reg[15:0] situp_Scolor ;
        reg[15:0] pullup_Scolor ;
        reg[15:0] running_Scolor ;
        reg random_color;
        reg random_color_b;
        reg[31:0] btnC_count;
        reg pushup_en = 1;
        reg situp_en = 1;
        reg pullup_en = 1;
        reg running_en = 1;
        reg[15:0] num_kcal_burn; //Ari's problem
        reg [1:0] random_control = 1;
        initial begin    //assign array number values
        cross[0][0] <= 0; //red cross for first pg
        cross[0][1] <= 0;
        cross[0][2] <= 1;
        cross[0][3] <= 0;
        cross[0][4] <= 0;
        cross[0][5] <= 0;
        cross[0][6] <= 0;
        cross[0][7] <= 0;
        cross[0][8] <= 0;
        cross[0][9] <= 0;
        cross[0][10] <= 1;
        cross[0][11] <= 0;
        cross[0][12] <= 0;
        
        cross[1][0] <= 0; 
        cross[1][1] <= 0;
        cross[1][2] <= 0;
        cross[1][3] <= 1;
        cross[1][4] <= 0;
        cross[1][5] <= 0;
        cross[1][6] <= 0;
        cross[1][7] <= 0;
        cross[1][8] <= 0;
        cross[1][9] <= 1;
        cross[1][10] <= 0;
        cross[1][11] <= 0;
        cross[1][12] <= 0;
        
        cross[2][0] <= 0; 
        cross[2][1] <= 0;
        cross[2][2] <= 0;
        cross[2][3] <= 0;
        cross[2][4] <= 1;
        cross[2][5] <= 0;
        cross[2][6] <= 0;
        cross[2][7] <= 0;
        cross[2][8] <= 1;
        cross[2][9] <= 0;
        cross[2][10] <= 0;
        cross[2][11] <= 0;
        cross[2][12] <= 0;
        
        cross[3][0] <= 0; 
        cross[3][1] <= 0;
        cross[3][2] <= 0;
        cross[3][3] <= 0;
        cross[3][4] <= 0;
        cross[3][5] <= 1;
        cross[3][6] <= 0;
        cross[3][7] <= 1;
        cross[3][8] <= 0;
        cross[3][9] <= 0;
        cross[3][10] <= 0;
        cross[3][11] <= 0;
        cross[3][12] <= 0;
        
        cross[4][0] <= 0; 
        cross[4][1] <= 0;
        cross[4][2] <= 0;
        cross[4][3] <= 0;
        cross[4][4] <= 0;
        cross[4][5] <= 0;
        cross[4][6] <= 1;
        cross[4][7] <= 0;
        cross[4][8] <= 0;
        cross[4][9] <= 0;
        cross[4][10] <= 0;
        cross[4][11] <= 0;
        cross[4][12] <= 0;
        
        cross[5][0] <= 0; 
        cross[5][1] <= 0;
        cross[5][2] <= 0;
        cross[5][3] <= 0;
        cross[5][4] <= 0;
        cross[5][5] <= 1;
        cross[5][6] <= 0;
        cross[5][7] <= 1;
        cross[5][8] <= 0;
        cross[5][9] <= 0;
        cross[5][10] <= 0;
        cross[5][11] <= 0;
        cross[5][12] <= 0;
        
        cross[6][0] <= 0; 
        cross[6][1] <= 0;
        cross[6][2] <= 0;
        cross[6][3] <= 0;
        cross[6][4] <= 1;
        cross[6][5] <= 0;
        cross[6][6] <= 0;
        cross[6][7] <= 0;
        cross[6][8] <= 1;
        cross[6][9] <= 0;
        cross[6][10] <= 0;
        cross[6][11] <= 0;
        cross[6][12] <= 0;
        
        cross[7][0] <= 0; 
        cross[7][1] <= 0;
        cross[7][2] <= 0;
        cross[7][3] <= 1;
        cross[7][4] <= 0;
        cross[7][5] <= 0;
        cross[7][6] <= 0;
        cross[7][7] <= 0;
        cross[7][8] <= 0;
        cross[7][9] <= 1;
        cross[7][10] <= 0;
        cross[7][11] <= 0;
        cross[7][12] <= 0;
        
        cross[8][0] <= 0; 
        cross[8][1] <= 0;
        cross[8][2] <= 1;
        cross[8][3] <= 0;
        cross[8][4] <= 0;
        cross[8][5] <= 0;
        cross[8][6] <= 0;
        cross[8][7] <= 0;
        cross[8][8] <= 0;
        cross[8][9] <= 0;
        cross[8][10] <= 1;
        cross[8][11] <= 0;
        cross[8][12] <= 0;
        
        tick[0][0] <= 0; //green tick for first pg
        tick[0][1] <= 0;
        tick[0][2] <= 0;
        tick[0][3] <= 0;
        tick[0][4] <= 0;
        tick[0][5] <= 0;
        tick[0][6] <= 0;
        tick[0][7] <= 0;
        tick[0][8] <= 0;
        tick[0][9] <= 0;
        tick[0][10] <= 0;
        tick[0][11] <= 0;
        tick[0][12] <= 1;
        
        tick[1][0] <= 0; 
        tick[1][1] <= 0;
        tick[1][2] <= 0;
        tick[1][3] <= 0;
        tick[1][4] <= 0;
        tick[1][5] <= 0;
        tick[1][6] <= 0;
        tick[1][7] <= 0;
        tick[1][8] <= 0;
        tick[1][9] <= 0;
        tick[1][10] <= 0;
        tick[1][11] <= 1;
        tick[1][12] <= 0;
        
        tick[2][0] <= 0; 
        tick[2][1] <= 0;
        tick[2][2] <= 0;
        tick[2][3] <= 0;
        tick[2][4] <= 0;
        tick[2][5] <= 0;
        tick[2][6] <= 0;
        tick[2][7] <= 0;
        tick[2][8] <= 0;
        tick[2][9] <= 0;
        tick[2][10] <= 1;
        tick[2][11] <= 0;
        tick[2][12] <= 0;
        
        tick[3][0] <= 0; 
        tick[3][1] <= 0;
        tick[3][2] <= 0;
        tick[3][3] <= 0;
        tick[3][4] <= 0;
        tick[3][5] <= 0;
        tick[3][6] <= 0;
        tick[3][7] <= 0;
        tick[3][8] <= 0;
        tick[3][9] <= 1;
        tick[3][10] <= 0;
        tick[3][11] <= 0;
        tick[3][12] <= 0;
        
        tick[4][0] <= 1; 
        tick[4][1] <= 0;
        tick[4][2] <= 0;
        tick[4][3] <= 0;
        tick[4][4] <= 0;
        tick[4][5] <= 0;
        tick[4][6] <= 0;
        tick[4][7] <= 0;
        tick[4][8] <= 1;
        tick[4][9] <= 0;
        tick[4][10] <= 0;
        tick[4][11] <= 0;
        tick[4][12] <= 0;
        
        tick[5][0] <= 0; 
        tick[5][1] <= 1;
        tick[5][2] <= 0;
        tick[5][3] <= 0;
        tick[5][4] <= 0;
        tick[5][5] <= 0;
        tick[5][6] <= 0;
        tick[5][7] <= 1;
        tick[5][8] <= 0;
        tick[5][9] <= 0;
        tick[5][10] <= 0;
        tick[5][11] <= 0;
        tick[5][12] <= 0;
        
        tick[6][0] <= 0; 
        tick[6][1] <= 0;
        tick[6][2] <= 1;
        tick[6][3] <= 0;
        tick[6][4] <= 0;
        tick[6][5] <= 0;
        tick[6][6] <= 1;
        tick[6][7] <= 0;
        tick[6][8] <= 0;
        tick[6][9] <= 0;
        tick[6][10] <= 0;
        tick[6][11] <= 0;
        tick[6][12] <= 0;
        
        tick[7][0] <= 0; 
        tick[7][1] <= 0;
        tick[7][2] <= 0;
        tick[7][3] <= 1;
        tick[7][4] <= 0;
        tick[7][5] <= 1;
        tick[7][6] <= 0;
        tick[7][7] <= 0;
        tick[7][8] <= 0;
        tick[7][9] <= 0;
        tick[7][10] <= 0;
        tick[7][11] <= 0;
        tick[7][12] <= 0;
        
        tick[8][0] <= 0; 
        tick[8][1] <= 0;
        tick[8][2] <= 0;
        tick[8][3] <= 0;
        tick[8][4] <= 1;
        tick[8][5] <= 0;
        tick[8][6] <= 0;
        tick[8][7] <= 0;
        tick[8][8] <= 0;
        tick[8][9] <= 0;
        tick[8][10] <= 0;
        tick[8][11] <= 0;
        tick[8][12] <= 0;
        
        digit0[0][0] <= 0; // digit 0
        digit0[0][1] <= 1;
        digit0[0][2] <= 1;
        digit0[0][3] <= 0;
        
        digit0[1][0] <= 1;
        digit0[1][1] <= 0;
        digit0[1][2] <= 0;
        digit0[1][3] <= 1;
        
        digit0[2][0] <= 1;
        digit0[2][1] <= 0;
        digit0[2][2] <= 0;
        digit0[2][3] <= 1;
      
        digit0[3][0] <= 1;
        digit0[3][1] <= 0;
        digit0[3][2] <= 0;
        digit0[3][3] <= 1;
      
        digit0[4][0] <= 1;
        digit0[4][1] <= 0;
        digit0[4][2] <= 0;
        digit0[4][3] <= 1;
      
        digit0[5][0] <= 1;
        digit0[5][1] <= 0;
        digit0[5][2] <= 0;
        digit0[5][3] <= 1;
      
        digit0[6][0] <= 0;
        digit0[6][1] <= 1;
        digit0[6][2] <= 1;
        digit0[6][3] <= 0;
        
        
        digit1[0][0] <= 0; // digit 1
        digit1[0][1] <= 0;
        digit1[0][2] <= 1;
        digit1[0][3] <= 0;
        
        digit1[1][0] <= 0;
        digit1[1][1] <= 1;
        digit1[1][2] <= 1;
        digit1[1][3] <= 0;
        
        digit1[2][0] <= 1;
        digit1[2][1] <= 0;
        digit1[2][2] <= 1;
        digit1[2][3] <= 0;
      
        digit1[3][0] <= 0;
        digit1[3][1] <= 0;
        digit1[3][2] <= 1;
        digit1[3][3] <= 0;
      
        digit1[4][0] <= 0;
        digit1[4][1] <= 0;
        digit1[4][2] <= 1;
        digit1[4][3] <= 0;
      
        digit1[5][0] <= 0;
        digit1[5][1] <= 0;
        digit1[5][2] <= 1;
        digit1[5][3] <= 0;
      
        digit1[6][0] <= 0;
        digit1[6][1] <= 0;
        digit1[6][2] <= 1;
        digit1[6][3] <= 0;
        
        
        digit2[0][0] <= 0; //digit 2
        digit2[0][1] <= 1;
        digit2[0][2] <= 1;
        digit2[0][3] <= 0;
        
        digit2[1][0] <= 1;
        digit2[1][1] <= 0;
        digit2[1][2] <= 0;
        digit2[1][3] <= 1;
        
        digit2[2][0] <= 0;
        digit2[2][1] <= 0;
        digit2[2][2] <= 0;
        digit2[2][3] <= 1;
      
        digit2[3][0] <= 0;
        digit2[3][1] <= 0;
        digit2[3][2] <= 1;
        digit2[3][3] <= 0;
      
        digit2[4][0] <= 0;
        digit2[4][1] <= 1;
        digit2[4][2] <= 0;
        digit2[4][3] <= 0;
      
        digit2[5][0] <= 1;
        digit2[5][1] <= 0;
        digit2[5][2] <= 0;
        digit2[5][3] <= 0;
      
        digit2[6][0] <= 1;
        digit2[6][1] <= 1;
        digit2[6][2] <= 1;
        digit2[6][3] <= 1;
       
       
        digit3[0][0] <= 0; // digit 3
        digit3[0][1] <= 1;
        digit3[0][2] <= 1;
        digit3[0][3] <= 0;
        
        digit3[1][0] <= 1;
        digit3[1][1] <= 0;
        digit3[1][2] <= 0;
        digit3[1][3] <= 1;
        
        digit3[2][0] <= 0;
        digit3[2][1] <= 0;
        digit3[2][2] <= 0;
        digit3[2][3] <= 1;
      
        digit3[3][0] <= 0;
        digit3[3][1] <= 1;
        digit3[3][2] <= 1;
        digit3[3][3] <= 0;
     
        digit3[4][0] <= 0;
        digit3[4][1] <= 0;
        digit3[4][2] <= 0;
        digit3[4][3] <= 1;
      
        digit3[5][0] <= 1;
        digit3[5][1] <= 0;
        digit3[5][2] <= 0;
        digit3[5][3] <= 1;
      
        digit3[6][0] <= 0;
        digit3[6][1] <= 1;
        digit3[6][2] <= 1;
        digit3[6][3] <= 0;
        
        
        digit4[0][0] <= 0; // digit 4
        digit4[0][1] <= 0;
        digit4[0][2] <= 0;
        digit4[0][3] <= 1;
        
        digit4[1][0] <= 0;
        digit4[1][1] <= 0;
        digit4[1][2] <= 1;
        digit4[1][3] <= 1;
        
        digit4[2][0] <= 0;
        digit4[2][1] <= 1;
        digit4[2][2] <= 0;
        digit4[2][3] <= 1;
      
        digit4[3][0] <= 1;
        digit4[3][1] <= 0;
        digit4[3][2] <= 0;
        digit4[3][3] <= 1;
     
        digit4[4][0] <= 1;
        digit4[4][1] <= 1;
        digit4[4][2] <= 1;
        digit4[4][3] <= 1;
      
        digit4[5][0] <= 0;
        digit4[5][1] <= 0;
        digit4[5][2] <= 0;
        digit4[5][3] <= 1;
      
        digit4[6][0] <= 0;
        digit4[6][1] <= 0;
        digit4[6][2] <= 0;
        digit4[6][3] <= 1;
        
        
        digit5[0][0] <= 1;// digit 5
        digit5[0][1] <= 1;
        digit5[0][2] <= 1;
        digit5[0][3] <= 1;
        
        digit5[1][0] <= 1;
        digit5[1][1] <= 0;
        digit5[1][2] <= 0;
        digit5[1][3] <= 0;
        
        digit5[2][0] <= 1;
        digit5[2][1] <= 1;
        digit5[2][2] <= 1;
        digit5[2][3] <= 0;
      
        digit5[3][0] <= 0;
        digit5[3][1] <= 0;
        digit5[3][2] <= 0;
        digit5[3][3] <= 1;
     
        digit5[4][0] <= 0;
        digit5[4][1] <= 0;
        digit5[4][2] <= 0;
        digit5[4][3] <= 1;
      
        digit5[5][0] <= 1;
        digit5[5][1] <= 0;
        digit5[5][2] <= 0;
        digit5[5][3] <= 1;
      
        digit5[6][0] <= 0;
        digit5[6][1] <= 1;
        digit5[6][2] <= 1;
        digit5[6][3] <= 0;

        
        digit6[0][0] <= 0; // digit 6
        digit6[0][1] <= 1;
        digit6[0][2] <= 1;
        digit6[0][3] <= 0;
        
        digit6[1][0] <= 1;
        digit6[1][1] <= 0;
        digit6[1][2] <= 0;
        digit6[1][3] <= 0;
        
        digit6[2][0] <= 1;
        digit6[2][1] <= 0;
        digit6[2][2] <= 0;
        digit6[2][3] <= 0;
      
        digit6[3][0] <= 1;
        digit6[3][1] <= 1;
        digit6[3][2] <= 1;
        digit6[3][3] <= 0;
     
        digit6[4][0] <= 1;
        digit6[4][1] <= 0;
        digit6[4][2] <= 0;
        digit6[4][3] <= 1;
      
        digit6[5][0] <= 1;
        digit6[5][1] <= 0;
        digit6[5][2] <= 0;
        digit6[5][3] <= 1;
      
        digit6[6][0] <= 0;
        digit6[6][1] <= 1;
        digit6[6][2] <= 1;
        digit6[6][3] <= 0;
       
        
        digit7[0][0] <= 1; // digit 7
        digit7[0][1] <= 1;
        digit7[0][2] <= 1;
        digit7[0][3] <= 1;
        
        digit7[1][0] <= 0;
        digit7[1][1] <= 0;
        digit7[1][2] <= 0;
        digit7[1][3] <= 1;
        
        digit7[2][0] <= 0;
        digit7[2][1] <= 0;
        digit7[2][2] <= 0;
        digit7[2][3] <= 1;
      
        digit7[3][0] <= 0;
        digit7[3][1] <= 0;
        digit7[3][2] <= 1;
        digit7[3][3] <= 0;
     
        digit7[4][0] <= 0;
        digit7[4][1] <= 1;
        digit7[4][2] <= 0;
        digit7[4][3] <= 0;
      
        digit7[5][0] <= 0;
        digit7[5][1] <= 1;
        digit7[5][2] <= 0;
        digit7[5][3] <= 0;
      
        digit7[6][0] <= 0;
        digit7[6][1] <= 1;
        digit7[6][2] <= 0;
        digit7[6][3] <= 0;
       
        
        digit8[0][0] <= 0; // digit 8
        digit8[0][1] <= 1;
        digit8[0][2] <= 1;
        digit8[0][3] <= 0;
        
        digit8[1][0] <= 1;
        digit8[1][1] <= 0;
        digit8[1][2] <= 0;
        digit8[1][3] <= 1;
        
        digit8[2][0] <= 1;
        digit8[2][1] <= 0;
        digit8[2][2] <= 0;
        digit8[2][3] <= 1;
      
        digit8[3][0] <= 0;
        digit8[3][1] <= 1;
        digit8[3][2] <= 1;
        digit8[3][3] <= 0;
     
        digit8[4][0] <= 1;
        digit8[4][1] <= 0;
        digit8[4][2] <= 0;
        digit8[4][3] <= 1;
      
        digit8[5][0] <= 1;
        digit8[5][1] <= 0;
        digit8[5][2] <= 0;
        digit8[5][3] <= 1;
      
        digit8[6][0] <= 0;
        digit8[6][1] <= 1;
        digit8[6][2] <= 1;
        digit8[6][3] <= 0;
        
        
        digit9[0][0] <= 0; // digit 9
        digit9[0][1] <= 1;
        digit9[0][2] <= 1;
        digit9[0][3] <= 0;
        
        digit9[1][0] <= 1;
        digit9[1][1] <= 0;
        digit9[1][2] <= 0;
        digit9[1][3] <= 1;
        
        digit9[2][0] <= 1;
        digit9[2][1] <= 0;
        digit9[2][2] <= 0;
        digit9[2][3] <= 1;
      
        digit9[3][0] <= 0;
        digit9[3][1] <= 1;
        digit9[3][2] <= 1;
        digit9[3][3] <= 1;
     
        digit9[4][0] <= 0;
        digit9[4][1] <= 0;
        digit9[4][2] <= 0;
        digit9[4][3] <= 1;
      
        digit9[5][0] <= 1;
        digit9[5][1] <= 0;
        digit9[5][2] <= 0;
        digit9[5][3] <= 1;
      
        digit9[6][0] <= 0;
        digit9[6][1] <= 1;
        digit9[6][2] <= 1;
        digit9[6][3] <= 0;
       end          
       
        always @ (posedge clk)
        begin
        change_screen <= 0;
        change_screen_Ari <= 0;
        if (control == 0)begin
        
        if(screen == 0) begin
        num_kcal_burn <= Ari_kcal;       
          // Ari's Problem
                        if((num_kcal_burn%10) == 1)begin //first digit of Kcal
                an0 <= 8'b11111001;        end
                else if((num_kcal_burn%10) == 2)begin        an0 <= 8'b10100100;       
                end
                else if((num_kcal_burn%10) == 3)begin        an0 <= 8'b10110000;                
                end        else if((num_kcal_burn%10) == 4)begin
                an0 <= 8'b10011001;                        end
                else if((num_kcal_burn%10) == 5)begin        an0 <= 8'b10010010;               
                end        else if((num_kcal_burn%10) == 6)begin
                an0 <= 8'b10000010;                        end
                else if((num_kcal_burn%10) == 7)begin        an0 <= 8'b11111000;               
                end        else if((num_kcal_burn%10) == 8)begin
                an0 <= 8'b10000000;                        end
                else if((num_kcal_burn%10) == 9)begin        an0 <= 8'b10011000;                
                end        else begin
                an0 <= 8'b11000000;        end
                
                        if(((num_kcal_burn/10)%10) == 1)begin //second digit of Kcal
                an1 <= 8'b11111001;        end
                else if(((num_kcal_burn/10)%10) == 2)begin        an1 <= 8'b10100100;       
                end        else if(((num_kcal_burn/10)%10) == 3)begin
                an1 <= 8'b10110000;                        end
                else if(((num_kcal_burn/10)%10) == 4)begin
                an1 <= 8'b10011001;                        end
                else if(((num_kcal_burn/10)%10) == 5)begin        an1 <= 8'b10010010;               
                end        else if(((num_kcal_burn/10)%10) == 6)begin
                an1 <= 8'b10000010;                        end
                else if(((num_kcal_burn/10)%10) == 7)begin        an1 <= 8'b11111000;               
                end        else if(((num_kcal_burn/10)%10) == 8)begin
                an1 <= 8'b10000000;                        end
                else if(((num_kcal_burn/10)%10) == 9)begin        an1 <= 8'b10011000;                
                end        else begin
                an1 <= 8'b11000000;        end
                
                        if(((num_kcal_burn/100)%10) == 1)begin //third digit of Kcal
                an2 <= 8'b11111001;
                end        else if(((num_kcal_burn/100)%10) == 2)begin
                an2 <= 8'b10100100;               end
                else if(((num_kcal_burn/100)%10) == 3)begin        an2 <= 8'b10110000;                
                end        else if(((num_kcal_burn/100)%10) == 4)begin
                an2 <= 8'b10011001;                        end
                else if(((num_kcal_burn/100)%10) == 5)begin        an2 <= 8'b10010010;               
                end        else if(((num_kcal_burn/100)%10) == 6)begin
                an2 <= 8'b10000010;                        end
                else if(((num_kcal_burn/100)%10) == 7)begin        an2 <= 8'b11111000;               
                end        else if(((num_kcal_burn/100)%10) == 8)begin
                an2 <= 8'b10000000;                        end
                else if(((num_kcal_burn/100)%10) == 9)begin        an2 <= 8'b10011000;                
                end        else begin
                an2 <= 8'b11000000;        end
                
                if(((num_kcal_burn/1000)%10) == 1)begin //fourth digit of Kcal
                an3 <= 8'b11111001;
                end        else if(((num_kcal_burn/1000)%10) == 2)begin
                an3 <= 8'b10100100;               end
                else if(((num_kcal_burn/1000)%10) == 3)begin        an3 <= 8'b10110000;                
                end        else if(((num_kcal_burn/1000)%10) == 4)begin
                an3 <= 8'b10011001;                        end
                else if(((num_kcal_burn/1000)%10) == 5)begin        an3 <= 8'b10010010;               
                end        else if(((num_kcal_burn/1000)%10) == 6)begin
                an3 <= 8'b10000010;                        end
                else if(((num_kcal_burn/1000)%10) == 7)begin        an3 <= 8'b11111000;               
                end        else if(((num_kcal_burn/1000)%10) == 8)begin
                an3 <= 8'b10000000;                        end
                else if(((num_kcal_burn/1000)%10) == 9)begin        an3 <= 8'b10011000;                
                end        else begin
                an3 <= 8'b10111111;        end
                
        if(state == 0)begin
        situp_Scolor <= 16'b11111_111111_11111;
        pullup_Scolor <= 16'b11111_111111_11111;
        running_Scolor <= 16'b11111_111111_11111;
        random_color <= 1;
        random_color_b<= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000 && pushup_en == 1)begin
        pushup_Scolor <= 16'b00000_111111_00000;
        end
        else if(flicker_count < 1500000 && pushup_en == 0)begin
        pushup_Scolor <= 16'b11111_000000_00000;
        end
        else begin
        pushup_Scolor <= 16'b00000_000000_00000;
        end
        
        if(btnC == 1)begin
        btnC_count <= btnC_count + 1;
        end
        else if(btnC == 0 && btnC_count > 10000)begin
        btnC_count <= 0;
        pushup_en = ~pushup_en;
        end
        else begin
        btnC_count <= 0;
        end
        
        if(btnR == 1)begin
        count <= count + 1;
        end
        else if(btnR == 0 && count > 1000) begin
        count <= 0;
        state <= 1;
        end
        else begin
        count <= 0;
        end
        
        if(btnD == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnD == 0 && count2 > 1000) begin
        count2 <= 0;
        state <= 2;
        end
        else begin
        count2 <= 0;
        end
            
        end 
        
        else if (state == 1) begin
        pushup_Scolor <= 16'b11111_111111_11111;
        pullup_Scolor <= 16'b11111_111111_11111;
        running_Scolor <= 16'b11111_111111_11111;
        random_color <= 1;
        random_color_b<= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000 && situp_en == 1)begin
        situp_Scolor <= 16'b00000_111111_00000;
        end
        else if(flicker_count < 1500000 && situp_en == 0)begin
        situp_Scolor <= 16'b11111_000000_00000;
        end
        else begin
        situp_Scolor <= 16'b00000_000000_00000;
        end
        
        if(btnC == 1)begin
        btnC_count <= btnC_count + 1;
        end
        else if(btnC == 0 && btnC_count > 10000)begin
        btnC_count <= 0;
        situp_en = ~situp_en;
        end
        else begin
        btnC_count <= 0;
        end
        
        
        if(btnL == 1)begin
        count <= count + 1;
        end
        else if(btnL == 0 && count > 1000) begin
        count <= 0;
        state <= 0;
        end
        else begin
        count <= 0;
        end
        
        if(btnD == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnD == 0 && count2 > 1000) begin
        count2 <= 0;
        state <= 3;
        end
        else begin
        count2 <= 0;
        end
        
        end
        
        
        else if (state == 2) begin
        situp_Scolor <= 16'b11111_111111_11111;
        pushup_Scolor <= 16'b11111_111111_11111;
        running_Scolor <= 16'b11111_111111_11111;
        random_color <= 1;
        random_color_b<= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000 && pullup_en == 1)begin
        pullup_Scolor <= 16'b00000_111111_00000;
        end
        else if(flicker_count < 1500000 && pullup_en == 0)begin
        pullup_Scolor <= 16'b11111_000000_00000;
        end
        else begin
        pullup_Scolor <= 16'b00000_000000_00000;
        end
        
        if(btnC == 1)begin
        btnC_count <= btnC_count + 1;
        end
        else if(btnC == 0 && btnC_count > 10000)begin
        btnC_count <= 0;
        pullup_en = ~pullup_en;
        end
        else begin
        btnC_count <= 0;
        end
        
        
        if(btnR == 1)begin
        count <= count + 1;
        end
        else if(btnR == 0 && count > 100000) begin
        count <= 0;
        state <= 3;
        end
        else begin
        count <= 0;
        end
        
        if(btnU == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnU == 0 && count2 > 100000) begin
        count2 <= 0;
        state <= 0;
        end
        else begin
        count2 <= 0;
        end
        
        if(btnD == 1)begin
        count3 <= count3 + 1;
        end
        else if(btnD == 0 && count3 > 100000) begin
        count3 <= 0;
        state <= 4;
        end
        else begin
        count3 <= 0;
        end
    
        
        end
           
        else if (state == 3) begin
        situp_Scolor <= 16'b11111_111111_11111;
        pullup_Scolor <= 16'b11111_111111_11111;
        pushup_Scolor <= 16'b11111_111111_11111;
        random_color <= 1;
        random_color_b<= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000 && running_en == 1)begin
        running_Scolor <= 16'b00000_111111_00000;
        end
        else if(flicker_count < 1500000 && running_en == 0)begin
        running_Scolor <= 16'b11111_000000_00000;
        end
        else begin
        running_Scolor <= 16'b00000_000000_00000;
        end
        
        if(btnC == 1)begin
        btnC_count <= btnC_count + 1;
        end
        else if(btnC == 0 && btnC_count > 10000)begin
        btnC_count <= 0;
        running_en = ~running_en;
        end
        else begin
        btnC_count <= 0;
        end
        
        
        if(btnL == 1)begin
        count <= count + 1;
        end
        else if(btnL == 0 && count > 1000) begin
        count <= 0;
        state <= 2;
        end
        else begin
        count <= 0;
        end
        
        if(btnU == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnU == 0 && count2 > 1000) begin
        count2 <= 0;
        state <= 1;
        end
        else begin
        count2 <= 0;
        end  
        
       if(btnD == 1)begin
       count3 <= count3 + 1;
       end
       else if(btnD == 0 && count3 > 100000) begin
       count3 <= 0;
       state <= 5;
       end
       else begin
       count3 <= 0;
       end
        
        
             
        end
        
        else if (state == 4) begin
        situp_Scolor <= 16'b11111_111111_11111;
        pullup_Scolor <= 16'b11111_111111_11111;
        pushup_Scolor <= 16'b11111_111111_11111;
        running_Scolor <= 16'b11111_111111_11111;
        random_color<= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000 )begin
        random_color_b<= 1;
        end
        else begin
        random_color_b<= 0;
        end
        
        if(btnL == 1)begin
        count <= count + 1;
        end
        else if(btnL == 0 && count > 100000) begin
        count <= 0;
        state <= 0;
        change_screen_Ari <= 1;
        end
        else begin
        count <= 0;
        end
        
        if(btnR == 1)begin
        btnC_count <= btnC_count + 1;
        end
        else if(btnR == 0 && btnC_count > 100000)begin
        btnC_count <= 0;
        state <= 5;
        end
        else begin
        btnC_count <= 0;
        end
        
        if(btnU == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnU == 0 && count2 > 100000) begin
        count2 <= 0;
        state <= 2;
        end
        else begin
        count2 <= 0;
        end       
        end  
        
        
        else if (state == 5) begin
        situp_Scolor <= 16'b11111_111111_11111;
        pullup_Scolor <= 16'b11111_111111_11111;
        pushup_Scolor <= 16'b11111_111111_11111;
        running_Scolor <= 16'b11111_111111_11111;
        random_color_b<= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000 )begin
        random_color<= 1;
        end
        else begin
        random_color<= 0;
        end
        
        if(btnL == 1)begin
        count <= count + 1;
        end
        else if(btnL == 0 && count > 100000) begin
        count <= 0;
        state <= 4;
        end
        else begin
        count <= 0;
        end
        
        if(btnR == 1)begin
        btnC_count <= btnC_count + 1;
        end
        else if(btnR == 0 && btnC_count > 100000)begin
        btnC_count <= 0;
        state <= 0;
        screen <= 1;
        end
        else begin
        btnC_count <= 0;
        end
        
        if(btnU == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnU == 0 && count2 > 100000) begin
        count2 <= 0;
        state <= 3;
        end
        else begin
        count2 <= 0;
        end       
        end

                           
        seed <= seed + 1;
        if(seed == 15)begin
        seed <= 0;
        end
        
       
        if( x >= 10 && x <=22 && y >= 12 && y <= 20 )begin
            if(pushup_en == 1 && tick[y-12][x-10] == 1)begin
            oled_data <= pushup_Scolor;
            end
            else if(pushup_en == 0 && cross[y-12][x-10] == 1)begin
            oled_data <= pushup_Scolor;            
            end
            else begin
            oled_data <= 16'b00000_000000_00000;
            end   
        end
        else if( x >= 58 && x <=70 && y >= 12 && y <= 20 )begin
            if(situp_en == 1 && tick[y-12][x-58] == 1)begin
            oled_data <= situp_Scolor;
            end
            else if(situp_en == 0 && cross[y-12][x-58] == 1)begin
            oled_data <= situp_Scolor;            
            end
            else begin
            oled_data <= 16'b00000_000000_00000;
            end   
        end
        else if( x >= 10 && x <=22 && y >= 37 && y <= 45 )begin
            if(pullup_en == 1 && tick[y-37][x-10] == 1)begin
            oled_data <= pullup_Scolor;
            end
            else if(pullup_en == 0 && cross[y-37][x-10] == 1)begin
            oled_data <= pullup_Scolor;            
            end
            else begin
            oled_data <= 16'b00000_000000_00000;
            end   
        end
        else if( x >= 58 && x <=70 && y >= 37 && y <= 45 )begin
            if(running_en == 1 && tick[y-37][x-58] == 1)begin
            oled_data <= running_Scolor;
            end
            else if(running_en == 0 && cross[y-37][x-58] == 1)begin
            oled_data <= running_Scolor;            
            end
            else begin
            oled_data <= 16'b00000_000000_00000;
            end   
        end
        else if(y >= 52 && y <= 60 && random_color_b == 0 && x <=34 )begin
        oled_data <= 16'b00000_000000_00000;
        end
        else if(y >= 52 && y <= 60 && random_color == 0 && x > 34)begin
        oled_data <= 16'b00000_000000_00000;
        end
        else begin
        oled_data <= pushup_up_pic1;
        end

        end
        
        else if(screen == 1)begin
        
        
        if(3*num_pushup + 15*num_situp + 15*num_running + 10*num_pullup < num_kcal_burn && random_control == 1) begin
        seed[0] <= ~(seed[3] ^ seed[2]);
        seed[1] <= seed[0];
        seed[2] <= seed[1];
        seed[3] <= seed[2];
        if((seed[1:0] == 2'b00) && pushup_en == 1) begin
        num_pushup <=num_pushup + 1;
        end
        else if((seed[1:0]== 2'b01) && situp_en == 1) begin
        num_situp <= num_situp+ 1;      
        end
        else if((seed[1:0] == 2'b10) && pullup_en == 1) begin
        num_pullup <= num_pullup+ 1;               
        end
        else if((seed[1:0] == 2'b11) && running_en == 1) begin
        num_running <= num_running+ 1;                        
        end  
        end
        else if (3*num_pushup + 15*num_situp + 15*num_running + 10*num_pullup > num_kcal_burn)begin
        random_control <= 0;         
        end
        
        if(state == 0)begin
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000)begin
        pushup_color <= 16'b00000_111111_00000;
        end
        else begin
        pushup_color <= 16'b00000_000000_00000;
        end
        random_color <= 1;
        situp_color <= 16'b11111_111111_11111;
        pullup_color <= 16'b11111_111111_11111;
        running_color <= 16'b11111_111111_11111;
        if(btnC == 1)begin
        exercise_damien <= 4'b0001;
        change_screen <= 1;
        push_out <= num_pushup*10;
        end
        if(sw[0] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        num_pushup <= num_pushup + 1;
        count1 <= 0;
        end
        end
        
        else if(sw[1] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        if(num_pushup > 0)begin
        num_pushup <= num_pushup - 1;
        end
        count1 <= 0;
        end
        end
        
        if(btnR == 1)begin
        count <= count + 1;
        end
        else if(btnR == 0 && count > 1000) begin
        count <= 0;
        state <= 1;
        end
        else begin
        count <= 0;
        end
        
        
        if(btnD == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnD == 0 && count2 > 1000) begin
        count2 <= 0;
        state <= 2;
        end
        else begin
        count2 <= 0;
        end
            
        end 
        
        else if (state == 1) begin
        pushup_color <= 16'b11111_111111_11111;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000)begin
        situp_color <= 16'b00000_111111_00000;
        end
        else begin
        situp_color <= 16'b00000_000000_00000;
        end
        pullup_color <= 16'b11111_111111_11111;
        running_color <= 16'b11111_111111_11111;
        random_color <= 1;
        if(btnC == 1)begin
        exercise_damien <= 4'b0010;
        change_screen <= 1;
        sit_out <= num_situp*10;
        end
        
        if(sw[0] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        num_situp <= num_situp + 1;
        count1 <= 0;
        end
        end
        
        else if(sw[1] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        if(num_situp > 0)begin
        num_situp <= num_situp - 1;
        end
        count1 <= 0;
        end
        end
        
        
        if(btnL == 1)begin
        count <= count + 1;
        end
        else if(btnL == 0 && count > 1000) begin
        count <= 0;
        state <= 0;
        end
        else begin
        count <= 0;
        end
        
        if(btnD == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnD == 0 && count2 > 1000) begin
        count2 <= 0;
        state <= 3;
        end
        else begin
        count2 <= 0;
        end
        
        end
        
        
        else if (state == 2) begin
        pushup_color <= 16'b11111_111111_11111;
        situp_color <= 16'b11111_111111_11111;
        random_color <= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000)begin
        pullup_color <= 16'b00000_111111_00000;
        end
        else begin
        pullup_color <= 16'b00000_000000_00000;
        end
        running_color <= 16'b11111_111111_11111;
        if(btnC == 1)begin
        exercise_damien <= 4'b0100;
        change_screen <= 1;
        pull_out <= num_pullup*10;
        end
        
        if(sw[0] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        num_pullup <= num_pullup + 1;
        count1 <= 0;
        end
        end
        
        else if(sw[1] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        if(num_pullup > 0)begin
        num_pullup <= num_pullup - 1;
        end
        count1 <= 0;
        end
        end
        
        
        if(btnR == 1)begin
        count <= count + 1;
        end
        else if(btnR == 0 && count > 1000) begin
        count <= 0;
        state <= 3;
        end
        else begin
        count <= 0;
        end
        
        if(btnU == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnU == 0 && count2 > 1000) begin
        count2 <= 0;
        state <= 0;
        end
        else begin
        count2 <= 0;
        end
        
        if(btnD == 1)begin
       count3 <= count3 + 1;
       end
       else if(btnD == 0 && count3 > 100000) begin
       count3 <= 0;
       state <= 4;
       end
       else begin
       count3 <= 0;
       end
    
        
        end
           
        else if (state == 3) begin
        pushup_color <= 16'b11111_111111_11111;
        situp_color <= 16'b11111_111111_11111;
        pullup_color <= 16'b11111_111111_11111;
        random_color <= 1;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000)begin
        running_color <= 16'b00000_111111_00000;
        end
        else begin
        running_color <= 16'b00000_000000_00000;
        end
        if(btnC == 1)begin
        exercise_damien <= 4'b1000;
        change_screen <= 1;
        run_out <= num_running*60;
        end
        
        
        if(sw[0] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        num_running <= num_running + 1;
        count1 <= 0;
        end
        end
        
        else if(sw[1] == 1) begin
        count1 <= count1 + 1;
        if(count1 > 8000000)begin
        if(num_running > 0)begin
        num_running <= num_running - 1;
        end
        count1 <= 0;
        end
        end
        
        if(btnD == 1)begin
       count3 <= count3 + 1;
       end
       else if(btnD == 0 && count3 > 100000) begin
       count3 <= 0;
       state <= 4;
       end
       else begin
       count3 <= 0;
       end
        
        if(btnL == 1)begin
        count <= count + 1;
        end
        else if(btnL == 0 && count > 1000) begin
        count <= 0;
        state <= 2;
        end
        else begin
        count <= 0;
        end
        
        if(btnU == 1)begin
        count2 <= count2 + 1;
        end
        else if(btnU == 0 && count2 > 1000) begin
        count2 <= 0;
        state <= 1;
        end
        else begin
        count2 <= 0;
        end       
        end
        
        else if (state == 4) begin
        situp_color <= 16'b11111_111111_11111;
        pullup_color <= 16'b11111_111111_11111;
        pushup_color <= 16'b11111_111111_11111;
        running_color <= 16'b11111_111111_11111;
        flicker_count <= flicker_count +1;
        if (flicker_count > 3000000) begin
        flicker_count <= 0;
        end
        if(flicker_count < 1500000 )begin
        random_color <= 1;
        end
        else begin
        random_color <= 0;
        end
       
        if(btnL == 1)begin
        btnC_count <= btnC_count + 1;
        end
        else if(btnL == 0 && btnC_count > 10000)begin
        btnC_count <= 0;
        state <= 0;
        num_pushup <= 0;
        num_situp <= 0;
        num_pullup <= 0;
        num_running <= 0;
        screen <= 0;
        random_control <= 1;  
        end
        else begin
        btnC_count <= 0;
        end
       
       if(btnU == 1)begin
       count2 <= count2 + 1;
       end
       else if(btnU == 0 && count2 > 1000) begin
       count2 <= 0;
       state <= 2;
       end
       else begin
       count2 <= 0;
       end       
       end
        

        
        num_total <= 3*num_pushup + 15*num_situp + 15*num_running + 10*num_pullup;
        
        
        if((num_total%10) == 1)begin //first digit of Kcal
        an0 <= 8'b11111001;
        end
        else if((num_total%10) == 2)begin
        an0 <= 8'b10100100;       
        end
        else if((num_total%10) == 3)begin
        an0 <= 8'b10110000;                
        end
        else if((num_total%10) == 4)begin
        an0 <= 8'b10011001;                
        end
        else if((num_total%10) == 5)begin
        an0 <= 8'b10010010;               
        end
        else if((num_total%10) == 6)begin
        an0 <= 8'b10000010;                
        end
        else if((num_total%10) == 7)begin
        an0 <= 8'b11111000;               
        end
        else if((num_total%10) == 8)begin
        an0 <= 8'b10000000;                
        end
        else if((num_total%10) == 9)begin
        an0 <= 8'b10011000;                
        end
        else begin
        an0 <= 8'b11000000;
        end
        
        if(((num_total/10)%10) == 1)begin //second digit of Kcal
        an1 <= 8'b11111001;
        end
        else if(((num_total/10)%10) == 2)begin
        an1 <= 8'b10100100;       
        end
        else if(((num_total/10)%10) == 3)begin
        an1 <= 8'b10110000;                
        end
        else if(((num_total/10)%10) == 4)begin
        an1 <= 8'b10011001;                
        end
        else if(((num_total/10)%10) == 5)begin
        an1 <= 8'b10010010;               
        end
        else if(((num_total/10)%10) == 6)begin
        an1 <= 8'b10000010;                
        end
        else if(((num_total/10)%10) == 7)begin
        an1 <= 8'b11111000;               
        end
        else if(((num_total/10)%10) == 8)begin
        an1 <= 8'b10000000;                
        end
        else if(((num_total/10)%10) == 9)begin
        an1 <= 8'b10011000;                
        end
        else begin
        an1 <= 8'b11000000;
        end
        
        if(((num_total/100)%10) == 1)begin //third digit of Kcal
        an2 <= 8'b11111001;
        end
        else if(((num_total/100)%10) == 2)begin
        an2 <= 8'b10100100;       
        end
        else if(((num_total/100)%10) == 3)begin
        an2 <= 8'b10110000;                
        end
        else if(((num_total/100)%10) == 4)begin
        an2 <= 8'b10011001;                
        end
        else if(((num_total/100)%10) == 5)begin
        an2 <= 8'b10010010;               
        end
        else if(((num_total/100)%10) == 6)begin
        an2 <= 8'b10000010;                
        end
        else if(((num_total/100)%10) == 7)begin
        an2 <= 8'b11111000;               
        end
        else if(((num_total/100)%10) == 8)begin
        an2 <= 8'b10000000;                
        end
        else if(((num_total/100)%10) == 9)begin
        an2 <= 8'b10011000;                
        end
        else begin
        an2 <= 8'b11000000;
        end
        
        if(((num_total/1000)%10) == 1)begin //third digit of Kcal
        an3 <= 8'b11111001;
        end
        else if(((num_total/1000)%10) == 2)begin
        an3 <= 8'b10100100;       
        end
        else if(((num_total/1000)%10) == 3)begin
        an3 <= 8'b10110000;                
        end
        else if(((num_total/1000)%10) == 4)begin
        an3 <= 8'b10011001;                
        end
        else if(((num_total/1000)%10) == 5)begin
        an3 <= 8'b10010010;               
        end
        else if(((num_total/1000)%10) == 6)begin
        an3 <= 8'b10000010;                
        end
        else if(((num_total/1000)%10) == 7)begin
        an3 <= 8'b11111000;               
        end
        else if(((num_total/1000)%10) == 8)begin
        an3 <= 8'b10000000;                
        end
        else if(((num_total/1000)%10) == 9)begin
        an3 <= 8'b10011000;                
        end
        else begin
        an3 <= 8'b10111111;
        end
        
      if( x >= 15 && x <=18 && y >= 14 && y <= 20 )begin 
      
          if((num_pushup%10) == 1 && digit1[y-14][x-15]) begin
          oled_data <= pushup_color;
          end   
          else if((num_pushup%10) == 2 && digit2[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else if((num_pushup%10) == 3 && digit3[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else if((num_pushup%10) == 4 && digit4[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else if((num_pushup%10) == 5 && digit5[y-14][x-15]) begin
          oled_data <= pushup_color;
          end   
          else if((num_pushup%10) == 6 && digit6[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else if((num_pushup%10) == 7 && digit7[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else if((num_pushup%10) == 8 && digit8[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else if((num_pushup%10) == 9 && digit9[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else if((num_pushup%10) == 0 && digit0[y-14][x-15]) begin
          oled_data <= pushup_color;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end
          end    
      else if ( x >= 20 && x <=23 && y >= 14 && y <= 20 && digit0[y-14][x-20])begin
        oled_data <= pushup_color;
      end
      else if( x >= 10 && x <=13 && y >= 14 && y <= 20 )begin 
          if(((num_pushup/10)%10) == 1 && digit1[y-14][x-10]) begin
             oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 2 && digit2[y-14][x-10]) begin
             oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 3 && digit3[y-14][x-10]) begin
             oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 4 && digit4[y-14][x-10]) begin
             oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 5 && digit5[y-14][x-10]) begin
             oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 6 && digit6[y-14][x-10]) begin
              oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 7 && digit7[y-14][x-10]) begin
              oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 8 && digit8[y-14][x-10]) begin
              oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 9 && digit9[y-14][x-10]) begin
              oled_data <= pushup_color;
          end
          else if(((num_pushup/10)%10) == 0 && digit0[y-14][x-10]) begin
              oled_data <= pushup_color;
          end
          else begin
              oled_data <= 16'b00000_000000_00000;
          end
          end  
      else if( x >= 63 && x <=66 && y >= 14 && y <= 20 )begin 
          if((num_situp%10) == 1 && digit1[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 2 && digit2[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 3 && digit3[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 4 && digit4[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 5 && digit5[y-14][x-63]) begin
          oled_data <= situp_color;
          end   
          else if((num_situp%10) == 6 && digit6[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 7 && digit7[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 8 && digit8[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 9 && digit9[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else if((num_situp%10) == 0 && digit0[y-14][x-63]) begin
          oled_data <= situp_color;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end  
          end 
      else if ( x >= 68 && x <=71 && y >= 14 && y <= 20 && digit0[y-14][x-68])begin
        oled_data <= situp_color;
      end
      else if( x >= 58 && x <=61 && y >= 14 && y <= 20)begin 
          if(((num_situp/10)%10) == 1 && digit1[y-14][x-58]) begin
              oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 2 && digit2[y-14][x-58]) begin
          oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 3 && digit3[y-14][x-58]) begin
          oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 4 && digit4[y-14][x-58]) begin
          oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 5 && digit5[y-14][x-58]) begin
          oled_data <= situp_color;
          end   
          else if(((num_situp/10)%10) == 6 && digit6[y-14][x-58]) begin
          oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 7 && digit7[y-14][x-58]) begin
          oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 8 && digit8[y-14][x-58]) begin
          oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 9 && digit9[y-14][x-58]) begin
          oled_data <= situp_color;
          end
          else if(((num_situp/10)%10) == 0 && digit0[y-14][x-58]) begin
          oled_data <= situp_color;
          end   
          else begin
          oled_data <= 16'b00000_000000_00000;
          end   
          end  
      else if( x >= 15 && x <=18 && y >= 39 && y <= 45)begin 
          if((num_pullup%10) == 1 && digit1[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 2 && digit2[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 3 && digit3[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 4 && digit4[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 5 && digit5[y-39][x-15]) begin
          oled_data <= pullup_color;
          end   
          else if((num_pullup%10) == 6 && digit6[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 7 && digit7[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 8 && digit8[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 9 && digit9[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else if((num_pullup%10) == 0 && digit0[y-39][x-15]) begin
          oled_data <= pullup_color;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end
          end 
      else if ( x >= 20 && x <=23 && y >= 39 && y <= 45 && digit0[y-39][x-20])begin
        oled_data <= pullup_color;
      end
      else if( x >= 10 && x <=13 && y >= 39 && y <= 45 )begin 
          if(((num_pullup/10)%10) == 1 && digit1[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 2 && digit2[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 3 && digit3[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 4 && digit4[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 5 && digit5[y-39][x-10]) begin
          oled_data <= pullup_color;
          end   
          else if(((num_pullup/10)%10) == 6 && digit6[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 7 && digit7[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 8 && digit8[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 9 && digit9[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else if(((num_pullup/10)%10) == 0 && digit0[y-39][x-10]) begin
          oled_data <= pullup_color;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end    
          end
           
      else if( x >= 59 && x <=62 && y >= 39 && y <= 45 )begin 
          if((num_running%10) == 1 && digit1[y-39][x-59]) begin
              oled_data <=  running_color;
          end
          else if((num_running%10) == 2 && digit2[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else if((num_running%10) == 3 && digit3[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else if((num_running%10) == 4 && digit4[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else if((num_running%10) == 5 && digit5[y-39][x-59]) begin
          oled_data <= running_color;
          end   
          else if((num_running%10) == 6 && digit6[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else if((num_running%10) == 7 && digit7[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else if((num_running%10) == 8 && digit8[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else if((num_running%10) == 9 && digit9[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else if((num_running%10) == 0 && digit0[y-39][x-59]) begin
          oled_data <= running_color;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end  
          end 
          
      else if( x >= 54 && x <=57 && y >= 39 && y <= 45 )begin 
          if(((num_running/10)%10) == 1 && digit1[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 2 && digit2[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 3 && digit3[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 4 && digit4[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 5 && digit5[y-39][x-54]) begin
          oled_data <= running_color;
          end   
          else if(((num_running/10)%10) == 6 && digit6[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 7 && digit7[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 8 && digit8[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 9 && digit9[y-39][x-54]) begin
          oled_data <= running_color;
          end
          else if(((num_running/10)%10) == 0 && digit0[y-39][x-54]) begin
          oled_data <= running_color;
          end  
          else begin
          oled_data <= 16'b00000_000000_00000;
          end  
          end
          
     else if(y >= 52 && y <= 62 && random_color == 0 )begin
     oled_data <= 16'b00000_000000_00000;
     end
      

      else begin 
             oled_data <= pushup_up_pic;
          end
         end   
    end
    
end
endmodule

