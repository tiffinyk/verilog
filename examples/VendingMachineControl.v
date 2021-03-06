`define SWIDTH 5
`define DEPOSIT 5'b10000
`define SERVE1  5'b01000
`define SERVE2  5'b00100
`define CHANGE1 5'b00010
`define CHANGE2 5'b00001

module VendingMachineControl(clk, rst, nickel, dime, quarter, dispense, done, 
  enough, zero, serve, change, selval, selnext, sub) ;
  input clk, rst, nickel, dime, quarter, dispense, done,enough, zero ;
  output serve, change, sub ;
  output [3:0] selval ;
  output [2:0] selnext ;
  wire [`SWIDTH-1:0] state, next ; // current and next state
  reg [`SWIDTH-1:0] next1 ; // next state w/o reset
  // outputs
  wire first ; // true during first cycle of serve1 or change1
  wire serve1 = (state == `SERVE1) ;
  wire change1 = (state == `CHANGE1) ;
  wire serve = serve1 & first ;
  wire change = change1 & first ;
  // datapath controls
  wire dep = (state == `DEPOSIT) ;
  // price, 1, 2, 5
  wire [3:0] selval = {(dep & dispense), 
  ((dep & nickel)| change), 
  (dep & dime), 
  (dep & quarter)} ;
  // amount, sum, 0
  wire selv = (dep & (nickel | dime | quarter | (dispense & enough))) | (change) ;
  wire [2:0] selnext = {!(selv | rst),selv,rst} ;
  // subtract
  wire sub = (dep & dispense) | change ;
  //only do actions on first cycle of serve1 or change1
  wire nfirst = !(serve1 | change1) ;
  DFF #(1) first_reg(clk, nfirst, first) ;
  // state register
  DFF #(`SWIDTH) state_reg(clk, next, state) ;
  // next state logic
  always @(state or zero or dispense or done or enough) begin
    casex({dispense, enough, done, zero, state})
      {4'b11xx,`DEPOSIT}: next1 = `SERVE1 ; // dispense & enough
      {4'b0xxx,`DEPOSIT}: next1 = `DEPOSIT ;
      {4'bx0xx,`DEPOSIT}: next1 = `DEPOSIT ;
      {4'bxx1x,`SERVE1}: next1 = `SERVE2 ; // done
      {4'bxx0x,`SERVE1}: next1 = `SERVE1 ; 
      {4'bxx01,`SERVE2}: next1 = `DEPOSIT ; // ~done & zero
      {4'bxx00,`SERVE2}: next1 = `CHANGE1 ; // ~done & ~zero
      {4'bxx1x,`SERVE2}: next1 = `SERVE2 ; // done
      {4'bxx1x,`CHANGE1}: next1 = `CHANGE2 ; // done
      {4'bxx0x,`CHANGE1}: next1 = `CHANGE1 ; // ~done
      {4'bxx00,`CHANGE2}: next1 = `CHANGE1 ; // ~done & ~zero
      {4'bxx01,`CHANGE2}: next1 = `DEPOSIT ; // ~done & zero
      {4'bxx1x,`CHANGE2}: next1 = `CHANGE2 ; // done
    endcase
  end
  // reset next state
  assign next = rst ? `DEPOSIT : next1 ;
endmodule
