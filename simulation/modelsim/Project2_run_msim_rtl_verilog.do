transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/SignExtension.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/DataMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/DPRF.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/SevenSeg.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/PLL.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/instmemory.v}

vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/controller_testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  controller_testbench

add wave *
view structure
view signals
run -all
