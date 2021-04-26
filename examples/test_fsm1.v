//-----------------------------------------------
// test bench
//-----------------------------------------------
module test_fsm1 ;
  reg clk, rst, carew ;
  wire [5:0] lights ;
  Traffic_Light tl(clk, rst, carew, lights) ;
  // clock with period of 10 units
  initial begin
    clk = 1 ; #5 clk = 0 ;
    forever
      begin
        $display("%b %b %b %b", rst, carew, tl.state, lights ) ;
        #5 clk = 1 ; #5 clk = 0 ;
      end
    end
  // input stimuli
  initial begin
    rst = 0 ; carew = 0; // start w/o reset to show x state
    #15 rst = 1 ; carew = 0 ; // reset
    #10 rst = 0 ; // remove reset
    #30 carew = 1 ; // wait 3 cycles, then car arrives
    #10 carew = 0 ; // car leaves
    #60 carew = 1 ; // wait 6 cycles then car comes and stays
    #80 // 8 more cycles
    $stop ;
  end
endmodule
