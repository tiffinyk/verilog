//-----------------------------------------------
// test bench
//-----------------------------------------------
module test_fsm2 ;
  reg clk, rst, in ;
  wire out ;
  Div3FSM dl(clk, rst, in, out) ;
  // clock with period of 10 units
  initial begin
    clk = 1 ; #5 clk = 0 ;
    forever
      begin
        $display("%b %b %b %b", rst, in, dl.state, out ) ;
        #5 clk = 1 ; #5 clk = 0 ;
      end
    end
  // input stimuli
  initial begin
    rst = 0 ; in = 0; // start w/o reset to show x state
    #15 rst = 1 ; in = 0 ; // reset
    #10 rst = 0 ; // remove reset
    #30 in = 1 ; // wait 3 cycles, then car arrives
    #10 in = 0 ; // car leaves
    #60 in = 1 ; // wait 6 cycles then car comes and stays
    #80 // 8 more cycles
    $stop ;
  end
endmodule
