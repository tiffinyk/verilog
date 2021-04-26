module Multiple_of_5(in, out) ;
  input [7:0] in ;
  output out ;
  wire [23:0] rem ; // three bits of remainder per cell
  // instantiate 8 copies of the bit cell
  Multiple_of_5_bit b7(in[7],3'b0,rem[23:21]) ;
  Multiple_of_5_bit b6(in[6],rem[23:21],rem[20:18]) ;
  Multiple_of_5_bit b5(in[5],rem[20:18],rem[17:15]) ;
  Multiple_of_5_bit b4(in[4],rem[17:15],rem[14:12]) ;
  Multiple_of_5_bit b3(in[3],rem[14:12],rem[11:9]) ;
  Multiple_of_5_bit b2(in[2],rem[11:9],rem[8:6]) ;
  Multiple_of_5_bit b1(in[1],rem[8:6],rem[5:3]) ;
  Multiple_of_5_bit b0(in[0],rem[5:3],rem[2:0]) ;
  // output is true if remainder out is zero
  assign out = (rem[2:0] == 3'b0) ;
endmodule
