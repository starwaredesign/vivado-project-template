set ncpu [exec nproc]
set project_file [glob -directory vivado *.xpr]
open_project ${project_file}
set project_name [get_property NAME [current_project]]
write_hw_platform -fixed -include_bit -force -file vivado/${project_name}_wrapper.xsa

