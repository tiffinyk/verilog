module Dec5to32(a,b);
  input [4:0] a;
  output [31:0] b;
  wire [4:0] x, y;
  
  Dec #(3,8) d0(a[2:0], x);
  Dec #(2,4) d1(a[4:3], y);

  assign b[3:0] = x & {8{y[0]}};
  assign b[7:4] = x & {8{y[1]}};
  assign b[11:8] = x & {8{y[2]}};
  assign b[15:12] = x & {8{y[3]}};
endmodule
