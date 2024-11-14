# Fix for https://adaptivesupport.amd.com/s/question/0D54U00005Sgst2SAB/failed-batch-mode-execution-in-linux-docker-running-under-windows-host?language=en_US
export LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1
vivado -mode batch -source scripts/recreate_prj.tcl 
vivado -mode batch -source scripts/build_bitstream.tcl 
vivado -mode batch -source scripts/export_design.tcl 
