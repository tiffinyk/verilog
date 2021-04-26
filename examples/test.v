module pencode83_test;
 reg [7:0] r;
 wire [6:0] segs;
 wire [2:0] bin;
 
 pencode83 PE0(r, segs);
   initial begin
     r = 0;
     repeat (256) begin
     #100
     $display("r = %8b bin = %3b",r,bin);
     r=r+1;
     end
   end
endmodule
