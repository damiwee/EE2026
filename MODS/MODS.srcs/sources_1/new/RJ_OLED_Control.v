`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 15:48:25
// Design Name: 
// Module Name: RJ_OLED_Control
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


module RJ_OLED_Control(
    input clk,
    input [15:0]height_weight_pic,
    input [15:0]page2,
    input [7:0]X,
    input [6:0]Y,
    input [5:0] state,
    input [1:0] gender_confirm,
    input [1:0] page,
    input [3:0] age_1st_digit,
    input [3:0] age_2nd_digit,
    input [3:0] age_3rd_digit,
    input [3:0] height_1st_digit, 
    input [3:0] height_2nd_digit,
    input [3:0] height_3rd_digit,
    input [3:0] weight_1st_digit,
    input [3:0] weight_2nd_digit,
    input [3:0] weight_3rd_digit,
    input [3:0] wLOSS_1st_digit,
    input [3:0] wLOSS_2nd_digit, 
    input [3:0] Months_1st_digit,
    input [3:0] Months_2nd_digit, 
    output reg[15:0]oled_data,
    output reg[15:0]TDEE =0,
    output reg[15:0]deficit =0
    );
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
    
    reg [9:0] actual_height = 0;
    reg [9:0] actual_weight = 0;
    reg [9:0] actual_age = 0;
    reg [9:0] actual_WL = 0;
    reg [9:0] actual_months = 0;
    reg [9:0] BMI = 0;
    reg [1:0] BMI_control = 0;
    reg [1:0] deficit_control = 0;
    
    reg [15:0]BMI_colour = 16'b00000_000000_00000;
    reg [15:0]deficit_colour = 16'b00000_000000_00000;
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
    
    always @(posedge clk)
    begin
    actual_height <= ((height_1st_digit*100 + height_2nd_digit*10 +height_3rd_digit));
    actual_weight <= (weight_1st_digit*100+weight_2nd_digit*10+weight_3rd_digit);
    actual_age <= (age_1st_digit*100+age_2nd_digit*10+age_3rd_digit);
    actual_WL <= wLOSS_1st_digit*10+wLOSS_2nd_digit;
    actual_months <= Months_1st_digit*10 + Months_2nd_digit;
    BMI <= ((actual_weight*100000/(actual_height*actual_height))>999)?999:(actual_weight*100000/(actual_height*actual_height)); 
    
    if (actual_WL == 0 || actual_months == 0) begin
        deficit <= 0;
    end else begin
        deficit <= ((actual_WL*7000)/(30*actual_months) > 9999) ? 9999 : (actual_WL*7000)/(30*actual_months);
    end
    
    
    //deficit <= ((actual_WL*7000)/(30*actual_months) > 9999) ? 9999 : (actual_WL*7000)/(30*actual_months);
    
    ///////////////////////////BMI & deficit control
    if (state==11)begin
        BMI_control <=1;
        end
    if (state==16)begin
        deficit_control<=1;
        end    
    ////////////////////////////////BMI colour
    if (BMI<185)begin
        BMI_colour<=16'b00000_110011_11111;end //underweight
    else if (BMI>=185 && BMI<= 229)begin
        BMI_colour<=16'b00000_111111_00000;end //healthy
    else if (BMI>=230 && BMI<= 249)begin
        BMI_colour<=16'b11111_111100_00000;end //risk to overweight
    else if (BMI>=250 && BMI<= 299)begin
        BMI_colour<=16'b11111_100110_00000;end //overweight
    else if (BMI>=300)begin
        BMI_colour<=16'b11111_001111_00111;end //obese    
    ///////////////////////////////
    if (deficit<=500)begin
        deficit_colour<=16'b00000_111111_00000;end //ok
    else if (deficit>501 && deficit<= 800)begin
        deficit_colour<=16'b11111_111100_00000;end //ok
    else if (deficit>801)begin
        deficit_colour<=16'b11111_000000_00000;end //too much
        
                                          
    ///////////////////////////////
    if (actual_weight==0||actual_height==0||actual_age==0) begin
         TDEE <= 0;
         end
    else if (gender_confirm == 1)begin
         TDEE <= ((((10* actual_weight)+(25*actual_height/4)- (5*actual_age)+5)*155/100)>9999)? 9999:(((10* actual_weight)+(25*actual_height/4)- (5*actual_age)+5)*155/100);end
    else if (gender_confirm ==2)begin 
         TDEE <=((((10* actual_weight)+(25*actual_height/4)- (5*actual_age)-161)*155/100)>9999)? 9999:(((10* actual_weight)+(25*actual_height/4)- (5*actual_age)-161)*155/100);end
    else begin
         TDEE <=0;end   
    //////////////////////////////
    if (page ==1)begin
    ////////////////age 1st digit
    if (X>=47&& X<=50 && Y>=3 && Y<=9)begin
       if(age_1st_digit == 1 && digit1[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(age_1st_digit == 2 && digit2[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_1st_digit == 3 && digit3[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_1st_digit == 4 && digit4[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_1st_digit == 5 && digit5[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(age_1st_digit == 6 && digit6[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_1st_digit == 7 && digit7[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_1st_digit == 8 && digit8[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_1st_digit == 9 && digit9[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_1st_digit == 0 && digit0[Y-3][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end   
    ///////////////age 2nd digit
    else if (X>=52&& X<=55 && Y>=3 && Y<=9)begin
       if(age_2nd_digit == 1 && digit1[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(age_2nd_digit == 2 && digit2[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_2nd_digit == 3 && digit3[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_2nd_digit == 4 && digit4[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_2nd_digit == 5 && digit5[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(age_2nd_digit == 6 && digit6[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_2nd_digit == 7 && digit7[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_2nd_digit == 8 && digit8[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_2nd_digit == 9 && digit9[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_2nd_digit == 0 && digit0[Y-3][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end   
    ///////////////////age 3rd digit
    else if (X>=57&& X<=60 && Y>=3 && Y<=9)begin
       if(age_3rd_digit == 1 && digit1[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(age_3rd_digit == 2 && digit2[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_3rd_digit == 3 && digit3[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_3rd_digit == 4 && digit4[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_3rd_digit == 5 && digit5[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(age_3rd_digit == 6 && digit6[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_3rd_digit == 7 && digit7[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_3rd_digit == 8 && digit8[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_3rd_digit == 9 && digit9[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(age_3rd_digit == 0 && digit0[Y-3][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end 
    //////height 1st digit
    else if (X>=47&& X<=50 && Y>=27 && Y<=33)begin
       if(height_1st_digit == 1 && digit1[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(height_1st_digit == 2 && digit2[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_1st_digit == 3 && digit3[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_1st_digit == 4 && digit4[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_1st_digit == 5 && digit5[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(height_1st_digit == 6 && digit6[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_1st_digit == 7 && digit7[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_1st_digit == 8 && digit8[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_1st_digit == 9 && digit9[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_1st_digit == 0 && digit0[Y-27][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end    
    ////////height 2nd digit   
    else if (X>=52 && X<=55 && Y>=27 && Y<=33)begin
       if(height_2nd_digit == 1 && digit1[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(height_2nd_digit == 2 && digit2[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_2nd_digit == 3 && digit3[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_2nd_digit == 4 && digit4[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_2nd_digit == 5 && digit5[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(height_2nd_digit== 6 && digit6[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_2nd_digit == 7 && digit7[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_2nd_digit == 8 && digit8[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_2nd_digit == 9 && digit9[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_2nd_digit == 0 && digit0[Y-27][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end 
    ////////////////////height 3rd digit
    else if (X>=57 && X<=60 && Y>=27 && Y<=33)begin
       if(height_3rd_digit == 1 && digit1[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(height_3rd_digit == 2 && digit2[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_3rd_digit == 3 && digit3[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_3rd_digit == 4 && digit4[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_3rd_digit == 5 && digit5[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(height_3rd_digit== 6 && digit6[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_3rd_digit == 7 && digit7[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_3rd_digit == 8 && digit8[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_3rd_digit == 9 && digit9[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(height_3rd_digit == 0 && digit0[Y-27][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end
    
    ////////////////////////////////////////// weight 1st digit
    else if (X>=47 && X<=50 && Y>=39 && Y<=45)begin
       if(weight_1st_digit == 1 && digit1[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(weight_1st_digit == 2 && digit2[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_1st_digit == 3 && digit3[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_1st_digit == 4 && digit4[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_1st_digit == 5 && digit5[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(weight_1st_digit== 6 && digit6[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_1st_digit == 7 && digit7[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_1st_digit == 8 && digit8[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_1st_digit == 9 && digit9[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_1st_digit == 0 && digit0[Y-39][X-47]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end    
    ////////weight 2nd digit   
    else if (X>=52 && X<=55 && Y>=39 && Y<=45)begin
       if(weight_2nd_digit == 1 && digit1[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(weight_2nd_digit == 2 && digit2[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_2nd_digit == 3 && digit3[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_2nd_digit == 4 && digit4[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_2nd_digit == 5 && digit5[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(weight_2nd_digit== 6 && digit6[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_2nd_digit == 7 && digit7[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_2nd_digit == 8 && digit8[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_2nd_digit == 9 && digit9[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_2nd_digit == 0 && digit0[Y-39][X-52]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end 
    ////////////////////weight 3rd digit
    else if (X>=57 && X<=60 && Y>=39 && Y<=45)begin
       if(weight_3rd_digit == 1 && digit1[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(weight_3rd_digit == 2 && digit2[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_3rd_digit == 3 && digit3[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_3rd_digit == 4 && digit4[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_3rd_digit == 5 && digit5[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(weight_3rd_digit== 6 && digit6[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_3rd_digit == 7 && digit7[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_3rd_digit == 8 && digit8[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_3rd_digit == 9 && digit9[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(weight_3rd_digit == 0 && digit0[Y-39][X-57]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end
    //////////////////BMI 1st
    else if (X>=47 && X<=50 && Y>=53 && Y<=59)begin
       
       if (BMI_control ==0||actual_weight ==0||actual_height==0)begin
          if(digit0[Y-53][X-47])begin
            oled_data <= 16'b00000_000000_00000;end
       end
       else if (BMI_control ==1)begin
       if((((BMI/100)%10)==1) && digit1[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end   
       else if((((BMI/100)%10)==2) && digit2[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/100)%10)==3) && digit3[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/100)%10)==4) && digit4[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/100)%10)==5) && digit5[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end   
       else if((((BMI/100)%10)==6) && digit6[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/100)%10)==7) && digit7[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/100)%10)==8) && digit8[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/100)%10)==9) && digit9[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/100)%10)==0) && digit0[Y-53][X-47]) begin
       oled_data <= BMI_colour;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
       end //if BMI control ==1
    end
    ///////////////////BMI 2nd
    else if (X>=52 && X<=55 && Y>=53 && Y<=59)begin
       if (BMI_control ==0 ||actual_weight ==0||actual_height==0)begin
              if(digit0[Y-53][X-52])begin
              oled_data <= 16'b00000_000000_00000;end
       end
       else if (BMI_control ==1)begin
       if((((BMI/10)%10)==1) && digit1[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end   
       else if((((BMI/10)%10)==2) && digit2[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/10)%10)==3) && digit3[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/10)%10)==4) && digit4[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/10)%10)==5) && digit5[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end   
       else if((((BMI/10)%10)==6) && digit6[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/10)%10)==7) && digit7[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/10)%10)==8) && digit8[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/10)%10)==9) && digit9[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else if((((BMI/10)%10)==0) && digit0[Y-53][X-52]) begin
       oled_data <= BMI_colour;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
       end//BMI_control==1
     end
     //////////////BMI d.p
    else if (X==57 && Y==59)begin
        if (BMI_control ==0||actual_weight ==0||actual_height==0)begin
        oled_data <= 16'b00000_000000_00000;end
        else if (BMI_control ==1)begin
        oled_data<= BMI_colour;end
        end 
     ////////////////BMI 3rd
    else if (X>=59 && X<=62 && Y>=53 && Y<=59)begin
        if (BMI_control ==0||actual_weight ==0||actual_height==0)begin
              if(digit0[Y-53][X-52])begin
              oled_data <= 16'b00000_000000_00000;end
        end
        else if (BMI_control ==1)begin
        if(((BMI%10)==1) && digit1[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end   
        else if(((BMI%10)==2) && digit2[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else if(((BMI%10)==3) && digit3[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else if(((BMI%10)==4) && digit4[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else if(((BMI%10)==5) && digit5[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end   
        else if(((BMI%10)==6) && digit6[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else if(((BMI%10)==7) && digit7[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else if(((BMI%10)==8) && digit8[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else if(((BMI%10)==9) && digit9[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else if(((BMI%10)==0) && digit0[Y-53][X-59]) begin
        oled_data <= BMI_colour;
        end
        else begin
        oled_data <= 16'b00000_000000_00000;
        end
        end //BMI control ==1
      end   
      
    ////////////////////
    //////////////////orange underlines 
    else if (X>=47 && X<=50 && Y==11)begin
    if (state==1)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=52 && X<=55 && Y==11)begin
    if (state==2)begin
    oled_data <= 16'b11111_100110_00000;end
    end   
    else if (X>=57 && X<=60 && Y==11)begin
    if (state==3)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=50 && X<=54 && Y==22)begin
    if (state==4)begin 
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=71 && X<=75 && Y==22)begin
    if (state==5)begin 
    oled_data <= 16'b11111_100110_00000;end
    end    
    else if (X>=47 && X<=50 && Y==35)begin
    if (state==6)begin 
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=52 && X<=55 && Y==35)begin
    if (state==7)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=57 && X<=60 && Y==35)begin
    if (state==8)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=47 && X<=50 && Y==47)begin
    if (state==9)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=52 && X<=55 && Y==47)begin
    if (state==10)begin 
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=57 && X<=60 && Y==47)begin
    if (state==11)begin
    oled_data <= 16'b11111_100110_00000;end
    end 
    else if (X>=81 && X<=93 && Y==61)begin
    if (state==12)begin
    oled_data <= 16'b11111_100110_00000;end
    end         
    ////////////////gender
    else if ((X==50 && Y>=16 && Y<=20)||(X==51 && Y==17)||(X==52 && Y==18)
    ||(X==53&&Y==17)||(X==54 && Y >=16 && Y <=20))begin
            if (gender_confirm ==2)begin
                 oled_data <= 16'b00000_000000_00000;
                 end 
            else begin
            oled_data <= 16'b00110_010110_11011;end
    end
    
    else if ((X==71 && Y>=16 && Y<=20)||(X>=71 && X<=74 && Y==16)||
       (X>=71 && X<=73 && Y==18))begin
             if (gender_confirm ==1)begin
                   oled_data <= 16'b00000_000000_00000;
                   end 
              else begin 
                  oled_data <= 16'b11111_000100_11000;end
    end        
    else if ((X==62&&Y==20)||(X==63&&Y==18)||(X==63&&Y==19)||
           (X==64&&Y==17)||(X==65&&Y==16))begin
           if (gender_confirm >=1)begin
             oled_data <= 16'b00000_000000_00000;
             end 
           else begin  
             oled_data <= 16'b11111_11111_11111;end
    end 
    ///////////////////arrow
    else if((X==87&&Y>=48&&Y<=58)||(X>=82&& X<=90 && Y>=51 && Y<=55)||(X==88&&Y>=49&&Y<=57)||
         (X==89&&Y>=50&&Y<=56)||(X==90&&Y>=51&&Y<=55)||(X==91&&Y>=52&&Y<=54)||(X==92&&Y==53))begin
               oled_data <=16'b11110_100111_01010;
               end
    ////////////////
    else begin
    oled_data <= height_weight_pic;end
    end //end of 1st page
    ///////////////////////////////////////////
    else if (page ==2)begin
    //////////////////////////////weight lost 1st digit
    if (X>=49&& X<=52 && Y>=14 && Y<=20)begin
       if(wLOSS_1st_digit == 1 && digit1[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(wLOSS_1st_digit == 2 && digit2[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_1st_digit == 3 && digit3[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_1st_digit == 4 && digit4[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_1st_digit == 5 && digit5[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(wLOSS_1st_digit == 6 && digit6[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_1st_digit == 7 && digit7[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_1st_digit == 8 && digit8[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_1st_digit == 9 && digit9[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_1st_digit == 0 && digit0[Y-14][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end   
    //////////////////////////////weight loss 2nd digit
    else if (X>=54&& X<=57 && Y>=14 && Y<=20)begin
       if(wLOSS_2nd_digit == 1 && digit1[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(wLOSS_2nd_digit == 2 && digit2[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_2nd_digit == 3 && digit3[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_2nd_digit == 4 && digit4[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_2nd_digit == 5 && digit5[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(wLOSS_2nd_digit == 6 && digit6[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_2nd_digit == 7 && digit7[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_2nd_digit == 8 && digit8[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_2nd_digit == 9 && digit9[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(wLOSS_2nd_digit == 0 && digit0[Y-14][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end 
    ////////////////////////////////////months 1st digit
    else if (X>=49&& X<=52 && Y>=30 && Y<=36)begin
       if(Months_1st_digit == 1 && digit1[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(Months_1st_digit == 2 && digit2[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_1st_digit == 3 && digit3[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_1st_digit == 4 && digit4[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_1st_digit == 5 && digit5[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(Months_1st_digit == 6 && digit6[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_1st_digit == 7 && digit7[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_1st_digit == 8 && digit8[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_1st_digit == 9 && digit9[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_1st_digit == 0 && digit0[Y-30][X-49]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end   
    //////////////////////////////months_2nd_digit
    else if (X>=54&& X<=57 && Y>=30 && Y<=36)begin
       if(Months_2nd_digit == 1 && digit1[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(Months_2nd_digit == 2 && digit2[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_2nd_digit == 3 && digit3[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_2nd_digit == 4 && digit4[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_2nd_digit == 5 && digit5[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end   
       else if(Months_2nd_digit == 6 && digit6[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_2nd_digit == 7 && digit7[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_2nd_digit == 8 && digit8[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_2nd_digit == 9 && digit9[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else if(Months_2nd_digit == 0 && digit0[Y-30][X-54]) begin
       oled_data <= 16'b11111_111111_11111;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
    end 
    //////////////////////////////deficit 1st
    else if (X>=61 && X<=64 && Y>=46 && Y<=52)begin
       if (deficit_control ==0||actual_months==0||actual_WL==0 )begin 
            if (digit0[Y-46][X-61])begin
            oled_data <= 16'b00000_000000_00000;end
       end
       else if (deficit_control ==1)begin
                
       if((((deficit/1000)%10)==1) && digit1[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end   
       else if((((deficit/1000)%10)==2) && digit2[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else if((((deficit/1000)%10)==3) && digit3[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else if((((deficit/1000)%10)==4) && digit4[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else if((((deficit/1000)%10)==5) && digit5[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end   
       else if((((deficit/1000)%10)==6) && digit6[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else if((((deficit/1000)%10)==7) && digit7[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else if((((deficit/1000)%10)==8) && digit8[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else if((((deficit/1000)%10)==9) && digit9[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else if((((deficit/1000)%10)==0) && digit0[Y-46][X-61]) begin
       oled_data <= deficit_colour;
       end
       else begin
       oled_data <= 16'b00000_000000_00000;
       end
     
       end//if deficit_control ==1
    end
    /////////////////deficit 2nd
    else if (X>=66 && X<=69 && Y>=46 && Y<=52)begin
      if (deficit_control ==0||actual_months==0||actual_WL==0 )begin 
            if (digit0[Y-46][X-66])begin
            oled_data <= 16'b00000_000000_00000;end
      end
      else if (deficit_control ==1)begin
      
      if((((deficit/100)%10)==1) && digit1[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end   
      else if((((deficit/100)%10)==2) && digit2[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/100)%10)==3) && digit3[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/100)%10)==4) && digit4[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/100)%10)==5) && digit5[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end   
      else if((((deficit/100)%10)==6) && digit6[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/100)%10)==7) && digit7[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/100)%10)==8) && digit8[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/100)%10)==9) && digit9[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/100)%10)==0) && digit0[Y-46][X-66]) begin
      oled_data <= deficit_colour;
      end
      else begin
      oled_data <= 16'b00000_000000_00000;
      end
      
      end//if deficit control ==1
    end
    /////////////////deficit 3rd
    else if (X>=71 && X<=74 && Y>=46 && Y<=52)begin
    
      if (deficit_control ==0||actual_months==0||actual_WL==0 )begin 
                if (digit0[Y-46][X-71])begin
                oled_data <= 16'b00000_000000_00000;end
      end
      else if (deficit_control ==1)begin
      
      if((((deficit/10)%10)==1) && digit1[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end   
      else if((((deficit/10)%10)==2) && digit2[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/10)%10)==3) && digit3[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/10)%10)==4) && digit4[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/10)%10)==5) && digit5[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end   
      else if((((deficit/10)%10)==6) && digit6[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/10)%10)==7) && digit7[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/10)%10)==8) && digit8[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/10)%10)==9) && digit9[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else if((((deficit/10)%10)==0) && digit0[Y-46][X-71]) begin
      oled_data <= deficit_colour;
      end
      else begin
      oled_data <= 16'b00000_000000_00000;
      end
      
      end //deficit_control ==1
    end
    /////////////////deficit 4th digit
    else if (X>=76 && X<=79 && Y>=46 && Y<=52)begin
   
      if (deficit_control ==0 ||actual_months==0||actual_WL==0)begin 
                if (digit0[Y-46][X-79])begin
                oled_data <= 16'b00000_000000_00000;end
      end
      else if (deficit_control ==1)begin
      
      if(((deficit%10)==1) && digit1[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end   
      else if(((deficit%10)==2) && digit2[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else if(((deficit%10)==3) && digit3[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else if(((deficit%10)==4) && digit4[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else if(((deficit%10)==5) && digit5[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end   
      else if(((deficit%10)==6) && digit6[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else if(((deficit%10)==7) && digit7[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else if(((deficit%10)==8) && digit8[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else if(((deficit%10)==9) && digit9[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else if(((deficit%10)==0) && digit0[Y-46][X-76]) begin
      oled_data <= deficit_colour;
      end
      else begin
      oled_data <= 16'b00000_000000_00000;
      end
      
      end //deficit_control ==1
    end
    ////////////////orange underlines
    else if (X>=49 && X<=52 && Y==22)begin
    if (state==13)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=54 && X<=57 && Y==22)begin
    if (state==14)begin
    oled_data <= 16'b11111_100110_00000;end
    end  
    else if (X>=49 && X<=52 && Y==38)begin
    if (state==15)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=54 && X<=57 && Y==38)begin
    if (state==16)begin
    oled_data <= 16'b11111_100110_00000;end
    end
    else if (X>=89 && X<=94 && Y==57)begin
    if (state==17)begin
    oled_data <= 16'b11111_100110_00000;end
    end  
    ////////////////////arrow
    else if((X==91&&Y>=49&&Y<=55)||(X>=89&& X<=93 && Y>=51 && Y<=53)||(X==92&&Y>=50&&Y<=54)||
       (X==94&&Y==52))begin
       oled_data <=16'b11110_100111_01010;
       end 
    //////////////////// 
    else begin
        oled_data <= page2;end 
    end//end of 2nd page
    /////////////////////
    end//always begin
   
endmodule
   
