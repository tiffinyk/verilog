//鉴相-环路滤波器
module PD_LoopFilter(rst,clk,di,dq,frequency_df);
	input rst;
	input clk;
	input signed[27:0] di,dq;			//输入数据：32MHz
	output signed[33:0] frequency_df;//环路滤波器输出数据
	
	reg[3:0] count;
	reg signed[27:0] PD;
	reg signed[33:0] sum,loopout;
	always @(posedge clk or posedge rst)
		if(rst)
			begin
				PD<=0;
				count<=0;
				sum<=0;
				loopout<=0;
			end
		else
			//频率字更新周期为16个时钟周期
			begin
				count<=count+1;
				//鉴相器
				if(di[27]==1'b0)
					PD<=dq;
				else
					PD<=-dq;
				//环路滤波器中的累加寄存器
				if(count==4'b1100)
					sum<=sum+{{16{PD[27]}},PD[27:10]};
				if(count==4'b1101)
					loopout<=sum+{{11{PD[27]}},PD[27:5]};
			end
			
		assign frequency_df=loopout;
endmodule
