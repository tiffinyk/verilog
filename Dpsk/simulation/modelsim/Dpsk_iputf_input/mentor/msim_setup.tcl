
file copy -force D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0_sin.hex ./
file copy -force D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0_cos.hex ./

vlog "D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0.vo" -work nco_ii_0
vlog "D:/MINI_FPGA/Dpsk/my_nco/simulation/my_nco.v"                                    
