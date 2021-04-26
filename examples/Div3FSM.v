`define AWIDTH 2
`define A 0
`define B 1
`define C 2
`define D 3
module Div3FSM(clk, rst, in, out) ;
  input clk, rst, in ;
  output out ;
  wire [`AWIDTH-1:0] state ; // current state 
  reg [`AWIDTH-1:0] next ; // next state
  // instantiate state register
  DFF #(`AWIDTH) state_reg(clk, next, state) ;

  // next state function
  always @(*) begin
    case(state)
      `A: next = rst ? `A : (in ? `B : `A) ;
      `B: next = rst ? `A : (in ? `C : `B) ;
      `C: next = rst ? `A : (in ? `D : `C) ;
      `D: next = rst ? `A : (in ? `B : `A) ;
      default: next = `A ;
    endcase
  end
  // output function
  assign out = (state == `D) ;
endmodule
