#!/system/bin/sh

# *******************************
# Oneplus 2 CM13 version
#
# V0.1
# *******************************

# define basic kernel configuration
	# path to internal sd memory
	SD_PATH="/data/media/0"

	# block devices
	SYSTEM_DEVICE="/dev/block/bootdevice/by-name/system"
	CACHE_DEVICE="/dev/block/bootdevice/by-name/cache"
	DATA_DEVICE="/dev/block/bootdevice/by-name/userdata"

# define file paths
	BOEFFLA_DATA_PATH="$SD_PATH/boeffla-kernel-data"
	BOEFFLA_LOGFILE="$BOEFFLA_DATA_PATH/boeffla-kernel.log"
	BOEFFLA_STARTCONFIG="/data/.boeffla/startconfig"
	BOEFFLA_STARTCONFIG_EARLY="/data/.boeffla/startconfig_early"
	BOEFFLA_STARTCONFIG_DONE="/data/.boeffla/startconfig_done"
	CWM_RESET_ZIP="boeffla-config-reset-v5.zip"
	INITD_ENABLER="/data/.boeffla/enable-initd"
	PERMISSIVE_ENABLER="/data/.boeffla/enable-permissive"
	DOZE_DISABLER="/data/.boeffla/disable-doze"

# If not yet existing, create a boeffla-kernel-data folder on sdcard 
# which is used for many purposes,
# always set permissions and owners correctly for pathes and files
	if [ ! -d "$BOEFFLA_DATA_PATH" ] ; then
		/sbin/busybox mkdir $BOEFFLA_DATA_PATH
	fi

	/sbin/busybox chmod 775 $SD_PATH
	/sbin/busybox chown 1023:1023 $SD_PATH

	/sbin/busybox chmod -R 775 $BOEFFLA_DATA_PATH
	/sbin/busybox chown -R 1023:1023 $BOEFFLA_DATA_PATH

# maintain log file history
	rm $BOEFFLA_LOGFILE.3
	mv $BOEFFLA_LOGFILE.2 $BOEFFLA_LOGFILE.3
	mv $BOEFFLA_LOGFILE.1 $BOEFFLA_LOGFILE.2
	mv $BOEFFLA_LOGFILE $BOEFFLA_LOGFILE.1

# Initialize the log file (chmod to make it readable also via /sdcard link)
	echo $(date) Boeffla-Kernel initialisation started > $BOEFFLA_LOGFILE
	/sbin/busybox chmod 666 $BOEFFLA_LOGFILE
	/sbin/busybox cat /proc/version >> $BOEFFLA_LOGFILE
	echo "=========================" >> $BOEFFLA_LOGFILE
	/sbin/busybox grep ro.build.version /system/build.prop >> $BOEFFLA_LOGFILE
	echo "=========================" >> $BOEFFLA_LOGFILE

# remove any obsolete Boeffla-Config V2 startconfig done file
	/sbin/busybox rm -f $BOEFFLA_STARTCONFIG_DONE

# Apply Boeffla-Kernel default settings

	# Sdcard buffer tweaks default to 1024 kb
	echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb
	/sbin/busybox sync

	# Ext4 tweaks default to on
	/sbin/busybox sync
	/sbin/busybox mount -o remount,commit=20,noatime $CACHE_DEVICE /cache
	/sbin/busybox sync
	/sbin/busybox mount -o remount,commit=20,noatime $DATA_DEVICE /data
	/sbin/busybox sync
	
	echo $(date) Boeffla-Kernel default settings applied >> $BOEFFLA_LOGFILE

# Execute early startconfig placed by Boeffla-Config V2 app, if there is one
	if [ -f $BOEFFLA_STARTCONFIG_EARLY ]; then
		echo $(date) "Early startup configuration found"  >> $BOEFFLA_LOGFILE
		. $BOEFFLA_STARTCONFIG_EARLY
		echo $(date) Early startup configuration applied  >> $BOEFFLA_LOGFILE
	else
		echo $(date) "No early startup configuration found"  >> $BOEFFLA_LOGFILE
	fi

# init.d support (enabler only to be considered for CM based roms)
# (zipalign scripts will not be executed as only exception)
	if [ -f $INITD_ENABLER ] ; then
		echo $(date) Execute init.d scripts start >> $BOEFFLA_LOGFILE
		if cd /system/etc/init.d >/dev/null 2>&1 ; then
			for file in * ; do
				if ! cat "$file" >/dev/null 2>&1 ; then continue ; fi
				if [[ "$file" == *zipalign* ]]; then continue ; fi
				echo $(date) init.d file $file started >> $BOEFFLA_LOGFILE
				/system/bin/sh "$file"
				echo $(date) init.d file $file executed >> $BOEFFLA_LOGFILE
			done
		fi
		echo $(date) Finished executing init.d scripts >> $BOEFFLA_LOGFILE
	else
		echo $(date) init.d script handling by kernel disabled >> $BOEFFLA_LOGFILE
	fi

# Now wait for the rom to finish booting up
# (by checking for the android acore process)
	echo $(date) Checking for Rom boot trigger... >> $BOEFFLA_LOGFILE
	while ! /sbin/busybox pgrep com.android.systemui ; do
	  /sbin/busybox sleep 1
	done
	echo $(date) Rom boot trigger detected, waiting a few more seconds... >> $BOEFFLA_LOGFILE
	/sbin/busybox sleep 20

# Now wait for the msm_core_ctl module being loaded
# (by checking existance of min cpu setting for cpu4)
	echo $(date) Checking for msm_core_ctl trigger... >> $BOEFFLA_LOGFILE
	while ! [ -f /sys/devices/system/cpu/cpu4/core_ctl/min_cpus ] ; do
	  /sbin/busybox sleep 1
	done
	echo $(date) msm_core_ctl trigger detected, waiting a few more seconds... >> $BOEFFLA_LOGFILE
	/sbin/busybox sleep 2

# Initialize msm_core_control with parameters from OOS for both CPUs
	echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
	chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/max_cpus

	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
	chmod 644 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	chmod 644 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus

# Interaction with Boeffla-Config app V2
	# save original stock values for selected parameters
	cat /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table > /dev/bk_orig_cpu_voltage
	cat /sys/devices/system/cpu/cpu4/cpufreq/UV_mV_table > /dev/bk_orig_cpu_voltage_2
	cat /sys/kernel/charge_levels/charge_level_ac > /dev/bk_orig_charge_level_ac
	cat /sys/kernel/charge_levels/charge_level_usb > /dev/bk_orig_charge_level_usb
	cat /sys/module/lowmemorykiller/parameters/minfree > /dev/bk_orig_minfree
	/sbin/busybox lsmod > /dev/bk_orig_modules
	cat /sys/class/kgsl/kgsl-3d0/devfreq/governor > /dev/bk_orig_gpu_governor
	cat /sys/class/kgsl/kgsl-3d0/min_pwrlevel > /dev/bk_orig_min_pwrlevel
	cat /sys/class/kgsl/kgsl-3d0/max_pwrlevel > /dev/bk_orig_max_pwrlevel
	cat /proc/sys/vm/swappiness > /dev/bk_orig_swappiness
	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor > /dev/bk_orig_scaling_governor
	cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor > /dev/bk_orig_scaling_governor_2
	cat /sys/block/mmcblk0/queue/scheduler > /dev/bk_orig_mmcblk0_scheduler
	cat /sys/block/mmcblk1/queue/scheduler > /dev/bk_orig_mmcblk1_scheduler
	cat /sys/block/mmcblk0/bdi/read_ahead_kb > /dev/bk_orig_mmcblk0_read_ahead_kb
	cat /sys/block/mmcblk1/bdi/read_ahead_kb > /dev/bk_orig_mmcblk1_read_ahead_kb

	# if there is a startconfig placed by Boeffla-Config V2 app, execute it;
	if [ -f $BOEFFLA_STARTCONFIG ]; then
		echo $(date) "Startup configuration found"  >> $BOEFFLA_LOGFILE
		. $BOEFFLA_STARTCONFIG
		echo $(date) Startup configuration applied  >> $BOEFFLA_LOGFILE
	else
		# dynamic fsync to on
		echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active
		/sbin/busybox sync

		echo $(date) "No startup configuration found, enable all default settings"  >> $BOEFFLA_LOGFILE
	fi

# Turn off debugging for certain modules
	echo 0 > /sys/module/kernel/parameters/initcall_debug
	echo 0 > /sys/module/lowmemorykiller/parameters/debug_level
	echo 0 > /sys/module/alarm/parameters/debug_mask
	echo 0 > /sys/module/alarm_dev/parameters/debug_mask
	echo 0 > /sys/module/binder/parameters/debug_mask
	echo 0 > /sys/module/xt_qtaguid/parameters/debug_mask

# EFS backup
	EFS_BACKUP_INT="$BOEFFLA_DATA_PATH/efs.tar.gz"

	if [ ! -f $EFS_BACKUP_INT ]; then

		dd if=/dev/block/mmcblk0p10 of=$BOEFFLA_DATA_PATH/modemst1.bin bs=512
		dd if=/dev/block/mmcblk0p11 of=$BOEFFLA_DATA_PATH/modemst2.bin bs=512

		cd $BOEFFLA_DATA_PATH
		/sbin/busybox tar cvz -f $EFS_BACKUP_INT modemst*
		/sbin/busybox chmod 666 $EFS_BACKUP_INT

		rm $BOEFFLA_DATA_PATH/modemst*
		
		echo $(date) EFS Backup: Not found, now created one >> $BOEFFLA_LOGFILE
	fi

# Copy reset recovery zip in boeffla-kernel-data folder, delete older versions first
	CWM_RESET_ZIP_SOURCE="/res/misc/$CWM_RESET_ZIP"
	CWM_RESET_ZIP_TARGET="$BOEFFLA_DATA_PATH/$CWM_RESET_ZIP"

	if [ ! -f $CWM_RESET_ZIP_TARGET ]; then

		/sbin/busybox rm $BOEFFLA_DATA_PATH/boeffla-config-reset*
		/sbin/busybox cp $CWM_RESET_ZIP_SOURCE $CWM_RESET_ZIP_TARGET
		/sbin/busybox chmod 666 $CWM_RESET_ZIP_TARGET

		echo $(date) Recovery reset zip copied >> $BOEFFLA_LOGFILE
	fi

# disable doze if configured
	if [ -f $DOZE_DISABLER ]; then
		dumpsys deviceidle disable
		echo $(date) "Doze disabled" >> $BOEFFLA_LOGFILE
	fi

# Remove SELinux enforce lock to allow SELinux mode changes from now on
	echo "0" > /sys/fs/selinux/bk_locked

# If not explicitely configured to permissive, set SELinux to enforcing and restart mpdecision
	if [ ! -f $PERMISSIVE_ENABLER ]; then
		echo "1" > /sys/fs/selinux/enforce

		stop mpdecision
		/sbin/busybox sleep 0.5
		start mpdecision

		echo $(date) "SELinux: enforcing" >> $BOEFFLA_LOGFILE
	else
		echo $(date) "SELinux: permissive" >> $BOEFFLA_LOGFILE
	fi


# Finished
	echo $(date) Boeffla-Kernel initialisation completed >> $BOEFFLA_LOGFILE
	echo $(date) "Loaded early startconfig was:" >> $BOEFFLA_LOGFILE
	cat $BOEFFLA_STARTCONFIG_EARLY >> $BOEFFLA_LOGFILE
	echo $(date) "Loaded startconfig was:" >> $BOEFFLA_LOGFILE
	cat $BOEFFLA_STARTCONFIG >> $BOEFFLA_LOGFILE
	echo $(date) End of kernel startup logfile >> $BOEFFLA_LOGFILE
