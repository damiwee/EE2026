`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2024 21:29:34
// Design Name: 
// Module Name: numpad_digits
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

module numpad(
    input basys_clk, 
    input isMain,
    input isNumpad,
    input [12:0] pixel_index,
    input btnL,
    input btnR,
    input btnC,
    input btnU,
    input btnD,
    output reg [15:0] oled_data,
    output reg [15:0] calorie_count = 0,
    output reg isMain_X  = 0
    );
    
    wire [6:0] x, y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    parameter DIGITCOLOR = 16'hE441;
    parameter BACKGROUND = 16'h0000;
    parameter DELETECOLOR = 16'hF800;
    parameter TICKCOLOR = 16'h0F48;
    parameter BOXCOLOR = 16'h0F48;
    parameter LINECOLOR = 16'h2458;
    
    
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
    
     
    reg [3:0] display_pos = 0;
    reg [4:0] display_num[3:0]; 
    
    reg [15:0] deleteIcon [6:0][4:0];
    reg [15:0] tickIcon [5:0][5:0];
    
    initial begin
        display_num[0] <= 10;   //set as background (blank)
        display_num[1] <= 10;   //set as background (blank)
        display_num[2] <= 10;   //set as background (blank)
        display_num[3] <= 10;   //set as background (blank)
    
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
    
    //////////////////////////////// delete Icon
       deleteIcon[0][0] <= BACKGROUND;
       deleteIcon[0][1] <= BACKGROUND;
       deleteIcon[0][2] <= BACKGROUND;
       deleteIcon[0][3] <= DELETECOLOR;
       deleteIcon[0][4] <= DELETECOLOR;
    
       deleteIcon[1][0] <= BACKGROUND;
       deleteIcon[1][1] <= BACKGROUND;
       deleteIcon[1][2] <= DELETECOLOR;
       deleteIcon[1][3] <= DELETECOLOR;
       deleteIcon[1][4] <= BACKGROUND;
    
       deleteIcon[2][0] <= BACKGROUND;
       deleteIcon[2][1] <= DELETECOLOR;
       deleteIcon[2][2] <= DELETECOLOR;
       deleteIcon[2][3] <= BACKGROUND;
       deleteIcon[2][4] <= BACKGROUND;       
    
       deleteIcon[3][0] <= DELETECOLOR;
       deleteIcon[3][1] <= DELETECOLOR;
       deleteIcon[3][2] <= BACKGROUND;
       deleteIcon[3][3] <= BACKGROUND;
       deleteIcon[3][4] <= BACKGROUND; 
    
       deleteIcon[4][0] <= BACKGROUND;
       deleteIcon[4][1] <= DELETECOLOR;
       deleteIcon[4][2] <= DELETECOLOR;
       deleteIcon[4][3] <= BACKGROUND;
       deleteIcon[4][4] <= BACKGROUND;       
    
       deleteIcon[5][0] <= BACKGROUND;
       deleteIcon[5][1] <= BACKGROUND;
       deleteIcon[5][2] <= DELETECOLOR;
       deleteIcon[5][3] <= DELETECOLOR;
       deleteIcon[5][4] <= BACKGROUND;       
    
       deleteIcon[6][0] <= BACKGROUND;
       deleteIcon[6][1] <= BACKGROUND;
       deleteIcon[6][2] <= BACKGROUND;
       deleteIcon[6][3] <= DELETECOLOR;
       deleteIcon[6][4] <= DELETECOLOR;    
    /////////////////////////////////    
    
        //////////////////////////////// tick Icon
       tickIcon[0][0] <= BACKGROUND;
       tickIcon[0][1] <= BACKGROUND;
       tickIcon[0][2] <= BACKGROUND;
       tickIcon[0][3] <= BACKGROUND;
       tickIcon[0][4] <= BACKGROUND;
       tickIcon[0][5] <= TICKCOLOR;
    
       tickIcon[1][0] <= BACKGROUND;
       tickIcon[1][1] <= BACKGROUND;
       tickIcon[1][2] <= BACKGROUND;
       tickIcon[1][3] <= BACKGROUND;
       tickIcon[1][4] <= TICKCOLOR;
       tickIcon[1][5] <= TICKCOLOR;
    
       tickIcon[2][0] <= BACKGROUND;
       tickIcon[2][1] <= BACKGROUND;
       tickIcon[2][2] <= BACKGROUND;
       tickIcon[2][3] <= TICKCOLOR;
       tickIcon[2][4] <= TICKCOLOR;
       tickIcon[2][5] <= BACKGROUND;       
    
       tickIcon[3][0] <= TICKCOLOR;
       tickIcon[3][1] <= BACKGROUND;
       tickIcon[3][2] <= TICKCOLOR;
       tickIcon[3][3] <= TICKCOLOR;
       tickIcon[3][4] <= BACKGROUND;
       tickIcon[3][5] <= BACKGROUND; 
    
       tickIcon[4][0] <= TICKCOLOR;
       tickIcon[4][1] <= TICKCOLOR;
       tickIcon[4][2] <= TICKCOLOR;
       tickIcon[4][3] <= BACKGROUND;
       tickIcon[4][4] <= BACKGROUND;
       tickIcon[4][5] <= BACKGROUND;       
    
       tickIcon[5][0] <= BACKGROUND;
       tickIcon[5][1] <= TICKCOLOR;
       tickIcon[5][2] <= BACKGROUND;
       tickIcon[5][3] <= BACKGROUND;
       tickIcon[5][4] <= BACKGROUND;
       tickIcon[5][5] <= BACKGROUND;        
    /////////////////////////////////       
    
                           
    end
    
    //For button debouncing and forming of box
    reg [6:0] xLeft = 25;
    reg [6:0] xRight = 32;
    reg [6:0] yUp = 19;
    reg [6:0] yDown = 29;
    reg [6:0] lineLeft;
    reg [6:0] lineRight;
    
    reg [5:0] boxNum = 0;
    reg movedLeft = 0;
    reg movedRight = 0;
    reg movedUp = 0;
    reg movedDown = 0;
    reg movedCenter = 0;
    parameter DEBOUNCE_COUNT = 625000;
    reg[31:0] counter = 0;
    reg lineToggle = 0;
    
    always @ (posedge basys_clk) begin
    
        counter <= counter + 1;
        
        //for flashing underline
        if (counter >= 3_000_000) begin  
            lineToggle <= ~lineToggle;
            counter <= 0;
        end
        
        if (display_pos == 0) begin
            calorie_count <= 0;
        end else if (display_pos == 1) begin
            calorie_count <= display_num[0];      
        end else if (display_pos == 2) begin
            calorie_count <= (display_num[0] * 10) + display_num[1];      
        end else if (display_pos == 3) begin
            calorie_count <= (display_num[0] * 100) + (display_num[1] * 10) + display_num[2];
        end else begin
            calorie_count <= (display_num[0] * 1000) + (display_num[1] * 100) + (display_num[2] * 10) + display_num[3];
        end

    
        if (27 <= x && x <= 30 && 21 <= y && y <= 27) begin
            oled_data <= digit0[y-21][x-27]; //DIGIT 0
        end else if (40 <= x && x <= 43 && 21 <= y && y <= 27) begin
            oled_data <= digit1[y-21][x-40]; //DIGIT 1
        end else if (53 <= x && x <= 56 && 21 <= y && y <= 27) begin
            oled_data <= digit2[y-21][x-53]; //DIGIT 2
        end else if (66 <= x && x <= 69 && 21 <= y && y <= 27) begin
            oled_data <= digit3[y-21][x-66]; //DIGIT 3 
        end else if (27 <= x && x <= 30 && 36 <= y && y <= 42) begin
            oled_data <= digit4[y-36][x-27]; //DIGIT 4        
        end else if (40 <= x && x <= 43 && 36 <= y && y <= 42) begin
            oled_data <= digit5[y-36][x-40]; //DIGIT 5        
        end else if (53 <= x && x <= 56 && 36 <= y && y <= 42) begin
            oled_data <= digit6[y-36][x-53]; //DIGIT 6
        end else if (66 <= x && x <= 69 && 36 <= y && y <= 42) begin
            oled_data <= digit7[y-36][x-66]; //DIGIT 7
        end else if (27 <= x && x <= 30 && 51 <= y && y <= 57) begin
            oled_data <= digit8[y-51][x-27]; //DIGIT 8
        end else if (40 <= x && x <= 43 && 51 <= y && y <= 57) begin
            oled_data <= digit9[y-51][x-40]; //DIGIT 9         
        end else if (52 <= x && x <= 56 && 51 <= y && y <= 57) begin
            oled_data <= deleteIcon[y-51][x-52]; //DELETE ICON
        end else if (65 <= x && x <= 70 && 52 <= y && y <= 57) begin
            oled_data <= tickIcon[y-52][x-65];  //TICK ICON          
        end else if (xLeft <= x && x <= xRight && yUp <= y && y <= yDown && !((xLeft+1) <= x && x <= (xRight-1) && (yUp+1) <= y && y <= (yDown-1))) begin
            oled_data <= BOXCOLOR;    //GREEN BORDER BOX   
        end else if (24 <= x && x <= 72 && (x%2 == 1) && (y == 31 || y == 46)) begin
            oled_data <= LINECOLOR;   //horizontal blue divider line
        end else if ((x == 35 || x == 48 || x == 61) && 18 <= y && y <= 60 && (y%2 == 1)) begin
            oled_data <= LINECOLOR;  //vertical blue divider line
        end else if (y == 12 && lineLeft <= x && x <= lineRight) begin
            if (display_pos == 0 && lineToggle) begin
                lineLeft <= 26;
                lineRight <= 31;
                oled_data <= BOXCOLOR;
            end else if (display_pos == 1 && lineToggle) begin
                lineLeft <= 39;
                lineRight <= 44;
                oled_data <= BOXCOLOR;            
            end else if (display_pos == 2 && lineToggle) begin
                lineLeft <= 52;
                lineRight <= 57;
                oled_data <= BOXCOLOR;
            end else if (display_pos == 3 && lineToggle) begin
                lineLeft <= 65;
                lineRight <= 70;
                oled_data <= BOXCOLOR;                    
            end else begin
                oled_data <= BACKGROUND;
            end  
            
        end else if (27 <= x && x <= 30 && 5 <= y && y <= 11) begin  //Display 0
         
            if (display_num[0] == 0) begin
                oled_data <= digit0[y-5][x-27];
            end else if (display_num[0] == 1) begin
                oled_data <= digit1[y-5][x-27];
            end else if (display_num[0] == 2) begin
                oled_data <= digit2[y-5][x-27];
            end else if (display_num[0] == 3) begin
                oled_data <= digit3[y-5][x-27];
            end else if (display_num[0] == 4) begin
                oled_data <= digit4[y-5][x-27];
            end else if (display_num[0] == 5) begin
                oled_data <= digit5[y-5][x-27];
            end else if (display_num[0] == 6) begin
                oled_data <= digit6[y-5][x-27];
            end else if (display_num[0] == 7) begin
                oled_data <= digit7[y-5][x-27];
            end else if (display_num[0] == 8) begin
                oled_data <= digit8[y-5][x-27];
            end else if (display_num[0] == 9) begin
                oled_data <= digit9[y-5][x-27];
            end else begin
                oled_data <= digitBackGround[y-5][x-27];
            end
            
        end else if (40 <= x && x <= 43 && 5 <= y && y <= 11) begin
            
            if (display_num[1] == 0) begin   //Display 1
                oled_data <= digit0[y-5][x-40];
            end else if (display_num[1] == 1) begin
                oled_data <= digit1[y-5][x-40];
            end else if (display_num[1] == 2) begin
                oled_data <= digit2[y-5][x-40];
            end else if (display_num[1] == 3) begin
                oled_data <= digit3[y-5][x-40];
            end else if (display_num[1] == 4) begin
                oled_data <= digit4[y-5][x-40];
            end else if (display_num[1] == 5) begin
                oled_data <= digit5[y-5][x-40];
            end else if (display_num[1] == 6) begin
                oled_data <= digit6[y-5][x-40];
            end else if (display_num[1] == 7) begin
                oled_data <= digit7[y-5][x-40];
            end else if (display_num[1] == 8) begin
                oled_data <= digit8[y-5][x-40];
            end else if (display_num[1] == 9) begin
                oled_data <= digit9[y-5][x-40];
            end else begin
                oled_data <= digitBackGround[y-5][x-40];
            end            
                      
        end else if (53 <= x && x <= 56 && 5 <= y && y <= 11) begin

            if (display_num[2] == 0) begin   //Display 2
                oled_data <= digit0[y-5][x-53];
            end else if (display_num[2] == 1) begin
                oled_data <= digit1[y-5][x-53];
            end else if (display_num[2] == 2) begin
                oled_data <= digit2[y-5][x-53];
            end else if (display_num[2] == 3) begin
                oled_data <= digit3[y-5][x-53];
            end else if (display_num[2] == 4) begin
                oled_data <= digit4[y-5][x-53];
            end else if (display_num[2] == 5) begin
                oled_data <= digit5[y-5][x-53];
            end else if (display_num[2] == 6) begin
                oled_data <= digit6[y-5][x-53];
            end else if (display_num[2] == 7) begin
                oled_data <= digit7[y-5][x-53];
            end else if (display_num[2] == 8) begin
                oled_data <= digit8[y-5][x-53];
            end else if (display_num[2] == 9) begin
                oled_data <= digit9[y-5][x-53];
            end else begin
                oled_data <= digitBackGround[y-5][x-53];
            end            
            
        end else if (66 <= x && x <= 69 && 5 <= y && y <= 11) begin

            if (display_num[3] == 0) begin   //Display 3
                oled_data <= digit0[y-5][x-66];
            end else if (display_num[3] == 1) begin
                oled_data <= digit1[y-5][x-66];
            end else if (display_num[3] == 2) begin
                oled_data <= digit2[y-5][x-66];
            end else if (display_num[3] == 3) begin
                oled_data <= digit3[y-5][x-66];
            end else if (display_num[3] == 4) begin
                oled_data <= digit4[y-5][x-66];
            end else if (display_num[3] == 5) begin
                oled_data <= digit5[y-5][x-66];
            end else if (display_num[3] == 6) begin
                oled_data <= digit6[y-5][x-66];
            end else if (display_num[3] == 7) begin
                oled_data <= digit7[y-5][x-66];
            end else if (display_num[3] == 8) begin
                oled_data <= digit8[y-5][x-66];
            end else if (display_num[3] == 9) begin
                oled_data <= digit9[y-5][x-66];
            end else begin
                oled_data <= digitBackGround[y-5][x-66];
            end 
                                                                 
        end else begin
            oled_data <= BACKGROUND;
        end 
        
        
        if (btnL && boxNum != 0 && boxNum != 4 && boxNum != 8 && ~movedLeft && isNumpad) begin
            xLeft <= xLeft - 13;
            xRight <= xRight - 13;
            boxNum <= boxNum - 1;
            movedLeft <= 1;
            counter <= 0;
        end        
        
        if (btnR && boxNum != 3 && boxNum != 7 && boxNum != 11 && ~movedRight && isNumpad) begin
            xLeft <= xLeft + 13;
            xRight <= xRight + 13;
            boxNum <= boxNum + 1;
            movedRight <= 1;
            counter <= 0;
        end
        
        if (btnU && boxNum != 0 && boxNum != 1 && boxNum != 2 && boxNum != 3 && ~movedUp && isNumpad) begin
            yUp <= yUp - 15;
            yDown <= yDown - 15;
            boxNum <= boxNum - 4;
            movedUp <= 1;
            counter <= 0;
        end
        
        if (btnD && boxNum != 8 && boxNum != 9 && boxNum != 10 && boxNum != 11 && ~movedDown && isNumpad) begin
            yUp <= yUp + 15;
            yDown <= yDown + 15;
            boxNum <= boxNum + 4;
            movedDown <= 1;
            counter <= 0;
        end

        
        if (isMain) begin
            isMain_X = 0;
        end
        
        if (btnC && ~movedCenter && isNumpad) begin
            if (boxNum == 10) begin //to delete number
                if (display_pos != 0) begin
                    display_num[display_pos-1] = 10;        //to clear digit
                    display_pos = display_pos - 1;
                end    
            end else if (boxNum == 11) begin 
                isMain_X = 1;         
            end else if (display_pos != 4 && !(display_pos == 0 && boxNum == 0)) begin
                display_num[display_pos] = boxNum; //to display digit on output array
                display_pos = display_pos + 1;
            end
           
            movedCenter <= 1;
            counter <= 0;
        end
        
        if (~btnL && counter >= DEBOUNCE_COUNT) begin
            movedLeft <= 0;
        end
        
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
    
                  
    end  //end of basys_clk
    
    
    
endmodule


