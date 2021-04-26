
cp -f D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0_sin.hex ./
cp -f D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0_cos.hex ./

vlogan +v2k "D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0.vo" -work nco_ii_0
vlogan +v2k "D:/MINI_FPGA/Dpsk/my_nco/simulation/my_nco.v"                                    
