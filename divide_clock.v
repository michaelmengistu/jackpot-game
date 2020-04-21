`timescale 1ns / 1ps
`define divisor 27'd125_000_000


module divide_clock(clkOUT, clkIN, rst);
  
  /*input and output ports*/
  input wire clkIN, rst;
  output reg clkOUT;
   
    
    
  reg [31:0] count; //counts the number of times input clock gets devided 
  

  /*keeps track of when to change the output clock*/
  always@(posedge clkIN or posedge rst)begin
    if(rst)begin //reset clock
      clkOUT <= 0;
      count <= 0;
    end
    else if(count < `divisor/2 -1 ) begin 
      clkOUT <= clkOUT;
      count = count + 1'b1;
    end
    else begin
      clkOUT <= ~clkOUT;
      count <= 0;
    end
  end
  
 

endmodule
  
  