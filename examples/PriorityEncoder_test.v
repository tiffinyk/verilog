module PriorityEncoder83_test;
  reg [7:0] r;
  reg [7:0] p;
  wire [2:0] b;
  //wire [7:0] g;
  PriorityEncoder83 PE0(r, p, b);
  initial begin
    r = 0;
    p = 4;
    repeat (256) begin
      #100
      $display("r = %8b  b = %3b",r,b);
      r=r+1;
    end
  end
endmodule
