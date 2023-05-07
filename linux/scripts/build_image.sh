#!/bin/bash
if [ -z "$1" ]
then
  echo "Project name required"
  exit -1
fi
echo "Project name $1"
cd $1
petalinux-config --silentconfig --get-hw-description ../../fpga/vivado/${1}_wrapper.xsa
petalinux-build
petalinux-package --force --boot --fpga ../../fpga/vivado/${1}.runs/impl_1/${1}_wrapper.bit --uboot
cd ..

