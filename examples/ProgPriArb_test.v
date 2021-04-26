module ProgPriArb_test;
  reg [7:0] r;
  reg [7:0] p;
  wire [7:0] g;
  wire [15:0] c;
  ProgPriArb PPA0(r, p, g);
  initial begin
    r=0;
    p=8;
    repeat (256) begin
      #100
      $display("r = %8b  p = %8b  c = %16b  g = %8b",r,p,c,g);
      r=r+1;
    end
  end
endmodule
