module PPTProgPriArb(r, p, g) ;
  parameter n=8 ;
  input [n-1:0] r ;
  input [n-1:0] p ;
  output [n-1:0] g ;
  wire [2*n-1:0] c ;
  wire [n-1:0] g ;
  assign c = ({~r[n-2:0], ~r, ~r[n-1]} & {c[2*n-2:0],1'b0}) | {{n{1'b0}},p};
  assign g = r & (c[2*n-1:n] | c[n-1:0]) ;
endmodule
