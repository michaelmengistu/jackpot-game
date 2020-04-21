`timescale 1ns / 1ps


module pos_edge(posEdge, CLOCK, switch);
  
  /*input and output ports*/
  input wire CLOCK;
  input wire switch;
  output wire posEdge;
  
  reg swDelay; //delay of siwtch
  
  /* delays the siwtch by its clock*/
  always @ (posedge CLOCK)
    swDelay <= switch;

  assign posEdge =  ~swDelay & switch; //positive Edge triggered logic
  
  
endmodule 