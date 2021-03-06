module pencode83(r,segs);  //SW_In,Digitron_Out
  input wire [7:0]r;
  output wire [6:0]segs;
  
  wire [7:0] g;
  wire [2:0] bin;

  Arbiter #(8) A(r,g);
  Encoder83 E(g,bin);
  sseg S(bin, segs);
endmodule
