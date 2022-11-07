#!/bin/bash
#
# Copyright (C) 2015-2016, Intel Corporation.
# All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

POKY_KNOWN_COMMIT=${POKY_COMMIT:-"8daedc01101e686fc640c164004c0ec4e5f90b4e"}
META_ZEPHYR_SDK_SOURCE=${SDK_SOURCE:-"meta-zephyr-sdk"}
META_POKY_SOURCE=${POKY_SOURCE:-"poky"}
META_ZEPHYR_SDK_SOURCE=$(readlink -f $META_ZEPHYR_SDK_SOURCE)
META_POKY_SOURCE=$(readlink -f $META_POKY_SOURCE)

if [ ! -d $META_ZEPHYR_SDK_SOURCE ] ; then
	echo "ERROR: could not find $META_ZEPHYR_SDK_SOURCE"
	exit 1
fi

if [ ! -d $META_POKY_SOURCE ] ; then
	git clone https://github.com/zephyrproject-rtos/poky.git
	META_POKY_SOURCE=$(readlink -f "poky")
fi

# Checkout the commit known to build...
cd $META_POKY_SOURCE
git checkout $POKY_KNOWN_COMMIT
