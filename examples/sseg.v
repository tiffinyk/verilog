// define segment codes
// seven bit code - one bit per segment, segment is illuminated when
// bit is high. Bits 6543210 correspond to:
// 	6666
//      1  5
// 	1  5
// 	0000
// 	2  4
// 	2  4
// 	3333 
//----------------------------------------------------------------------
`define SS_0 7'b1111110 
`define SS_1 7'b0110000
`define SS_2 7'b1101101
`define SS_3 7'b1111001
`define SS_4 7'b0110011
`define SS_5 7'b1011011
`define SS_6 7'b1011111
`define SS_7 7'b1110000
//`define SS_8 7'b1111111
//`define SS_9 7'b1111011

module sseg(bin, segs);
  input  [2:0] bin;
  output [6:0] segs;
  reg    [6:0] segs;

  always@(*) begin
    case(bin)
      0: segs = `SS_0;
      1: segs = `SS_1;
      2: segs = `SS_2;
      3: segs = `SS_3;
      4: segs = `SS_4;
      5: segs = `SS_5;
      6: segs = `SS_6;
      7: segs = `SS_7;
      //8: segs = `SS_8;
      //9: segs = `SS_9;
      default: segs = 7'b0000000;
    endcase
  end
endmodule
