transcript on
if ![file isdirectory Dpsk_iputf_libs] {
	file mkdir Dpsk_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
vlib Dpsk_iputf_libs/nco_ii_0
vmap nco_ii_0 ./Dpsk_iputf_libs/nco_ii_0
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 

file copy -force D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0_sin.hex ./
file copy -force D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0_cos.hex ./

vlog "D:/MINI_FPGA/Dpsk/my_nco/simulation/submodules/my_nco_nco_ii_0.vo" -work nco_ii_0
vlog "D:/MINI_FPGA/Dpsk/my_nco/simulation/my_nco.v"                                    

vlog -vlog01compat -work work +incdir+D:/MINI_FPGA/Dpsk {D:/MINI_FPGA/Dpsk/my_fir.vo}
vlog -vlog01compat -work work +incdir+D:/MINI_FPGA/Dpsk {D:/MINI_FPGA/Dpsk/Dpsk.v}
vlog -vlog01compat -work work +incdir+D:/MINI_FPGA/Dpsk {D:/MINI_FPGA/Dpsk/mult.v}
vlog -vlog01compat -work work +incdir+D:/MINI_FPGA/Dpsk {D:/MINI_FPGA/Dpsk/PD_LoopFilter.v}
vlib my_fir
vmap my_fir my_fir
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/dspba_library_package.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/auk_dspip_math_pkg_hpfir.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/auk_dspip_avalon_streaming_controller_hpfir.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/auk_dspip_roundsat_hpfir.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/my_fir_0002.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/dspba_library.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/auk_dspip_lib_pkg_hpfir.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/auk_dspip_avalon_streaming_source_hpfir.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/my_fir_0002_rtl.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/auk_dspip_avalon_streaming_sink_hpfir.vhd}
vcom -93 -work my_fir {D:/MINI_FPGA/Dpsk/my_fir/my_fir_0002_ast.vhd}

vlog -vlog01compat -work work +incdir+D:/MINI_FPGA/Dpsk/simulation/modelsim {D:/MINI_FPGA/Dpsk/simulation/modelsim/Dpsk_vlg_tst.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L my_fir -L nco_ii_0 -voptargs="+acc"  Dpsk_vlg_tst

add wave *
view structure
view signals
run 10 ms
