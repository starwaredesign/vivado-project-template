set ncpu [exec nproc]
set project_file [glob -directory vivado *.xpr]
set utilisation_file utilisation.csv
open_project ${project_file}

# configure the system version block if present
set project_name [get_property NAME [current_project]]
open_bd_design "bd/${project_name}/${project_name}.bd"
set systemversion_block [get_bd_cells *systemversion*]
if {$systemversion_block ne ""} then {
	if {[info exists ::env(CI_COMMIT_SHORT_SHA)]} {
		set build_number "0x$::env(CI_COMMIT_SHORT_SHA)" 
	} else {
		set build_number "0xFFFFFFFF"
	}
	puts "Build number ${build_number}"
	set_property CONFIG.C_VER_BUILD $build_number $systemversion_block
	validate_bd_design
	save_bd_design
}
close_bd_design [current_bd_design]

# build the bitstream
launch_runs impl_1 -to_step write_bitstream -jobs ${ncpu}
wait_on_run impl_1

# create CSV file with resource utilisation
namespace import ::tclapp::xilinx::designutils::report_failfast
open_run [current_run -implementation -quiet]
report_failfast -csv -transpose -no_header -file ${utilisation_file}
exec sed /^#/d -i ${utilisation_file}
exec sed /^"Description"/d -i ${utilisation_file}
exec sed /^$/d -i ${utilisation_file}
exec sed s/\"//g -i ${utilisation_file}
close_design
