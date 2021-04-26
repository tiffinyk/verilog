module select_minimun(a,b,c,min);
  parameter n = 8;
  input [n-1:0] a,b,c;
  output [n-1:0] min;
  wire st1,st2;
  wire [n-1:0] sml;

  Mux mx1(a,b,st1,sml);
  Mux mx2(sml,c,st2,min);
endmodule
