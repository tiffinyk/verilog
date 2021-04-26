//---------------------------------------------
// define state assignment - one hot 
//---------------------------------------------
`define SWIDTH 4
`define GNS 4'b1000
`define YNS 4'b0100
`define GEW 4'b0010
`define YEW 4'b0001
//---------------------------------------------
// define output codes
//---------------------------------------------
`define GNSL 6'b100001
`define YNSL 6'b010001
`define GEWL 6'b001100
`define YEWL 6'b001010
//------------------------------------------------------
// Traffic_Light
// Inputs:
// clk - system clock
// rst - reset - high true
// carew - car east/west - true when car is waiting in east-west direction
// Outputs:
// lights - (6 bits) {gns, yns, rns, gew, yew, rew}
// Waits in state GNS until carew is true, then sequences YNS, GEW, YEW
// and back to GNS.
//------------------------------------------------------
module Traffic_Light(clk, rst, carew, lights) ;
  input clk ;
  input rst ; // reset
  input carew ; // car present on east-west road
  output [5:0] lights ; // {gns, yns, rns, gew, yew, rew}
  wire [`SWIDTH-1:0] state, next ; // current and next state
  reg [`SWIDTH-1:0] next1 ; // next state w/o reset
  reg [5:0] lights ; // output - six lights 1=on
  // instantiate state register
  DFF #(`SWIDTH) state_reg(clk, next, state) ;
  // next state and output equations - this is combinational logic
  always @(state or carew) begin
    case(state) 
      `GNS: {next1, lights} = {(carew ? `YNS : `GNS), `GNSL} ;
      `YNS: {next1, lights} = {`GEW, `YNSL} ;
      `GEW: {next1, lights} = {`YEW, `GEWL} ;
      `YEW: {next1, lights} = {`GNS, `YEWL} ;
      default: {next1, lights} = {`SWIDTH+6{1'bx}} ;
    endcase
  end 
  // add reset
  assign next = rst ? `GNS : next1 ;
endmodule
