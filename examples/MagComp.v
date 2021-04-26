module MagComp(a,b,st);
  parameter n=8;
  input [n-1:0] a,b;
  output st;
  assign st = (a<b);
endmodule
