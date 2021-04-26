`define PRICE 11
module testVend;
  reg clk,rst,nickel,dime,quarter,dispense,done;
  reg [3:0] price;
  wire serve,change;
  
  VendingMachine #(4) vm(clk,rst,nickel,dime,quarter,dispense,done,price,serve,change);
  //clock with period of 10 units
  initial begin
    clk = 1; #5 clk=0;
    forever
      begin
        $display("%b %h %h %b %b",{nickel,dime,quarter,dispense},vm.vmc.state, vm.vmd.amount,serve,change);
        #5 clk=1;#5 clk=0;
      end
    end
  //give prompt feedback
  always @(posedge clk) begin
    done = (serve|change);
  end

  initial begin
    rst=1; {nickel,dime,quarter,dispense}=4'b0000;price=`PRICE ;
    #25 rst=0;
    #10 {nickel,dime,quarter,dispense}=4'b1000;
    #10 {nickel,dime,quarter,dispense}=4'b0100;
    #10 {nickel,dime,quarter,dispense}=4'b0000;
    #10 {nickel,dime,quarter,dispense}=4'b0001;
    #10 {nickel,dime,quarter,dispense}=4'b0010;
    #10 {nickel,dime,quarter,dispense}=4'b0010;
    #10 {nickel,dime,quarter,dispense}=4'b0000;
    #10 {nickel,dime,quarter,dispense}=4'b0001;
    #10 dispense=0;
    #100 $stop;
  end
endmodule
