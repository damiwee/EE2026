`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2024 04:26:29
// Design Name: 
// Module Name: top
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


module damien(
    input [7:0]control,
    output reg damien_control,
    input clk,
    input [15:12] sw,
    input btnC,
    input btnL,
    input [12:0] pixel_index,
    input [3:0] whichExercise,
    input [9:0] pushUpCount,
    input [9:0] sitUpCount,
    input [9:0] pullUpCount,
    input [31:0] runCount,
    //input [31:0] sec,
    output [15:0] led,
    output [7:0] digitsToDisplay1,
    output [7:0] digitsToDisplay2,
    output [7:0] digitsToDisplay3,
    output [7:0] digitsToDisplay4,
    output reg [15:0] oled_data
    );
    
    always @ (posedge clk) begin
        if (btnL && control == 1) begin
            damien_control <= 1;
        end
        else begin
            damien_control <= 0;
        end
    end
    
    wire clk_7p5;
    wire [15:0]pushup_up_pic;
    wire [15:0]pushup_down_pic;
    wire [15:0]pullup_up_pic;
    wire [15:0]pullup_down_pic;
    wire [15:0]situp_up_pic;
    wire [15:0]situp_down_pic;
    wire [15:0]run1;
    wire [15:0]run2;    
    wire [15:0]run3;    
    wire [15:0]run4;    
    wire [15:0]run5;    
    wire [15:0]run6;   
    wire [15:0]end_screen;
    
    wire isUp;
    wire isSitUp;
    wire isPushUp;
    wire isPullUp;
    wire isRun;
    wire isEnd;
    
    assign isPushUp = whichExercise[0];
    assign isSitUp = whichExercise[1];
    assign isPullUp = whichExercise[2];
    assign isRun = whichExercise[3];
    
    wire [31:0] sec;
    
    workout workout(isEnd, pushUpCount, pullUpCount, sitUpCount, runCount, control, clk, sw[15:12], btnC, btnL, led, digitsToDisplay1, digitsToDisplay2, digitsToDisplay3, digitsToDisplay4, isUp, isSitUp, isPushUp, isPullUp, isRun, sec);
    
    flexible_clock clk10(clk, 6666666, clk_7p5);

    BRAM_pushup_up(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pushup_up_pic));
    BRAM_pushup_down(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pushup_down_pic));
    
    BRAM_pullup_up(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pullup_up_pic));
    BRAM_pullup_down(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(pullup_down_pic));
    
    BRAM_situp_up(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(situp_up_pic));
    BRAM_situp_down(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(situp_down_pic));    
    
    BRAM_run1(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(run1));
    //BRAM_run2(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(run2));  
    BRAM_run3(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(run3));  
    BRAM_run4(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(run4));  
    //BRAM_run5(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(run5));  
    BRAM_run6(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(run6));  
    
    BRAM_end(.clk(clk), .addr(pixel_index), .read_write(0), .clear(0), .data_in(0), .data_out(end_screen)); 
    
    reg [31:0] run_count = 0;
    
    always @(posedge clk_7p5) begin
        if (isRun == 1) begin
            if (btnC) begin
                run_count <= 0;
            end
            else if (sw[15] == 1 || sec == 0) begin
                run_count <= run_count;
            end
            else begin
                run_count <= (run_count == 3) ? 0: run_count + 1;
            end
        end
        else begin
            run_count <= 0;
        end
    end
    
    
    always @ (posedge clk) begin
        if (isEnd == 0) begin
            casex(whichExercise)
                4'b0001: begin
                    if (isUp == 0) begin
                        oled_data <= pushup_up_pic;
                    end
                    else begin
                        oled_data <= pushup_down_pic;
                    end
                end
                
                4'b0010: begin
                    
                    if (isUp == 0) begin
                        oled_data <= situp_up_pic;
                    end
                    else begin
                        oled_data <= situp_down_pic;
                    end
                end
                
                4'b0100: begin
                    if (isUp == 0) begin
                        oled_data <= pullup_up_pic;
                    end
                    else begin
                        oled_data <= pullup_down_pic;
                    end
                end
                
                4'b1000: begin
                    if (run_count == 0 || btnC) begin
                        oled_data <= run1;
                    end
                    else if (run_count == 1) begin
                        oled_data <= run3;
                    end
                    else if (run_count == 2) begin
                        oled_data <= run4;
                    end
                    else if (run_count == 3) begin
                        oled_data <= run6;
                    end
//                    else if (run_count == 4) begin
//                        oled_data <= run5;
//                    end
//                    else if (run_count == 5) begin
//                        oled_data <= run6;
//                    end
                end
                
            endcase
        end
        
        else begin
            oled_data <= end_screen;
        end 
        
    end
endmodule
