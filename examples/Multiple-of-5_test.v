module Multiple_of_5_test;
  reg [7:0] in ;
  reg error ;
  wire out ;
  
  Multiple_of_5 m(in, out);
  initial begin
    in = 0; error = 0;
    repeat(256) begin
      #100
      $display("%d  %b",in,out);
      if(out !== ((in%5) == 0))  begin
        $display("ERROR  %d -> %b",in,out);
        error = 1;
      end
      in = in + 1;
    end
    if(error == 0) $display("PASS");
  end
endmodule
