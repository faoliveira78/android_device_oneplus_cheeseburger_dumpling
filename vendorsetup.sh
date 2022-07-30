#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2022 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="dumpling"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
        export TARGET_DEVICE_ALT="cheeseburger"
        export OF_TARGET_DEVICES="cheeseburger,dumpling"
        export FOX_VARIANT="A12"
        export OF_USE_GREEN_LED=0
	      export OF_USE_MAGISKBOOT=1
        export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	      export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	      export FOX_USE_BASH_SHELL=1
	      export FOX_ASH_IS_BASH=1
	      export FOX_USE_TAR_BINARY=1
	      export FOX_USE_SED_BINARY=1
	      export FOX_USE_XZ_UTILS=1
        export OF_QUICK_BACKUP_LIST="/boot;/data;"
        export FOX_USE_NANO_EDITOR=1

        export FOX_ENABLE_APP_MANAGER=1

        # OTA
        export OF_KEEP_DM_VERITY=1
        export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
        export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
        export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

	# maximum permissible splash image size (in kilobytes); do *NOT* increase!
	      export OF_SPLASH_MAX_SIZE=130

	# ensure that /sdcard is bind-unmounted before f2fs data repair or format
	      export OF_UNBIND_SDCARD_F2FS=1

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
#
