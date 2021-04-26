module test_multiple_of_3;
  reg [3:0] in;
  wire out;

  multiple_of_3 m0(in, out);

  initial begin
    in=0;
    repeat (16) begin
      #100
      $display("in = %2d  out = %1b", in, out);
      in = in+1;
    end
  end
endmodule
