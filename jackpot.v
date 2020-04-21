`timescale 1ns / 1ps

module jackpot(LEDS, SWITCHES, RESET, CLOCK);
  
  /*input and output ports*/
  input wire RESET, CLOCK;
  input wire [3:0] SWITCHES;
  output wire [3:0] LEDS;
  
  wire newCLOCK;
  
  /*changes clock to 1Hz second*/
  divide_clock ClockDivide(newCLOCK, CLOCK, RESET);
  
  /*states of leds*/
  parameter led1 = 4'b0001, led2=4'b0010, led3=4'b0100, led4=4'b1000, ledWIN=4'b1111 ;
  
  reg [3:0] nextLED, currentLED; //keeps track of next state and current state
  
  /*one-hot state machine for LEDS*/
   always@(currentLED)begin
      case (currentLED)
        led1:
          nextLED = led2;
        led2:
          nextLED = led3;
        led3:
          nextLED = led4;
        led4:
          nextLED = led1;
        ledWIN:
          nextLED = ledWIN;
        default:
          nextLED = led1;
       endcase
  end
  
  wire [3:0] posSW; //positve edge of SWITCHES
  
  /*finds when a switch is on its positve edge*/
  pos_edge sw1(posSW[0], newCLOCK, SWITCHES[0]);
  pos_edge sw2(posSW[1], newCLOCK, SWITCHES[1]);
  pos_edge sw3(posSW[2], newCLOCK, SWITCHES[2]);
  pos_edge sw4(posSW[3], newCLOCK, SWITCHES[3]);

    
  /*synchronous logic*/
  always@(posedge newCLOCK or posedge RESET)begin
    if(RESET) //reset leds
      currentLED <= led1;
    else if(posSW == currentLED) //checks for win state
      currentLED <= ledWIN;
    else //next states of leds
      currentLED <= nextLED;
  end
  
  assign LEDS = currentLED; 
 
endmodule
