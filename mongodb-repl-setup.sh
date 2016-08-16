#!/bin/bash

# Pre-requisites
# Install linux vm with attached data disks 
# Script based on 4x Data disks 

# Enable swap file on the linux machine through azure agent file waagent.conf and disable selinux using the ex search replace editor

ex -s +%s/ResourceDisk.EnableSwap=n/ResourceDisk.EnableSwap=y/g +%p +x /etc/waagent.conf
ex -s +%s/ResourceDisk.SwapSizeMB=0/ResourceDisk.SwapSizeMB=5120/g +%p +x /etc/waagent.conf

ex -s +%s/SELINUX=enforcing/SELINUX=disabled/g +%p +x /etc/selinux/config

# install mdam

yum -y install mdadm

# configure partition on each disk, config blow is based on 4 attached data disks

fdisk /dev/sdc <<EOF
n
p
1


t
fd
W
EOF

fdisk /dev/sdd <<EOF
n
p
1


t
fd
w
EOF

fdisk /dev/sde <<EOF
n
p
1


t
fd
w
EOF


fdisk /dev/sdf <<EOF
n
p
1


t
fd
w

EOF

# Create the raid device using 4 data disks- DataRaid

mdadm --create /dev/md127 --level 0 --raid-devices 4  /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1

# Create the file system on the new RAID device

mkfs.xfs /dev/md127

# Create a directory which you want to mount to the new disk. mkdir /data_disk 

mkdir /data_disk

# Change Permissions

chmod 755 /data_disk
