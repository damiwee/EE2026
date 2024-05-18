`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2024 11:55:17
// Design Name: 
// Module Name: MUX_control
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


module MUX_control(input clk,input keith_control,input damien_control, 
                   input ari_control,input RJ_control,
                   input keith_control_ari,
                  input ari_rj_control,
                   output reg [7:0] control

    );
    initial begin
    control <= 3;
    //set to 3 for ruijie
    end
    always @ (posedge clk) begin
    
    
    if (ari_control == 1) 
    begin
        control <= 0;    
    end
    
    else if (RJ_control == 1)
    begin
        control<=2;
    end
    
    else if(keith_control == 1)
    begin
        control <= 1;
    end
    
    else if(damien_control == 1) 
    begin
        control <= 0;
    end 
    else if (keith_control_ari == 1)
    begin
        control <= 2;
    end  
    else if (ari_rj_control == 1)
    begin
        control <= 3;
    end
    end
endmodule
