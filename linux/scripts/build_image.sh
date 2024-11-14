#!/bin/bash
if [ -z "$1" ]
then
  echo "Project name required"
  exit -1
fi
echo "Project name $1"
cd $1
petalinux-config -D --silentconfig --get-hw-description ../../fpga/vivado/${1}_wrapper.xsa
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS CI_COMMIT_SHORT_SHA"
petalinux-build
petalinux-package boot --force --fpga ../../fpga/vivado/${1}.runs/impl_1/${1}_wrapper.bit --uboot
cd ..

