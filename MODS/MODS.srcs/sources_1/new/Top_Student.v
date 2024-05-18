`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME: 
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
   input clk,
   input btnC,btnL,btnR,btnU,btnD,
   input [15:0]sw,
   output [15:0]led,
   output [7:0]seg,
   output [3:0]an,
   output [7:0]JC
   
    );
   wire clk_6p25m,clk_25Mhz;
   wire fb;
   wire sample_pixel;
   wire sending_pixels;
   wire [12:0] pixel_index;
   wire [7:0]x;
   wire [6:0]y;
   reg reset =1;
   wire[7:0] an0_k;
   wire[7:0] an1_k;
   wire[7:0] an2_k;
   wire[7:0] an3_k;
   wire [7:0] control;
   wire [15:0]oled_data;
   wire [15:0] oled_data_k;  
   wire keith_control; // to signal to mux that my mod is done
   wire keith_control_ari;
   wire [3:0] exercise; // to damien module 
   
   wire ari_control;
   wire [7:0] an0_ari;
   wire [7:0] an1_ari;
   wire [7:0] an2_ari;
   wire [7:0] an3_ari;   
   wire [15:0] led_ari;  
   wire [15:0] oled_data_ari; 
   wire ari_rj_control;
   
   wire RJ_control;
   wire [7:0] seg_RJ;
   wire [3:0] an_RJ;
   wire [15:0]oled_data_RJ;
   
   wire damien_control;
   wire[7:0] an0_d;
   wire[7:0] an1_d;
   wire[7:0] an2_d;
   wire[7:0] an3_d;
   
   wire [15:0] oled_data_d;
   wire [15:0] led_d;

   wire [10:0] num_pushup;
   wire [10:0] num_pullup;
   wire [10:0] num_situp;
   wire [31:0] num_running;    
   wire[15:0] num_kcal_burn;
   assign x = pixel_index % 96;
   assign y = pixel_index / 96; 
   
   flexible_clock clk6p (.basys_clk(clk),.m(7), .slow_clock(clk_6p25m));
   
   Keith_module Workout(clk_6p25m,btnC,btnL,btnR,btnU,btnD,sw[1:0],pixel_index,x,y,control,num_kcal_burn,exercise,keith_control,keith_control_ari,num_pushup,num_situp,num_pullup,num_running,an0_k,an1_k,an2_k,an3_k,oled_data_k);             
   MUX_control MUX(clk_6p25m, keith_control, damien_control, ari_control,RJ_control,keith_control_ari, ari_rj_control, control);
   wire [15:0] calorie_tdee; //to receive input from ruijie
   wire [15:0] calorie_deficit; //to receive input from ruijie 
   
   wire [15:0]height_weight_pic;
   wire [15:0]page2;
   
   BRAM_RJ_page1(.clk(clk_6p25m), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(height_weight_pic[15:0])); 
   BRAM_RJ_page2(.clk(clk_6p25m), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(page2[15:0])); 
      
   RJ_Main UserInputs(clk_6p25m,control,
      height_weight_pic[15:0],page2[15:0],
      sw[15:0],seg_RJ[7:0],an_RJ[3:0],btnC,btnL,btnR,btnD,btnU,x[7:0],y[6:0],oled_data_RJ[15:0],
      RJ_control,calorie_tdee,calorie_deficit
      );
   
   
   Ari_Main_Control ari (clk_6p25m, pixel_index, btnL, btnR, btnC, btnU, btnD, calorie_tdee, calorie_deficit, control, oled_data_ari, led_ari, an0_ari, an1_ari, an2_ari, an3_ari, num_kcal_burn, ari_control, ari_rj_control);
   damien damien(control, damien_control, clk, sw[15:12], btnC, btnL, pixel_index, exercise, num_pushup, num_situp, num_pullup, num_running, led_d, an0_d, an1_d, an2_d, an3_d, oled_data_d);
   
   Project_MUX Integration(clk_6p25m, control, oled_data_d, oled_data_k, oled_data_ari,oled_data_RJ, an0_ari, an1_ari, an2_ari, an3_ari, an0_k,an1_k,an2_k,an3_k, an0_d, an1_d, an2_d, an3_d,seg_RJ,an_RJ, an,seg, oled_data, led_d, led_ari, led);
   
   Oled_Display Oled_mod(.clk(clk_6p25m), 
                 .reset(0),
                 .frame_begin(fb),
                 .sending_pixels(sending_pixels),
                 .sample_pixel(sample_pixel), 
                 .pixel_index(pixel_index), 
                 .pixel_data(oled_data),
                 .cs(JC[0]), 
                 .sdin(JC[1]), 
                 .sclk(JC[3]), 
                 .d_cn(JC[4]), 
                 .resn(JC[5]), 
                 .vccen(JC[6]),
                 .pmoden(JC[7]));
          
                 
                 
//   wire [15:0]pushup_up_pic;
//   BRAM_pushup_up(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pushup_up_pic));              
                 
                 
//        reg digit0[0:6][0:3];
//        reg digit1[0:6][0:3];
//        reg digit2[0:6][0:3];
//        reg digit3[0:6][0:3];
//        reg digit4[0:6][0:3];
//        reg digit5[0:6][0:3];
//        reg digit6[0:6][0:3];
//        reg digit7[0:6][0:3];
//        reg digit8[0:6][0:3];
//        reg digit9[0:6][0:3];
        
//        reg num1[0:6][0:3];
//        reg num2[0:6][0:3];
//        reg num3[0:6][0:3];
//        reg num4[0:6][0:3];
//        reg num5[0:6][0:3];
//        reg num6[0:6][0:3];
//        reg num7[0:6][0:3];
//        reg num8[0:6][0:3];            
        
//        reg [7:0]anode0; 
//        reg [7:0]anode1;
//        reg [7:0]anode2;
//        reg [3:0]control_seven = 0;
//        reg[31:0] count_seven = 0;
//        reg[5:0] state =0;
//        reg[10:0] xLeft;
//        reg[10:0] xRight;
//        reg[10:0] yUp;
//        reg[10:0] yDown;
            
//        reg[31:0] count = 0;
//        reg[31:0] count1 = 0;
//        reg[31:0] count2 = 0;
//        reg[31:0] num_pushup = 0;    
//        reg[31:0] num_situp = 0;
//        reg[31:0] num_running = 0;
//        reg[31:0] num_pullup = 0;
//        reg[31:0] num_total;      
//        initial begin    //assign array number values
//        digit0[0][0] <= 0; // digit 0
//        digit0[0][1] <= 1;
//        digit0[0][2] <= 1;
//        digit0[0][3] <= 0;
        
//        digit0[1][0] <= 1;
//        digit0[1][1] <= 0;
//        digit0[1][2] <= 0;
//        digit0[1][3] <= 1;
        
//        digit0[2][0] <= 1;
//        digit0[2][1] <= 0;
//        digit0[2][2] <= 0;
//        digit0[2][3] <= 1;
      
//        digit0[3][0] <= 1;
//        digit0[3][1] <= 0;
//        digit0[3][2] <= 0;
//        digit0[3][3] <= 1;
      
//        digit0[4][0] <= 1;
//        digit0[4][1] <= 0;
//        digit0[4][2] <= 0;
//        digit0[4][3] <= 1;
      
//        digit0[5][0] <= 1;
//        digit0[5][1] <= 0;
//        digit0[5][2] <= 0;
//        digit0[5][3] <= 1;
      
//        digit0[6][0] <= 0;
//        digit0[6][1] <= 1;
//        digit0[6][2] <= 1;
//        digit0[6][3] <= 0;
        
        
//        digit1[0][0] <= 0; // digit 1
//        digit1[0][1] <= 0;
//        digit1[0][2] <= 1;
//        digit1[0][3] <= 0;
        
//        digit1[1][0] <= 0;
//        digit1[1][1] <= 1;
//        digit1[1][2] <= 1;
//        digit1[1][3] <= 0;
        
//        digit1[2][0] <= 1;
//        digit1[2][1] <= 0;
//        digit1[2][2] <= 1;
//        digit1[2][3] <= 0;
      
//        digit1[3][0] <= 0;
//        digit1[3][1] <= 0;
//        digit1[3][2] <= 1;
//        digit1[3][3] <= 0;
      
//        digit1[4][0] <= 0;
//        digit1[4][1] <= 0;
//        digit1[4][2] <= 1;
//        digit1[4][3] <= 0;
      
//        digit1[5][0] <= 0;
//        digit1[5][1] <= 0;
//        digit1[5][2] <= 1;
//        digit1[5][3] <= 0;
      
//        digit1[6][0] <= 0;
//        digit1[6][1] <= 0;
//        digit1[6][2] <= 1;
//        digit1[6][3] <= 0;
        
        
//        digit2[0][0] <= 0; //digit 2
//        digit2[0][1] <= 1;
//        digit2[0][2] <= 1;
//        digit2[0][3] <= 0;
        
//        digit2[1][0] <= 1;
//        digit2[1][1] <= 0;
//        digit2[1][2] <= 0;
//        digit2[1][3] <= 1;
        
//        digit2[2][0] <= 0;
//        digit2[2][1] <= 0;
//        digit2[2][2] <= 0;
//        digit2[2][3] <= 1;
      
//        digit2[3][0] <= 0;
//        digit2[3][1] <= 0;
//        digit2[3][2] <= 1;
//        digit2[3][3] <= 0;
      
//        digit2[4][0] <= 0;
//        digit2[4][1] <= 1;
//        digit2[4][2] <= 0;
//        digit2[4][3] <= 0;
      
//        digit2[5][0] <= 1;
//        digit2[5][1] <= 0;
//        digit2[5][2] <= 0;
//        digit2[5][3] <= 0;
      
//        digit2[6][0] <= 1;
//        digit2[6][1] <= 1;
//        digit2[6][2] <= 1;
//        digit2[6][3] <= 1;
       
       
//        digit3[0][0] <= 0; // digit 3
//        digit3[0][1] <= 1;
//        digit3[0][2] <= 1;
//        digit3[0][3] <= 0;
        
//        digit3[1][0] <= 1;
//        digit3[1][1] <= 0;
//        digit3[1][2] <= 0;
//        digit3[1][3] <= 1;
        
//        digit3[2][0] <= 0;
//        digit3[2][1] <= 0;
//        digit3[2][2] <= 0;
//        digit3[2][3] <= 1;
      
//        digit3[3][0] <= 0;
//        digit3[3][1] <= 1;
//        digit3[3][2] <= 1;
//        digit3[3][3] <= 0;
     
//        digit3[4][0] <= 0;
//        digit3[4][1] <= 0;
//        digit3[4][2] <= 0;
//        digit3[4][3] <= 1;
      
//        digit3[5][0] <= 1;
//        digit3[5][1] <= 0;
//        digit3[5][2] <= 0;
//        digit3[5][3] <= 1;
      
//        digit3[6][0] <= 0;
//        digit3[6][1] <= 1;
//        digit3[6][2] <= 1;
//        digit3[6][3] <= 0;
        
        
//        digit4[0][0] <= 0; // digit 4
//        digit4[0][1] <= 0;
//        digit4[0][2] <= 0;
//        digit4[0][3] <= 1;
        
//        digit4[1][0] <= 0;
//        digit4[1][1] <= 0;
//        digit4[1][2] <= 1;
//        digit4[1][3] <= 1;
        
//        digit4[2][0] <= 0;
//        digit4[2][1] <= 1;
//        digit4[2][2] <= 0;
//        digit4[2][3] <= 1;
      
//        digit4[3][0] <= 1;
//        digit4[3][1] <= 0;
//        digit4[3][2] <= 0;
//        digit4[3][3] <= 1;
     
//        digit4[4][0] <= 1;
//        digit4[4][1] <= 1;
//        digit4[4][2] <= 1;
//        digit4[4][3] <= 1;
      
//        digit4[5][0] <= 0;
//        digit4[5][1] <= 0;
//        digit4[5][2] <= 0;
//        digit4[5][3] <= 1;
      
//        digit4[6][0] <= 0;
//        digit4[6][1] <= 0;
//        digit4[6][2] <= 0;
//        digit4[6][3] <= 1;
        
        
//        digit5[0][0] <= 1;// digit 5
//        digit5[0][1] <= 1;
//        digit5[0][2] <= 1;
//        digit5[0][3] <= 1;
        
//        digit5[1][0] <= 1;
//        digit5[1][1] <= 0;
//        digit5[1][2] <= 0;
//        digit5[1][3] <= 0;
        
//        digit5[2][0] <= 1;
//        digit5[2][1] <= 1;
//        digit5[2][2] <= 1;
//        digit5[2][3] <= 0;
      
//        digit5[3][0] <= 0;
//        digit5[3][1] <= 0;
//        digit5[3][2] <= 0;
//        digit5[3][3] <= 1;
     
//        digit5[4][0] <= 0;
//        digit5[4][1] <= 0;
//        digit5[4][2] <= 0;
//        digit5[4][3] <= 1;
      
//        digit5[5][0] <= 1;
//        digit5[5][1] <= 0;
//        digit5[5][2] <= 0;
//        digit5[5][3] <= 1;
      
//        digit5[6][0] <= 0;
//        digit5[6][1] <= 1;
//        digit5[6][2] <= 1;
//        digit5[6][3] <= 0;

        
//        digit6[0][0] <= 0; // digit 6
//        digit6[0][1] <= 1;
//        digit6[0][2] <= 1;
//        digit6[0][3] <= 0;
        
//        digit6[1][0] <= 1;
//        digit6[1][1] <= 0;
//        digit6[1][2] <= 0;
//        digit6[1][3] <= 0;
        
//        digit6[2][0] <= 1;
//        digit6[2][1] <= 0;
//        digit6[2][2] <= 0;
//        digit6[2][3] <= 0;
      
//        digit6[3][0] <= 1;
//        digit6[3][1] <= 1;
//        digit6[3][2] <= 1;
//        digit6[3][3] <= 0;
     
//        digit6[4][0] <= 1;
//        digit6[4][1] <= 0;
//        digit6[4][2] <= 0;
//        digit6[4][3] <= 1;
      
//        digit6[5][0] <= 1;
//        digit6[5][1] <= 0;
//        digit6[5][2] <= 0;
//        digit6[5][3] <= 1;
      
//        digit6[6][0] <= 0;
//        digit6[6][1] <= 1;
//        digit6[6][2] <= 1;
//        digit6[6][3] <= 0;
       
        
//        digit7[0][0] <= 1; // digit 7
//        digit7[0][1] <= 1;
//        digit7[0][2] <= 1;
//        digit7[0][3] <= 1;
        
//        digit7[1][0] <= 0;
//        digit7[1][1] <= 0;
//        digit7[1][2] <= 0;
//        digit7[1][3] <= 1;
        
//        digit7[2][0] <= 0;
//        digit7[2][1] <= 0;
//        digit7[2][2] <= 0;
//        digit7[2][3] <= 1;
      
//        digit7[3][0] <= 0;
//        digit7[3][1] <= 0;
//        digit7[3][2] <= 1;
//        digit7[3][3] <= 0;
     
//        digit7[4][0] <= 0;
//        digit7[4][1] <= 1;
//        digit7[4][2] <= 0;
//        digit7[4][3] <= 0;
      
//        digit7[5][0] <= 0;
//        digit7[5][1] <= 1;
//        digit7[5][2] <= 0;
//        digit7[5][3] <= 0;
      
//        digit7[6][0] <= 0;
//        digit7[6][1] <= 1;
//        digit7[6][2] <= 0;
//        digit7[6][3] <= 0;
       
        
//        digit8[0][0] <= 0; // digit 8
//        digit8[0][1] <= 1;
//        digit8[0][2] <= 1;
//        digit8[0][3] <= 0;
        
//        digit8[1][0] <= 1;
//        digit8[1][1] <= 0;
//        digit8[1][2] <= 0;
//        digit8[1][3] <= 1;
        
//        digit8[2][0] <= 1;
//        digit8[2][1] <= 0;
//        digit8[2][2] <= 0;
//        digit8[2][3] <= 1;
      
//        digit8[3][0] <= 0;
//        digit8[3][1] <= 1;
//        digit8[3][2] <= 1;
//        digit8[3][3] <= 0;
     
//        digit8[4][0] <= 1;
//        digit8[4][1] <= 0;
//        digit8[4][2] <= 0;
//        digit8[4][3] <= 1;
      
//        digit8[5][0] <= 1;
//        digit8[5][1] <= 0;
//        digit8[5][2] <= 0;
//        digit8[5][3] <= 1;
      
//        digit8[6][0] <= 0;
//        digit8[6][1] <= 1;
//        digit8[6][2] <= 1;
//        digit8[6][3] <= 0;
        
        
//        digit9[0][0] <= 0; // digit 9
//        digit9[0][1] <= 1;
//        digit9[0][2] <= 1;
//        digit9[0][3] <= 0;
        
//        digit9[1][0] <= 1;
//        digit9[1][1] <= 0;
//        digit9[1][2] <= 0;
//        digit9[1][3] <= 1;
        
//        digit9[2][0] <= 1;
//        digit9[2][1] <= 0;
//        digit9[2][2] <= 0;
//        digit9[2][3] <= 1;
      
//        digit9[3][0] <= 0;
//        digit9[3][1] <= 1;
//        digit9[3][2] <= 1;
//        digit9[3][3] <= 1;
     
//        digit9[4][0] <= 0;
//        digit9[4][1] <= 0;
//        digit9[4][2] <= 0;
//        digit9[4][3] <= 1;
      
//        digit9[5][0] <= 1;
//        digit9[5][1] <= 0;
//        digit9[5][2] <= 0;
//        digit9[5][3] <= 1;
      
//        digit9[6][0] <= 0;
//        digit9[6][1] <= 1;
//        digit9[6][2] <= 1;
//        digit9[6][3] <= 0;
//       end          
       
//        always @ (posedge clk_6p25m)
//        begin 
        
//        if(state == 0)begin
//        xLeft <= 0;
//        xRight <= 46;
//        yUp <= 1;
//        yDown <= 25;
        
//        if(sw[0] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        num_pushup <= num_pushup + 1;
//        count1 <= 0;
//        end
//        end
        
//        else if(sw[1] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        if(num_pushup > 0)begin
//        num_pushup <= num_pushup - 1;
//        end
//        count1 <= 0;
//        end
//        end
        
//        if(btnR == 1)begin
//        count <= count + 1;
//        end
//        else if(btnR == 0 && count > 1000) begin
//        count <= 0;
//        state <= 1;
//        end
//        else begin
//        count <= 0;
//        end
        
        
//        if(btnD == 1)begin
//        count2 <= count2 + 1;
//        end
//        else if(btnD == 0 && count2 > 1000) begin
//        count2 <= 0;
//        state <= 2;
//        end
//        else begin
//        count2 <= 0;
//        end
            
//        end 
        
//        else if (state == 1) begin
//        xLeft <= 48;
//        xRight <= 95;
//        yUp <= 1;
//        yDown <= 25;
        
//        if(sw[0] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        num_situp <= num_situp + 1;
//        count1 <= 0;
//        end
//        end
        
//        else if(sw[1] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        if(num_situp > 0)begin
//        num_situp <= num_situp - 1;
//        end
//        count1 <= 0;
//        end
//        end
        
        
//        if(btnL == 1)begin
//        count <= count + 1;
//        end
//        else if(btnL == 0 && count > 1000) begin
//        count <= 0;
//        state <= 0;
//        end
//        else begin
//        count <= 0;
//        end
        
//        if(btnD == 1)begin
//        count2 <= count2 + 1;
//        end
//        else if(btnD == 0 && count2 > 1000) begin
//        count2 <= 0;
//        state <= 3;
//        end
//        else begin
//        count2 <= 0;
//        end
        
//        end
        
        
//        else if (state == 2) begin
//        xLeft <= 0;
//        xRight <= 46;
//        yUp <= 26;
//        yDown <= 50;
//        if(sw[0] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        num_pullup <= num_pullup + 1;
//        count1 <= 0;
//        end
//        end
        
//        else if(sw[1] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        if(num_pullup > 0)begin
//        num_pullup <= num_pullup - 1;
//        end
//        count1 <= 0;
//        end
//        end
        
        
//        if(btnR == 1)begin
//        count <= count + 1;
//        end
//        else if(btnR == 0 && count > 1000) begin
//        count <= 0;
//        state <= 3;
//        end
//        else begin
//        count <= 0;
//        end
        
//        if(btnU == 1)begin
//        count2 <= count2 + 1;
//        end
//        else if(btnU == 0 && count2 > 1000) begin
//        count2 <= 0;
//        state <= 0;
//        end
//        else begin
//        count2 <= 0;
//        end
    
        
//        end
           
//        else if (state == 3) begin
//        xLeft <= 48;
//        xRight <= 95;
//        yUp <= 26;
//        yDown <= 50;
//        if(sw[0] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        num_running <= num_running + 1;
//        count1 <= 0;
//        end
//        end
        
//        else if(sw[1] == 1) begin
//        count1 <= count1 + 1;
//        if(count1 > 8000000)begin
//        if(num_running > 0)begin
//        num_running <= num_running - 1;
//        end
//        count1 <= 0;
//        end
//        end
        
        
//        if(btnL == 1)begin
//        count <= count + 1;
//        end
//        else if(btnL == 0 && count > 1000) begin
//        count <= 0;
//        state <= 2;
//        end
//        else begin
//        count <= 0;
//        end
        
//        if(btnU == 1)begin
//        count2 <= count2 + 1;
//        end
//        else if(btnU == 0 && count2 > 1000) begin
//        count2 <= 0;
//        state <= 1;
//        end
//        else begin
//        count2 <= 0;
//        end       
//        end
        

        
//        num_total <= 3*num_pushup + 15*num_situp + 15*num_running + 10*num_pullup;
//        count_seven <= count_seven + 1;
        
//        if((num_total%10) == 1)begin //first digit of Kcal
//        anode0 <= 8'b11111001;
//        end
//        else if((num_total%10) == 2)begin
//        anode0 <= 8'b10100100;       
//        end
//        else if((num_total%10) == 3)begin
//        anode0 <= 8'b10110000;                
//        end
//        else if((num_total%10) == 4)begin
//        anode0 <= 8'b10011001;                
//        end
//        else if((num_total%10) == 5)begin
//        anode0 <= 8'b10010010;               
//        end
//        else if((num_total%10) == 6)begin
//        anode0 <= 8'b10000010;                
//        end
//        else if((num_total%10) == 7)begin
//        anode0 <= 8'b11111000;               
//        end
//        else if((num_total%10) == 8)begin
//        anode0 <= 8'b10000000;                
//        end
//        else if((num_total%10) == 9)begin
//        anode0 <= 8'b10011000;                
//        end
//        else begin
//        anode0 <= 8'b11000000;
//        end
        
//        if(((num_total/10)%10) == 1)begin //second digit of Kcal
//        anode1 <= 8'b11111001;
//        end
//        else if(((num_total/10)%10) == 2)begin
//        anode1 <= 8'b10100100;       
//        end
//        else if(((num_total/10)%10) == 3)begin
//        anode1 <= 8'b10110000;                
//        end
//        else if(((num_total/10)%10) == 4)begin
//        anode1 <= 8'b10011001;                
//        end
//        else if(((num_total/10)%10) == 5)begin
//        anode1 <= 8'b10010010;               
//        end
//        else if(((num_total/10)%10) == 6)begin
//        anode1 <= 8'b10000010;                
//        end
//        else if(((num_total/10)%10) == 7)begin
//        anode1 <= 8'b11111000;               
//        end
//        else if(((num_total/10)%10) == 8)begin
//        anode1 <= 8'b10000000;                
//        end
//        else if(((num_total/10)%10) == 9)begin
//        anode1 <= 8'b10011000;                
//        end
//        else begin
//        anode1 <= 8'b11000000;
//        end
        
//        if(((num_total/100)%10) == 1)begin //third digit of Kcal
//        anode2 <= 8'b11111001;
//        end
//        else if(((num_total/100)%10) == 2)begin
//        anode2 <= 8'b10100100;       
//        end
//        else if(((num_total/100)%10) == 3)begin
//        anode2 <= 8'b10110000;                
//        end
//        else if(((num_total/100)%10) == 4)begin
//        anode2 <= 8'b10011001;                
//        end
//        else if(((num_total/100)%10) == 5)begin
//        anode2 <= 8'b10010010;               
//        end
//        else if(((num_total/100)%10) == 6)begin
//        anode2 <= 8'b10000010;                
//        end
//        else if(((num_total/100)%10) == 7)begin
//        anode2 <= 8'b11111000;               
//        end
//        else if(((num_total/100)%10) == 8)begin
//        anode2 <= 8'b10000000;                
//        end
//        else if(((num_total/100)%10) == 9)begin
//        anode2 <= 8'b10011000;                
//        end
//        else begin
//        anode2 <= 8'b11000000;
//        end
        
//        if(control_seven == 0) begin
//        an[3:0] <= 4'b1110;
//        seg <= anode0;
//        if (count_seven > 10000)begin
//        count_seven <= 0;
//        control_seven <= 1;
//        end
//        end
//        else if (control_seven == 1) begin
//        an[3:0] <= 4'b1101;
//        seg <= anode1;
//        if (count_seven > 10000)begin
//        count_seven <= 0;
//        control_seven <= 2;
//        end        
//        end
//        else if (control_seven == 2) begin
//        an[3:0] <= 4'b1011;
//        seg <= anode2;
//        if (count_seven > 10000)begin
//        count_seven <= 0;
//        control_seven <= 3;
//        end        
//        end
//        else if (control_seven == 3) begin
//        an[3:0] <= 4'b0111;
//        seg <= 8'b10111111;
//        if (count_seven > 10000)begin
//        count_seven <= 0;
//        control_seven <= 0;
//        end        
//        end
                  
//        if( x >= 15 && x <=18 && y >= 14 && y <= 20 )begin 
        
//            if((num_pushup%10) == 1 && digit1[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if((num_pushup%10) == 2 && digit2[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pushup%10) == 3 && digit3[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pushup%10) == 4 && digit4[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pushup%10) == 5 && digit5[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if((num_pushup%10) == 6 && digit6[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pushup%10) == 7 && digit7[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pushup%10) == 8 && digit8[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pushup%10) == 9 && digit9[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pushup%10) == 0 && digit0[y-14][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else begin
//            oled_data <= 16'b00000_000000_00000;
//            end
//            end    
//        else if( x >= 10 && x <=13 && y >= 14 && y <= 20 )begin 
//            if(((num_pushup/10)%10) == 1 && digit1[y-14][x-10]) begin
//               oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 2 && digit2[y-14][x-10]) begin
//               oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 3 && digit3[y-14][x-10]) begin
//               oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 4 && digit4[y-14][x-10]) begin
//               oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 5 && digit5[y-14][x-10]) begin
//               oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 6 && digit6[y-14][x-10]) begin
//                oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 7 && digit7[y-14][x-10]) begin
//                oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 8 && digit8[y-14][x-10]) begin
//                oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 9 && digit9[y-14][x-10]) begin
//                oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pushup/10)%10) == 0 && digit0[y-14][x-10]) begin
//                oled_data <= 16'b11111_111111_11111;
//            end
//            else begin
//                oled_data <= 16'b00000_000000_00000;
//            end
//            end  
//        else if( x >= 63 && x <=66 && y >= 14 && y <= 20 )begin 
//            if((num_situp%10) == 1 && digit1[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 2 && digit2[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 3 && digit3[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 4 && digit4[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 5 && digit5[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if((num_situp%10) == 6 && digit6[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 7 && digit7[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 8 && digit8[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 9 && digit9[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_situp%10) == 0 && digit0[y-14][x-63]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else begin
//            oled_data <= 16'b00000_000000_00000;
//            end  
//            end 
//        else if( x >= 58 && x <=61 && y >= 14 && y <= 20)begin 
//            if(((num_situp/10)%10) == 1 && digit1[y-14][x-58]) begin
//                oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 2 && digit2[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 3 && digit3[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 4 && digit4[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 5 && digit5[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if(((num_situp/10)%10) == 6 && digit6[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 7 && digit7[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 8 && digit8[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 9 && digit9[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_situp/10)%10) == 0 && digit0[y-14][x-58]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else begin
//            oled_data <= 16'b00000_000000_00000;
//            end   
//            end  
//        else if( x >= 15 && x <=18 && y >= 39 && y <= 45)begin 
//            if((num_pullup%10) == 1 && digit1[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 2 && digit2[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 3 && digit3[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 4 && digit4[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 5 && digit5[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if((num_pullup%10) == 6 && digit6[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 7 && digit7[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 8 && digit8[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 9 && digit9[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_pullup%10) == 0 && digit0[y-39][x-15]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else begin
//            oled_data <= 16'b00000_000000_00000;
//            end
//            end 
//        else if( x >= 10 && x <=13 && y >= 39 && y <= 45 )begin 
//            if(((num_pullup/10)%10) == 1 && digit1[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 2 && digit2[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 3 && digit3[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 4 && digit4[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 5 && digit5[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if(((num_pullup/10)%10) == 6 && digit6[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 7 && digit7[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 8 && digit8[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 9 && digit9[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_pullup/10)%10) == 0 && digit0[y-39][x-10]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else begin
//            oled_data <= 16'b00000_000000_00000;
//            end    
//            end
             
//        else if( x >= 59 && x <=62 && y >= 39 && y <= 45 )begin 
//            if((num_running%10) == 1 && digit1[y-39][x-59]) begin
//                oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 2 && digit2[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 3 && digit3[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 4 && digit4[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 5 && digit5[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if((num_running%10) == 6 && digit6[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 7 && digit7[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 8 && digit8[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 9 && digit9[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if((num_running%10) == 0 && digit0[y-39][x-59]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else begin
//            oled_data <= 16'b00000_000000_00000;
//            end  
//            end 
            
//        else if( x >= 54 && x <=57 && y >= 39 && y <= 45 )begin 
//            if(((num_running/10)%10) == 1 && digit1[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 2 && digit2[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 3 && digit3[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 4 && digit4[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 5 && digit5[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end   
//            else if(((num_running/10)%10) == 6 && digit6[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 7 && digit7[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 8 && digit8[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 9 && digit9[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end
//            else if(((num_running/10)%10) == 0 && digit0[y-39][x-54]) begin
//            oled_data <= 16'b11111_111111_11111;
//            end  
//            else begin
//            oled_data <= 16'b00000_000000_00000;
//            end  
//            end
        
//        else if (xLeft <= x && x <= xRight && yUp <= y && y <= yDown && !((xLeft+1) <= x && x <= (xRight-1) && (yUp+1) <= y && y <= (yDown-1))) begin
//        oled_data <= 16'b00000_111111_00000;
//        end
 
//        else begin 
//               oled_data <= pushup_up_pic;
//            end
//           end       

endmodule



