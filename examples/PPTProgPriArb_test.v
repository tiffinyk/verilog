module PPTProgPriArb_test;
  parameter n=8;
  reg [n-1:0] r;
  reg [n-1:0] p;
  wire [2*n-1:0] c;
  wire [n-1:0] g;
  PPTProgPriArb PPT0(r,p,g);
  initial begin
    r=0;
    p=4;
    //c=0;
    repeat (256) begin
      #100
      $display("r=%8b  p=%8b  c=%16b  g=%8b",r,p,c,g);
      r=r+1;
    end
  end
endmodule
