`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2024 12:20:07
// Design Name: 
// Module Name: Workout_Planner
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


module Workout_Planner(input clk, input btnC,btnL,btnR,btnU,btnD,
                 input [1:0]sw, 
                 input [12:0] pixel_index,
                 input [7:0]x,input[6:0]y,
                 output reg [7:0]an0,output reg [7:0]an1,output reg [7:0]an2,output reg [7:0]an3,
                 output reg [15:0] oled_data 
    );
    wire [15:0]pushup_up_pic;
       BRAM_pushup_up(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pushup_up_pic));              
                     
                     
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
        
        
        reg[5:0] state =0;
        reg[10:0] xLeft;
        reg[10:0] xRight;
        reg[10:0] yUp;
        reg[10:0] yDown;
            
        reg[31:0] count = 0;
        reg[31:0] count1 = 0;
        reg[31:0] count2 = 0;
        reg[31:0] num_pushup = 0;    
        reg[31:0] num_situp = 0;
        reg[31:0] num_running = 0;
        reg[31:0] num_pullup = 0;
        reg[31:0] num_total;      
        initial begin    //assign array number values
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
        
        if(state == 0)begin
        xLeft <= 0;
        xRight <= 46;
        yUp <= 1;
        yDown <= 25;
        
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
        xLeft <= 48;
        xRight <= 95;
        yUp <= 1;
        yDown <= 25;
        
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
        xLeft <= 0;
        xRight <= 46;
        yUp <= 26;
        yDown <= 50;
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
    
        
        end
           
        else if (state == 3) begin
        xLeft <= 48;
        xRight <= 95;
        yUp <= 26;
        yDown <= 50;
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
        

        
        num_total <= 3*num_pushup + 15*num_situp + 15*num_running + 10*num_pullup;
        an3<= 8'b10111111;
        
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
        
                  
      if( x >= 15 && x <=18 && y >= 14 && y <= 20 )begin 
      
          if((num_pushup%10) == 1 && digit1[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if((num_pushup%10) == 2 && digit2[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pushup%10) == 3 && digit3[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pushup%10) == 4 && digit4[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pushup%10) == 5 && digit5[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if((num_pushup%10) == 6 && digit6[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pushup%10) == 7 && digit7[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pushup%10) == 8 && digit8[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pushup%10) == 9 && digit9[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pushup%10) == 0 && digit0[y-14][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end
          end    
      else if( x >= 10 && x <=13 && y >= 14 && y <= 20 )begin 
          if(((num_pushup/10)%10) == 1 && digit1[y-14][x-10]) begin
             oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 2 && digit2[y-14][x-10]) begin
             oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 3 && digit3[y-14][x-10]) begin
             oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 4 && digit4[y-14][x-10]) begin
             oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 5 && digit5[y-14][x-10]) begin
             oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 6 && digit6[y-14][x-10]) begin
              oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 7 && digit7[y-14][x-10]) begin
              oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 8 && digit8[y-14][x-10]) begin
              oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 9 && digit9[y-14][x-10]) begin
              oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pushup/10)%10) == 0 && digit0[y-14][x-10]) begin
              oled_data <= 16'b11111_111111_11111;
          end
          else begin
              oled_data <= 16'b00000_000000_00000;
          end
          end  
      else if( x >= 63 && x <=66 && y >= 14 && y <= 20 )begin 
          if((num_situp%10) == 1 && digit1[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 2 && digit2[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 3 && digit3[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 4 && digit4[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 5 && digit5[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if((num_situp%10) == 6 && digit6[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 7 && digit7[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 8 && digit8[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 9 && digit9[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_situp%10) == 0 && digit0[y-14][x-63]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end  
          end 
      else if( x >= 58 && x <=61 && y >= 14 && y <= 20)begin 
          if(((num_situp/10)%10) == 1 && digit1[y-14][x-58]) begin
              oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 2 && digit2[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 3 && digit3[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 4 && digit4[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 5 && digit5[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if(((num_situp/10)%10) == 6 && digit6[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 7 && digit7[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 8 && digit8[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 9 && digit9[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_situp/10)%10) == 0 && digit0[y-14][x-58]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else begin
          oled_data <= 16'b00000_000000_00000;
          end   
          end  
      else if( x >= 15 && x <=18 && y >= 39 && y <= 45)begin 
          if((num_pullup%10) == 1 && digit1[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 2 && digit2[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 3 && digit3[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 4 && digit4[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 5 && digit5[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if((num_pullup%10) == 6 && digit6[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 7 && digit7[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 8 && digit8[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 9 && digit9[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_pullup%10) == 0 && digit0[y-39][x-15]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end
          end 
      else if( x >= 10 && x <=13 && y >= 39 && y <= 45 )begin 
          if(((num_pullup/10)%10) == 1 && digit1[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 2 && digit2[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 3 && digit3[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 4 && digit4[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 5 && digit5[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if(((num_pullup/10)%10) == 6 && digit6[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 7 && digit7[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 8 && digit8[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 9 && digit9[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_pullup/10)%10) == 0 && digit0[y-39][x-10]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end    
          end
           
      else if( x >= 59 && x <=62 && y >= 39 && y <= 45 )begin 
          if((num_running%10) == 1 && digit1[y-39][x-59]) begin
              oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 2 && digit2[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 3 && digit3[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 4 && digit4[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 5 && digit5[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if((num_running%10) == 6 && digit6[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 7 && digit7[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 8 && digit8[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 9 && digit9[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if((num_running%10) == 0 && digit0[y-39][x-59]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else begin
          oled_data <= 16'b00000_000000_00000;
          end  
          end 
          
      else if( x >= 54 && x <=57 && y >= 39 && y <= 45 )begin 
          if(((num_running/10)%10) == 1 && digit1[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 2 && digit2[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 3 && digit3[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 4 && digit4[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 5 && digit5[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end   
          else if(((num_running/10)%10) == 6 && digit6[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 7 && digit7[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 8 && digit8[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 9 && digit9[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end
          else if(((num_running/10)%10) == 0 && digit0[y-39][x-54]) begin
          oled_data <= 16'b11111_111111_11111;
          end  
          else begin
          oled_data <= 16'b00000_000000_00000;
          end  
          end
      
      else if (xLeft <= x && x <= xRight && yUp <= y && y <= yDown && !((xLeft+1) <= x && x <= (xRight-1) && (yUp+1) <= y && y <= (yDown-1))) begin
      oled_data <= 16'b00000_111111_00000;
      end

      else begin 
             oled_data <= pushup_up_pic;
          end
         end   
    
    

endmodule


