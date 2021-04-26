`define DWIDTH 6

//----------------------------------------------------------------------
// VendingMachine -Top level module
// Just hooks together control and datapath
//----------------------------------------------------------------------
module VendingMachine(clk, rst, nickel, dime, quarter, dispense, done, price, serve, change) ;
  parameter n = `DWIDTH ;
  input clk, rst, nickel, dime, quarter, dispense, done ;
  input [n-1:0] price ;
  output serve, change ;

  wire enough, zero, sub ; 
  wire [3:0] selval ;
  wire [2:0] selnext ;

  VendingMachineControl vmc(clk, rst, nickel, dime, quarter, dispense, done, enough, zero, serve, change, selval, selnext, sub) ;
  VendingMachineData #(n) vmd(clk, selval, selnext, sub, price, enough, zero) ;
endmodule
