`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 15:48:25
// Design Name: 
// Module Name: RJ_menu
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


module RJ_menu(
    input clk_6p25m,
    input [7:0]control,
    input [15:0]sw,
    input btnC,btnL,btnR,
    output reg[7:0]seg=8'b11111111,
    output reg[3:0]an,
    output reg [5:0] state = 0,
    output reg [1:0] gender_confirm = 0,
    output reg [3:0] age_1st_digit = 0, 
    output reg [3:0] age_2nd_digit = 0,
    output reg [3:0] age_3rd_digit = 0,
    output reg [3:0] height_1st_digit = 0,
    output reg [3:0] height_2nd_digit = 0,
    output reg [3:0] height_3rd_digit = 0,
    output reg [3:0] weight_1st_digit = 0,
    output reg [3:0] weight_2nd_digit = 0,
    output reg [3:0] weight_3rd_digit = 0, 
    output reg [3:0] wLOSS_1st_digit = 0,
    output reg [3:0] wLOSS_2nd_digit = 0,
    output reg [3:0] Months_1st_digit = 0,
    output reg [3:0] Months_2nd_digit = 0,
    output reg [1:0] page=1, 
    output reg RJ_control
    );
    reg [3:0] an_switch;
    reg [63:0] an_count =0;
  
    reg [3:0] mode = 0 ; //age,gender,height,weight, next
    reg [63:0] debouncer_L =0;
    reg [63:0] debouncer_R =0;
    reg [63:0] debouncer_C =0;
    reg [63:0] debouncer_C2 =0;
    
    reg [7:0]anode1_age = 8'b11000000;
    reg [7:0]anode2_age = 8'b11000000;
    reg [7:0]anode3_age = 8'b11000000;
    
    reg [7:0]anode1_H = 8'b11000000;
    reg [7:0]anode2_H = 8'b11000000;
    reg [7:0]anode3_H = 8'b11000000;
    
    reg [7:0]anode1_W = 8'b11000000;
    reg [7:0]anode2_W = 8'b11000000;
    reg [7:0]anode3_W = 8'b11000000;
    
    
    reg [7:0]anode2_WL = 8'b11000000;
    reg [7:0]anode3_WL = 8'b11000000;
    
    reg [7:0]anode2_months = 8'b11000000;
    reg [7:0]anode3_months = 8'b11000000;
    
    always @ (posedge clk_6p25m)
    begin 
    RJ_control <= 0;
    //////////////////////////
    if (control ==3)begin
    ////////////////////////
    an_count <= an_count + 1;
    
    ////////////////////////
    if (state>=1 &&state<=3)begin 
       mode <=1;end  //age
    else if (state>=4 &&state<=5)begin
       mode <=2;end //gender
    else if (state>=6 &&state<=8)begin
       mode <=3;end //height
    else if (state>=9 &&state<=11)begin
       mode <=4;end //weight
    else if (state ==12)begin
       page<=1;
       mode <=5;end//arrow button
    else if (state>=13 && state<=14)begin //weight to lose
       page<=2;
       mode<=6;end
    else if (state>=15 && state<=16)begin //months
       mode<=7;end 
    else if (state==17)begin //last arrow
       mode<=8;end                          
    ///////////////////////
    
    if (btnR)begin
         debouncer_R <= debouncer_R +1;
    end
    else if (btnR ==0 && debouncer_R > 100000)begin
         debouncer_R <=0;
         if (state==17)begin
              RJ_control<=1;
              state <= 14;
              end
         else if (state ==4)begin
               if(gender_confirm ==1)begin
                  state<=6;
                  end
               else begin
                  state<=state+1;end
         end
         
         else if (state ==3)begin
              if(gender_confirm ==2)begin
                 state<=5;
                  end
              else begin
                 state<=state+1;end    
         end       
         else begin
         state <= state+1;end
                 
    end          
    else begin
         debouncer_R <=0;end    
    
    if (btnL)begin
        debouncer_L<= debouncer_L +1;
        end
    else if (btnL ==0 && debouncer_L >100000)begin
        debouncer_L <=0;
        if (state ==0)begin
           state<=0;end 
        else if (state ==5)begin
           if(gender_confirm ==2)begin
              state<=3;
           end
           else begin
             state<=state-1;end
        end 
        else if (state ==6)begin
           if(gender_confirm ==1)begin
              state<=4;
           end
           else begin
             state<=state-1;end
        end 
        else begin
        state <= state-1;end   
              

    end             
       
    else begin
        debouncer_L <= 0;
    end
                           
    ////////////////////////an_switching
    if (an_switch ==0)begin
    an[3:0] <= 4'b0111;
    if (mode ==3)begin
    seg <=anode3_H;end
    else if (mode==4)begin
    seg<=anode3_W;end
    else if (mode==1)begin
    seg<=anode3_age;end
    else if (mode==6)begin
    seg<=8'b11111111;end
    else if (mode==7)begin
    seg<=8'b11111111;end
    else if (mode ==0)begin
    seg <= 8'b11111111;end
    if (an_count > 10000)begin
    an_count <= 0;
    an_switch <= 1;
    end
    end
    else if (an_switch ==1) begin
    an[3:0] <= 4'b1011;
    if (mode ==3)begin
    seg <=anode2_H;end
    else if (mode==4)begin
    seg<=anode2_W;end
    else if (mode==1)begin
    seg<=anode2_age;end
    else if (mode==6)begin
    seg<=anode3_WL;end
    else if (mode==7)begin
    seg<=anode3_months;end
    else if (mode ==0)begin
    seg <= 8'b11111111;end
    if (an_count > 10000)begin
    an_count <= 0;
    an_switch <= 2;
    end        
    end
    else if (an_switch ==2) begin
    an[3:0] <= 4'b1101;
    if (mode ==3)begin
    seg <=anode1_H;end
    else if (mode==4)begin
    seg<=anode1_W;end
    else if (mode==1)begin
    seg<=anode1_age;end
    else if (mode==6)begin
    seg<=anode2_WL;end
    else if (mode==7)begin
    seg<=anode2_months;end
    else if (mode ==0)begin
    seg <= 8'b11111111;end
    if (an_count > 10000)begin
    an_count <= 0;
    an_switch <= 3;
    end        
    end
    else if (an_switch == 3) begin
    an[3:0] <= 4'b1110;
    seg <= 8'b11111111;
    if (an_count > 10000)begin
    an_count <= 0;
    an_switch <= 0;
    end        
    end
    //////////////////////////////
    if (state ==1)begin
    if (sw[0]==1) begin
    anode3_age <= 8'b11000000;
    age_1st_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode3_age <= 8'b11111001;
    age_1st_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode3_age <= 8'b10100100;
    age_1st_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode3_age <= 8'b10110000;
    age_1st_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode3_age <= 8'b10011001; 
    age_1st_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode3_age <= 8'b10010010;  
    age_1st_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode3_age <= 8'b10000010;
    age_1st_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode3_age <= 8'b11111000;
    age_1st_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode3_age <= 8'b10000000;
    age_1st_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode3_age <= 8'b10011000;
    age_1st_digit <= 9;                
    end
    else begin
    anode3_age <= anode3_age;
    age_1st_digit <= age_1st_digit;
    end
    
    end //state ==1
    //////////////////////////////
    else if (state ==2)begin
    if (sw[0]==1) begin
    anode2_age <= 8'b11000000;
    age_2nd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode2_age <= 8'b11111001;
    age_2nd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode2_age <= 8'b10100100;
    age_2nd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode2_age <= 8'b10110000;
    age_2nd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode2_age <= 8'b10011001; 
    age_2nd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode2_age <= 8'b10010010;  
    age_2nd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode2_age <= 8'b10000010;
    age_2nd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode2_age <= 8'b11111000;
    age_2nd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode2_age <= 8'b10000000;
    age_2nd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode2_age <= 8'b10011000;
    age_2nd_digit <= 9;                
    end
    else begin
    anode2_age <= anode2_age;
    age_2nd_digit <= age_2nd_digit;
    end
    
    end //state ==2
    /////////////////////////////
    else if (state ==3&&control ==3)begin
    if (sw[0]==1) begin
    anode1_age <= 8'b11000000;
    age_3rd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode1_age <= 8'b11111001;
    age_3rd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode1_age <= 8'b10100100;
    age_3rd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode1_age <= 8'b10110000;
    age_3rd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode1_age <= 8'b10011001; 
    age_3rd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode1_age <= 8'b10010010;  
    age_3rd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode1_age <= 8'b10000010;
    age_3rd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode1_age <= 8'b11111000;
    age_3rd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode1_age <= 8'b10000000;
    age_3rd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode1_age <= 8'b10011000;
    age_3rd_digit <= 9;                
    end
    else begin
    anode1_age <= anode1_age;
    age_3rd_digit <= age_3rd_digit;
    end
    
    end //state ==3
    /////////////////////////////
    else if (state==4)begin///MALE
    if (btnC)begin
             debouncer_C <= debouncer_C +1;
    end
    else if (btnC ==0 && debouncer_C > 100000)begin
            debouncer_C <=0;
            if (gender_confirm ==0)begin
                gender_confirm <= 1;end
            else if (gender_confirm ==1)begin
                 gender_confirm <=0;end
            end
    else begin
            debouncer_C <=0;end    
    end//state==4
    //////////////////////////
    else if (state==5)begin///FEMALE
    if (btnC)begin
         debouncer_C2 <= debouncer_C2 +1;
    end
    else if (btnC ==0 && debouncer_C2 > 100000)begin
         debouncer_C2 <=0;
         if (gender_confirm ==0)begin
                 gender_confirm <= 2;end
          else if (gender_confirm ==2)begin
                 gender_confirm <=0;end
    end
    else begin
          debouncer_C <=0;end    
    end//state==5
    //////////////////////////////
    else if (state ==6)begin
    if (sw[0]==1) begin
    anode3_H <= 8'b11000000;
    height_1st_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode3_H <= 8'b11111001;
    height_1st_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode3_H <= 8'b10100100;
    height_1st_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode3_H <= 8'b10110000;
    height_1st_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode3_H <= 8'b10011001; 
    height_1st_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode3_H <= 8'b10010010;  
    height_1st_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode3_H <= 8'b10000010;
    height_1st_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode3_H <= 8'b11111000;
    height_1st_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode3_H <= 8'b10000000;
    height_1st_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode3_H <= 8'b10011000;
    height_1st_digit <= 9;                
    end
    else begin
    anode3_H <= anode3_H;
    height_1st_digit <= height_1st_digit;
    end
    
    end //state ==6
    /////////////////////////////
    else if (state ==7)begin
    if (sw[0]==1) begin
    anode2_H <= 8'b11000000;
    height_2nd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode2_H <= 8'b11111001;
    height_2nd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode2_H <= 8'b10100100;
    height_2nd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode2_H <= 8'b10110000;
    height_2nd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode2_H <= 8'b10011001; 
    height_2nd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode2_H <= 8'b10010010;  
    height_2nd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode2_H <= 8'b10000010;
    height_2nd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode2_H <= 8'b11111000;
    height_2nd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode2_H <= 8'b10000000;
    height_2nd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode2_H <= 8'b10011000;
    height_2nd_digit <= 9;                
    end
    else begin
    anode2_H <= anode2_H;
    height_2nd_digit <= height_2nd_digit;
    end
    end //state==7
    ///////////////////////////
    else if (state ==8)begin
    if (sw[0]==1) begin
    anode1_H <= 8'b11000000;
    height_3rd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode1_H <= 8'b11111001;
    height_3rd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode1_H <= 8'b10100100;
    height_3rd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode1_H <= 8'b10110000;
    height_3rd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode1_H <= 8'b10011001; 
    height_3rd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode1_H <= 8'b10010010;  
    height_3rd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode1_H <= 8'b10000010;
    height_3rd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode1_H <= 8'b11111000;
    height_3rd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode1_H <= 8'b10000000;
    height_3rd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode1_H <= 8'b10011000;
    height_3rd_digit <= 9;                
    end
    else begin
    anode1_H <= anode1_H;
    height_3rd_digit <= height_3rd_digit;
    end
    end //state ==8
    //////////////////////////
    else if (state ==9)begin
    if (sw[0]==1) begin
    anode3_W <= 8'b11000000;
    weight_1st_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode3_W <= 8'b11111001;
    weight_1st_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode3_W <= 8'b10100100;
    weight_1st_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode3_W <= 8'b10110000;
    weight_1st_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode3_W <= 8'b10011001; 
    weight_1st_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode3_W <= 8'b10010010;  
    weight_1st_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode3_W <= 8'b10000010;
    weight_1st_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode3_W <= 8'b11111000;
    weight_1st_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode3_W <= 8'b10000000;
    weight_1st_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode3_W <= 8'b10011000;
    weight_1st_digit <= 9;                
    end
    else begin
    anode3_W <= anode3_W;
    weight_1st_digit <= weight_1st_digit;
    end
    end // state ==9
    ///////////////////////
    else if (state == 10)begin
    if (sw[0]==1) begin
    anode2_W <= 8'b11000000;
    weight_2nd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode2_W <= 8'b11111001;
    weight_2nd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode2_W <= 8'b10100100;
    weight_2nd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode2_W <= 8'b10110000;
    weight_2nd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode2_W <= 8'b10011001; 
    weight_2nd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode2_W <= 8'b10010010;  
    weight_2nd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode2_W <= 8'b10000010;
    weight_2nd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode2_W <= 8'b11111000;
    weight_2nd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode2_W <= 8'b10000000;
    weight_2nd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode2_W <= 8'b10011000;
    weight_2nd_digit <= 9;                
    end
    else begin
    anode2_W <= anode2_W;
    weight_2nd_digit <= weight_2nd_digit;
    end
    end //state ==10

    //////////////////////
    else if (state ==11)begin
    if (sw[0]==1) begin
    anode1_W <= 8'b11000000;
    weight_3rd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode1_W <= 8'b11111001;
    weight_3rd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode1_W <= 8'b10100100;
    weight_3rd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode1_W <= 8'b10110000;
    weight_3rd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode1_W <= 8'b10011001; 
    weight_3rd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode1_W <= 8'b10010010;  
    weight_3rd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode1_W <= 8'b10000010;
    weight_3rd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode1_W <= 8'b11111000;
    weight_3rd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode1_W <= 8'b10000000;
    weight_3rd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode1_W <= 8'b10011000;
    weight_3rd_digit <= 9;                
    end
    else begin
    anode1_W <= anode1_W;
    weight_3rd_digit <= weight_3rd_digit;
    end
    end//state <=11
  
    //////////////////////weight loss
    else if (state ==13)begin
    if (sw[0]==1) begin
    anode3_WL <= 8'b11000000;
    wLOSS_1st_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode3_WL <= 8'b11111001;
    wLOSS_1st_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode3_WL <= 8'b10100100;
    wLOSS_1st_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode3_WL <= 8'b10110000;
    wLOSS_1st_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode3_WL <= 8'b10011001; 
    wLOSS_1st_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode3_WL <= 8'b10010010;  
    wLOSS_1st_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode3_WL <= 8'b10000010;
    wLOSS_1st_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode3_WL <= 8'b11111000;
    wLOSS_1st_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode3_WL <= 8'b10000000;
    wLOSS_1st_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode3_WL <= 8'b10011000;
    wLOSS_1st_digit <= 9;                
    end
    else begin
    anode3_WL <= anode3_WL;
    wLOSS_1st_digit <= wLOSS_1st_digit;
    end
    
    end //state ==13
    ////////////////////
    else if (state ==14)begin
    if (sw[0]==1) begin
    anode2_WL <= 8'b11000000;
    wLOSS_2nd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode2_WL <= 8'b11111001;
    wLOSS_2nd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode2_WL <= 8'b10100100;
    wLOSS_2nd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode2_WL <= 8'b10110000;
    wLOSS_2nd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode2_WL <= 8'b10011001; 
    wLOSS_2nd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode2_WL <= 8'b10010010;  
    wLOSS_2nd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode2_WL <= 8'b10000010;
    wLOSS_2nd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode2_WL <= 8'b11111000;
    wLOSS_2nd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode2_WL <= 8'b10000000;
    wLOSS_2nd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode2_WL <= 8'b10011000;
    wLOSS_2nd_digit <= 9;                
    end
    else begin
    anode2_WL <= anode2_WL;
    wLOSS_2nd_digit <= wLOSS_2nd_digit;
    end
    
    end //state ==14
    ////////////////////months to lose weight
    else if (state ==15)begin
    if (sw[0]==1) begin
    anode3_months <= 8'b11000000;
    Months_1st_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode3_months <= 8'b11111001;
    Months_1st_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode3_months <= 8'b10100100;
    Months_1st_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode3_months <= 8'b10110000;
    Months_1st_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode3_months <= 8'b10011001; 
    Months_1st_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode3_months <= 8'b10010010;  
    Months_1st_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode3_months <= 8'b10000010;
    Months_1st_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode3_months <= 8'b11111000;
    Months_1st_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode3_months <= 8'b10000000;
    Months_1st_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode3_months <= 8'b10011000;
    Months_1st_digit <= 9;                
    end
    else begin
    anode3_months <= anode3_months;
    Months_1st_digit <= Months_1st_digit;
    end
    
    end //state ==15
    //////////////////////
    else if (state ==16)begin
    if (sw[0]==1) begin
    anode2_months <= 8'b11000000;
    Months_2nd_digit <= 0;
    end
    else if(sw[1] == 1)begin 
    anode2_months <= 8'b11111001;
    Months_2nd_digit <= 1;
    end
    else if(sw[2] == 1)begin
    anode2_months <= 8'b10100100;
    Months_2nd_digit <= 2;       
    end
    else if(sw[3] == 1)begin
    anode2_months <= 8'b10110000;
    Months_2nd_digit <= 3;                
    end
    else if(sw[4] == 1)begin
    anode2_months <= 8'b10011001; 
    Months_2nd_digit <= 4;               
    end
    else if(sw[5] == 1)begin
    anode2_months <= 8'b10010010;  
    Months_2nd_digit <= 5;             
    end
    else if(sw[6] == 1)begin
    anode2_months <= 8'b10000010;
    Months_2nd_digit <= 6;                
    end
    else if(sw[7] == 1)begin
    anode2_months <= 8'b11111000;
    Months_2nd_digit <= 7;               
    end
    else if(sw[8] == 1)begin
    anode2_months <= 8'b10000000;
    Months_2nd_digit <= 8;                
    end
    else if(sw[9]== 1)begin
    anode2_months <= 8'b10011000;
    Months_2nd_digit <= 9;                
    end
    
    else begin
    anode2_months <= anode2_months;
    Months_2nd_digit <= Months_2nd_digit;
    end
    
    end //state ==16
    ////////////////////
    end //control==3
    /////////////////////
    end///always begin
    
endmodule

 