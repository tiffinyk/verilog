`define QUARTER 1
`define DIME    2
`define NICKEL  5

module VendingMachineData(clk, selval, selnext, sub, price, enough, zero) ;
  parameter n = 6 ;
  input clk, sub ;
  input [3:0] selval ; // price, 1, 2, 5
  input [2:0] selnext ; // amount, sum, 0
  input [n-1:0] price ; // price of soft drink - in nickels
  output enough ; // amount > price
  output zero ; // amount = zero
  wire [n-1:0] sum ; // output of add/subtract unit
  wire [n-1:0] amount ; // current amount
  wire [n-1:0] next ; // next amount
  wire [n-1:0] value ; // value to add or subtract from amount
  wire ovf ; // overflow - ignore for now
  // state register holds current amount
  DFF #(n) amt(clk, next, amount) ;
  // select next state from 0, sum, or hold
  Mux3 #(n) nsmux({n{1'b0}}, sum, amount, selnext, next) ;
  // add or subtract a value from current amount
  AddSub #(n) add(amount, value, sub, sum, ovf) ;
  // select the value to add or subtract
  Mux4 #(n) vmux(`QUARTER, `DIME, `NICKEL, price, selval, value) ;
  // comparators
  wire enough = (amount >= price) ;
  wire zero = (amount == 0) ;
endmodule
