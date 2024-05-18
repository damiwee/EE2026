`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2024 23:19:18
// Design Name: 
// Module Name: oled_data_mux
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


module oled_data_mux(
    input basys_clk,
    input isMain,
    input isSnack,
    input isNumpadA,
    input isNumpadB,
    input isNumpadC,
    input isNumpadD,
    input isNumpadE,
    input isNumpadF,    
    input [15:0] oled_data_A,
    input [15:0] oled_data_B,
    input [15:0] oled_data_C,
    input [15:0] oled_data_D,
    input [15:0] oled_data_E,
    input [15:0] oled_data_F,    
    input [15:0] oled_data_main,
    input [15:0] oled_data_snack,
    output reg [15:0] oled_data 
   
    );
    
    always @ (posedge basys_clk) begin
  /*
        if (isNumpadA) begin 
            oled_data <= oled_data_A;
        end else if (isNumpadB) begin
            oled_data <= oled_data_B;
        end else if (isNumpadC) begin
            oled_data <= oled_data_C;
        end else if (isNumpadD) begin
            oled_data <= oled_data_D;
        end else if (isNumpadE) begin
            oled_data <= oled_data_E;
        end else if (isNumpadF) begin
            oled_data <= oled_data_F;   
        end else if (sw0) begin
            oled_data <= oled_data_snack;                                                         
        end else begin
            oled_data <= oled_data_main;
        end*/
        
        if (isMain) begin
            oled_data <= oled_data_main;
        end else if (isSnack) begin
            oled_data <= oled_data_snack;
        end else if (isNumpadA) begin 
            oled_data <= oled_data_A;
        end else if (isNumpadB) begin
            oled_data <= oled_data_B;
        end else if (isNumpadC) begin
            oled_data <= oled_data_C;
        end else if (isNumpadD) begin
            oled_data <= oled_data_D;
        end else if (isNumpadE) begin
            oled_data <= oled_data_E;
        end else if (isNumpadF) begin
            oled_data <= oled_data_F;                                                         
        end else begin
            oled_data <= 16'h0000;
        end
    end
    
endmodule
