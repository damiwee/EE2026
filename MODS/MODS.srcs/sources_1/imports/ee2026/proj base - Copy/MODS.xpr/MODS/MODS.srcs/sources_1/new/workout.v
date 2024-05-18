`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2024 23:42:28
// Design Name: 
// Module Name: workout
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


module workout(
    output reg isEnd,
    input [9:0] pushUpCount,
    input [9:0] pullUpCount,
    input [9:0] sitUpCount,
    input [31:0] runCount,
    input [7:0]control,
    input clk,
    input [15:12] sw,
    input btnC,
    input btnL,
    output reg [15:0] led,
    output reg [7:0] digitsToDisplay1,
    output reg [7:0] digitsToDisplay2, 
    output reg [7:0] digitsToDisplay3, 
    output reg [7:0] digitsToDisplay4,     
    output reg isUp = 1,
    input isSitUp,
    input isPushUp,
    input isPullUp,
    input isRun,
    output reg [31:0] sec
    );
    
    
    reg [9:0] countUpTo;
    
    always @ (posedge clk) begin
        if (isPushUp) begin
            countUpTo <= pushUpCount;
        end
        else if (isSitUp) begin
            countUpTo <= sitUpCount; 
        end
        else if (isPullUp) begin
            countUpTo <= pullUpCount;
        end
    end
    
    wire clk_20;
    wire clk_10;
    wire clk_5;
    wire clk_2p5;
    
    flexible_clock clk20(clk, 2499999, clk_20);
    flexible_clock clk10(clk, 4999999, clk_10);
    flexible_clock clk5(clk, 9999999, clk_5);
    flexible_clock clk2p5(clk, 19999999, clk_2p5);
    
    wire clk_1;
    flexible_clock clk1(clk, 49999999, clk_1);
    
    reg [10:0] digits = 0;
    reg [5:0] tempDigits1;
    reg [5:0] tempDigits2;
    reg [5:0] tempDigits3;
    reg [5:0] tempDigits4;
    reg [1:0] anode; //2 bits to obtain 4 different states for anodes 0-3
    reg [19:0] countSevenSeg; //used as a counter to control refresh period of sevenSeg
    
    //Parameters to assign correct binary digits to 7-segment
    parameter zero = 8'b11000000; //MSB Cathode A...LSB Cathode G
    parameter one = 8'b11111001;
    parameter two = 8'b10100100;
    parameter three = 8'b10110000;
    parameter four = 8'b10011001;
    parameter five = 8'b10010010;
    parameter six = 8'b10000010;
    parameter seven = 8'b11111000;
    parameter eight = 8'b10000000;
    parameter nine = 8'b10011000;
    
    parameter zero_dot = 8'b01000000; //MSB Cathode A...LSB Cathode G
    parameter one_dot = 8'b01111001;
    parameter two_dot = 8'b00100100;
    parameter three_dot = 8'b00110000;
    parameter four_dot = 8'b00011001;
    parameter five_dot = 8'b00010010;
    parameter six_dot = 8'b00000010;
    parameter seven_dot = 8'b01111000;
    parameter eight_dot = 8'b00000000;
    parameter nine_dot = 8'b00011000;
    
   //DIGIT Decoding
    always @ (tempDigits1) //anytime digit to decode changes
        begin
            case(tempDigits1)
            0: digitsToDisplay1 = zero;
            1: digitsToDisplay1 = one;
            2: digitsToDisplay1 = two;
            3: digitsToDisplay1 = three;
            4: digitsToDisplay1 = four;
            5: digitsToDisplay1 = five;
            6: digitsToDisplay1 = six;
            7: digitsToDisplay1 = seven;
            8: digitsToDisplay1 = eight;
            9: digitsToDisplay1 = nine;
            default: digitsToDisplay1 = 8'b11111111;
        endcase
    end
    
    always @ (tempDigits2) //anytime digit to decode changes
        begin
            case(tempDigits2)
            0: digitsToDisplay2 = zero;
            1: digitsToDisplay2 = one;
            2: digitsToDisplay2 = two;
            3: digitsToDisplay2 = three;
            4: digitsToDisplay2 = four;
            5: digitsToDisplay2 = five;
            6: digitsToDisplay2 = six;
            7: digitsToDisplay2 = seven;
            8: digitsToDisplay2 = eight;
            9: digitsToDisplay2 = nine;
            default: digitsToDisplay2 = 8'b11111111;
            endcase
        end
        
    always @ (tempDigits3) //anytime digit to decode changes
        begin
            if (isRun == 0) begin
                case(tempDigits3)
                    0: digitsToDisplay3 = zero;
                    1: digitsToDisplay3 = one;
                    2: digitsToDisplay3 = two;
                    3: digitsToDisplay3 = three;
                    4: digitsToDisplay3 = four;
                    5: digitsToDisplay3 = five;
                    6: digitsToDisplay3 = six;
                    7: digitsToDisplay3 = seven;
                    8: digitsToDisplay3 = eight;
                    9: digitsToDisplay3 = nine;
                    default: digitsToDisplay3 = 8'b11111111;
                endcase
            end
            
            else begin
                case(tempDigits3)
                    0: digitsToDisplay3 = zero_dot;
                    1: digitsToDisplay3 = one_dot;
                    2: digitsToDisplay3 = two_dot;
                    3: digitsToDisplay3 = three_dot;
                    4: digitsToDisplay3 = four_dot;
                    5: digitsToDisplay3 = five_dot;
                    6: digitsToDisplay3 = six_dot;
                    7: digitsToDisplay3 = seven_dot;
                    8: digitsToDisplay3 = eight_dot;
                    9: digitsToDisplay3 = nine_dot;
                    default: digitsToDisplay3 = 8'b11111111;
                endcase
            end
    end
            
    always @ (tempDigits4) //anytime digit to decode changes
        begin
            case(tempDigits4)
            0: digitsToDisplay4 = zero;
            1: digitsToDisplay4 = one;
            2: digitsToDisplay4 = two;
            3: digitsToDisplay4 = three;
            4: digitsToDisplay4 = four;
            5: digitsToDisplay4 = five;
            6: digitsToDisplay4 = six;
            7: digitsToDisplay4 = seven;
            8: digitsToDisplay4 = eight;
            9: digitsToDisplay4 = nine;
            default: digitsToDisplay4 = 8'b11111111;
        endcase
    end
        
    //ANODE and CATHODE Decoding
    always @ (anode) //Whenever an changes
    begin
        if (isRun == 0 && (isSitUp || isPushUp || isPullUp)) begin
            case (anode)
                0: begin
                   tempDigits1 = digits % 10;
                   end            
                1: begin
                   tempDigits2 = (digits / 10) % 10;
                   end   
                2: begin
                   tempDigits3 = (digits / 100) % 10;
                   end   
                3: begin
                   tempDigits4 = (digits / 1000) % 10;
                   end   
                endcase
        end
        
        else if (isRun == 1 && ~(isSitUp || isPushUp || isPullUp)) begin
            case (anode)
                0: begin
                   tempDigits1 = (sec % 60)  % 10;
                   end            
                1: begin
                   tempDigits2 = ((sec % 60) / 10) % 10;
                   end   
                2: begin
                   tempDigits3 = (sec / 60) % 10;
                   end   
                3: begin
                   tempDigits4 = ((sec / 60) / 10) % 10;
                   end   
            endcase
        end
    end
        
    
    reg ledClk;
        
    always @ (posedge clk) begin
        if (isRun == 0 && (isSitUp || isPushUp || isPullUp)) begin
            casex({sw[14],sw[13],sw[12]})
                3'b000: begin
                    ledClk <= clk_20;
                end
                3'b001: begin
                    ledClk <= clk_10;
                end
                3'b01x: begin
                    ledClk <= clk_5;
                end
                3'b1xx: begin;
                    ledClk <= clk_2p5;
                end
            endcase
        end
        
        else if (isRun == 1 && ~(isSitUp || isPushUp || isPullUp)) begin
            ledClk <= clk_1;
        end
        
        else begin
            ledClk <= clk_20;
        end
    end
    
    reg [3:0] COUNT = 0;
    reg direction = 1'b0;
    reg [31:0] timeLeft;
    
    always @ (posedge clk) begin
        timeLeft = ((sec-1) * 10) / runCount;
        // Ceiling rounding: if there is any fractional part, round up
        if (( (sec-1) * 10) % runCount != 0)
            timeLeft = timeLeft + 1;
    end

    always @ (posedge ledClk or posedge btnC or posedge btnL)
    begin
        if (btnC || btnL || control != 1) begin
            if (isRun && btnC) begin
                led <= 16'b0000001111111111;
            end
            else begin
                led <= 0; 
            end            
            direction <= 0;
            COUNT <= 0;
            digits <= 0;
            isUp <= 1;
            sec <= runCount;
            isEnd <= 0;
        end
        else if (isRun == 0 && (isSitUp || isPushUp || isPullUp) && control == 1) begin
            sec <= 0;

            if(sw[15] == 1 || digits == countUpTo || isEnd) begin
               digits <= digits;
               COUNT <= COUNT;
               led <= led;
               direction <= direction;
               isUp <= isUp;
               if (digits == countUpTo) begin
                   isEnd <= 1;
               end
               
               else begin
                   isEnd <= 0;
               end
            end
            else if (COUNT < 10 && !direction) begin
                led <= led * 2;
                led[0] <= 1;
                COUNT <= COUNT + 1;
            end
            else if (COUNT > 0 && direction) begin
                led <= led / 2;
                COUNT <= COUNT - 1;
            end
            else begin
                if (direction == 1) begin
                    digits <= digits + 1;
                end
                direction <= ~direction; // Toggle direction when reaching either end of the range
                isUp <= ~isUp;
            end
        end
        
        //running mode aka stopwatch
        else if (isRun == 1 && ~(isSitUp || isPushUp || isPullUp)) begin
            //led <= 0;
            direction <= 0;
            COUNT <= 0;
            digits <= 0;
            isUp <= 1;
            
            if (sec == 0) begin
                isEnd <= 1;
            end
           
            else begin
                isEnd <= 0;
            end
            
            if (sw[15] == 1 || isEnd) begin
                sec <= sec;
                led <= led;
            end
            
            else begin
                sec <= (sec == 0) ? 0 : sec - 1;
                if (timeLeft == 0) begin
                    led = 16'b0000000000000000;
                end
                else if (timeLeft == 1) begin
                    led = 16'b0000000000000001;
                end
                else if (timeLeft == 2) begin
                    led = 16'b0000000000000011;
                end
                else if (timeLeft == 3) begin
                    led = 16'b0000000000000111;
                end
                else if (timeLeft == 4) begin
                    led = 16'b0000000000001111;
                end
                else if (timeLeft == 5) begin
                    led = 16'b0000000000011111;
                end
                else if (timeLeft == 6) begin
                    led = 16'b0000000000111111;
                end
                else if (timeLeft == 7) begin
                    led = 16'b0000000001111111;
                end
                else if (timeLeft == 8) begin
                    led = 16'b0000000011111111;
                end
                else if (timeLeft == 9) begin
                    led = 16'b0000000111111111;
                end
                else if (timeLeft == 10) begin
                    led = 16'b0000001111111111;
                end
            end             
        end
        
        else begin
            led <= 0;
            direction <= 0;
            COUNT <= 0;
            digits <= 0;
            isUp <= 1;
            sec <= runCount;
            isEnd <= 0;
        end
    end

        
    always @ (posedge clk or posedge btnC or posedge btnL)
    begin
       if (btnC || btnL)
            begin
                anode <= 0;
            end
       else if (countSevenSeg == 400000)
            begin
                countSevenSeg <= 0;
                anode <= anode + 1'b1;
            end
       else countSevenSeg <= countSevenSeg + 1'b1; //increment
    end
    
endmodule
