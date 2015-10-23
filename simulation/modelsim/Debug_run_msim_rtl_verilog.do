transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2 {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2/InstMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2 {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2/Register.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2 {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2/Project2.v}
vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2 {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2/PLL.v}

vlog -vlog01compat -work work +incdir+C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2 {C:/Users/Fawks/Documents/cs3220/Project2/SCProcLukeStubbs/Project2/Project2/dprf_testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  Project2.v

add wave *
view structure
view signals
run -all
