//顶层模块文件
module Dpsk(rst,clk,din,datai,dataq,df);
	input rst;	//复位信号，高电平有效
	input clk;	//FPGA系统时钟：32MHz
	input signed[7:0]   din;	//输入数据：4MHz
	output signed[27:0] datai;	//同相支路输出数据
	output signed[27:0] dataq;	//正交支路输出数据
	output signed[27:0] df;		//环路滤波器输出数据
	
	//实例化NCO核
	wire reset_n,out_valid,clken;
	wire signed [33:0] carrier;
	wire signed [9:0] sine,cosine;
	wire signed [33:0] frequency_df;
	assign reset_n=!rst;
	assign clken=1'b1;
	assign carrier=34'd3221225472;//6MHz
	
	my_nco u0(
		.clk        (clk),        // clk.clk
		.reset_n    (reset_n),    // rst.reset_n
		.clken      (clken),      //  in.clken
		.phi_inc_i  (carrier),  //    .phi_inc_i
		.freq_mod_i (frequency_df), //    .freq_mod_i
		.fsin_o     (sine),     // out.fsin_o
		.fcos_o     (cosine),     //    .fcos_o
		.out_valid  (out_valid)   //    .out_valid
	);
	
	//实例化2个乘法器核
	wire signed[17:0]mdq,mdi;
	mult u1(
		.clock(clk),
		.dataa(din),
		.datab(cosine),
		.result(mdq));
	
	mult u2(
		.clock(clk),
		.dataa(din),
		.datab(sine),
		.result(mdi));
	
	//实例化2个低通滤波器核
	wire signed [27:0] di,dq;
	wire ast_sink_valid,ast_source_ready;
	wire ast_sink_readyi,ast_sink_readyq,ast_source_validi,ast_source_validq;
	wire [1:0]ast_sink_error,ast_source_errori,ast_source_errorq;
	assign ast_sink_valid=1'b1;
	assign ast_source_ready = 1'b1;
	assign ast_sink_error=2'b00;
	my_fir u3 (
		.clk              (clk),              //                     clk.clk
		.reset_n          (reset_n),          //                     rst.reset_n
		.ast_sink_data    (mdi[16:1]),    //   avalon_streaming_sink.data
		.ast_sink_valid   (ast_sink_valid),   //                        .valid
		.ast_sink_error   (ast_sink_error),   //                        .error
		//.ast_sink_ready(ast_sink_readyi),
		.ast_source_data  (di),  // avalon_streaming_source.data
		.ast_source_valid (ast_source_validi), //                        .valid
		.ast_source_error (ast_source_errori),  //                        .error
		//.ast_source_ready(ast_source_ready)
	);
	
	my_fir u4 (
		.clk              (clk),              //                     clk.clk
		.reset_n          (reset_n),          //                     rst.reset_n
		.ast_sink_data    (mdq[16:1]),    //   avalon_streaming_sink.data
		.ast_sink_valid   (ast_sink_valid),   //                        .valid
		.ast_sink_error   (ast_sink_error),   //                        .error
		//.ast_sink_ready(ast_sink_readyq),
		.ast_source_data  (dq),  // avalon_streaming_source.data
		.ast_source_valid (ast_source_validq), //                        .valid
		.ast_source_error (ast_source_errorq),  //                        .error
		//.ast_source_ready(ast_source_ready)
	);
	
	PD_LoopFilter u5(
		.rst(rst),
		.clk(clk),
		.di(di),
		.dq(dq),
		.frequency_df(frequency_df)
	);
	
	assign df=frequency_df[27:0];
	assign datai=di;
	assign dataq=dq;
	
endmodule
