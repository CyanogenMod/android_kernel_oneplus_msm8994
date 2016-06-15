#!/system/bin/sh

# Boeffla-Config controller interface
#
# *******************************
# Oneplus 2 CM13 version
#
# V0.1
# *******************************

# ********************************
# Kernel specific initialisation
# ********************************

# kernel specification (hardware; type; target; url)
KERNEL_SPECS="oneplus2;cm;cm13.0;http://boeffla.df-kunde.de/oneplus2/boeffla-kernel-cm/"

# kernel features 
# (1=enable-busybox,2=enable-frandom,3=wipe-cache,4=disable-zram-control)
# (5=enable-default-zram-control,6=enable-selinux-switch, 7=enable-selinux-control)
# (8=no-hotplugging,9=enable-doze-control)
KERNEL_FEATURES="-3-4-6-7-9-"

# path to kernel libraries
LIBPATH="/system/lib/modules"

# block devices
SYSTEM_DEVICE="/dev/block/bootdevice/by-name/system"
CACHE_DEVICE="/dev/block/bootdevice/by-name/cache"
DATA_DEVICE="/dev/block/bootdevice/by-name/userdata"
BOOT_DEVICE="/dev/block/bootdevice/by-name/boot"
RADIO_DEVICE="/dev/block/bootdevice/by-name/modem"
RECOVERY_DEVICE="/dev/block/bootdevice/by-name/recovery"


# *******************
# List of values
# *******************

if [ "lov_gov_profiles" == "$1" ]; then
	echo "interactive - battery;interactive - battery extreme;interactive - performance"
	exit 0
fi

if [ "lov_gov_profiles_2" == "$1" ]; then
	echo "interactive - battery;interactive - battery extreme;interactive - performance"
	exit 0
fi

if [ "lov_cpu_hotplug_profiles" == "$1" ]; then
	echo "4 cores (default);3 cores;2 cores;1 core"
	exit 0
fi

if [ "lov_cpu_hotplug_profiles_2" == "$1" ]; then
	echo "min=2, max=4 (default);min=0, max=4;min=0, max=3;min=0, max=2;min=0, max=1;min=0, max=0;min=1, max=4;min=1, max=3;min=1, max=2;min=1, max=1;min=2, max=3;min=2, max=2;min=3, max=4;min=3, max=3;min=4, max=4"
	exit 0
fi

if [ "lov_cpu_volt_profiles" == "$1" ]; then
	#echo "No undervolting;undervolt -25mV;undervolt -50mV;undervolt -75mV;undervolt -100mV;undervolt light;undervolt medium;undervolt heavy"
	exit 0
fi

if [ "lov_gpu_freq_profiles" == "$1" ]; then
	#echo "54 only;160 only;160/266;266/350;54/108/160/200/266;108/160/200/266/350;160/266/350/440/533 (default);266/350/440/533/600;350/440/533/600/640;440/533/600/640/700"
	exit 0
fi

if [ "lov_gpu_volt_profiles" == "$1" ]; then
	#echo "No undervolting;undervolt -25mV;undervolt -50mV;undervolt -75mV;undervolt -100mV;undervolt light;undervolt medium;undervolt heavy;overvolt +25mV;overvolt +50mV;overvolt +75mV;overvolt +100mV"
	exit 0
fi

if [ "lov_gpu_freq" == "$1" ]; then
	#echo "54;108;160;200;266;300;350;400;440;500;533;600;640;700"
	exit 0
fi

if [ "lov_eq_gain_profiles" == "$1" ]; then
	#echo "Archis audiophile;Baseland;Bass extreme;Bass treble;Classic;Dance;Eargasm;Metal/Rock;Pleasant;Treble"
	exit 0
fi

if [ "lov_system_tweaks" == "$1" ]; then
	echo "Thermal - Stock;Thermal - Custom;Thermal - Relaxed;Thermal - Performance;Thermal - Gaming;Thermal - Extreme"
	exit 0
fi

if [ "lov_modules" == "$1" ]; then
	ls $LIBPATH/*
	exit 0
fi

if [ "***notimplemented*** lov_presets" == "$1" ]; then
	# Note, the ^ sign will be translated into newline for this setting
	echo "Power extreme~"
	echo "Gov: zzmoove / performance"
	echo "^Sched: row"
	echo "^CPU: 2880 / no uv"
	echo "^GPU: 330-657;"
	
	echo "Power~"
	echo "Gov: ondemand / standard"
	echo "^Sched: row"
	echo "^CPU: 2726 / no uv"
	echo "^GPU: 200-657;"
	
	echo "Standard~"
	echo "Gov: interactive / standard"
	echo "^Sched: row"
	echo "^CPU: 2457 / no uv"
	echo "^GPU: 27-578;"
	
	echo "Battery friendly~"
	echo "Gov: interactive / standard"
	echo "^Sched: zen"
	echo "^CPU: 1728 / -25mV"
	echo "^GPU: 27-330;"
	
	echo "Battery saving~"
	echo "Gov: zzmoove / battery yank"
	echo "^Sched: zen"
	echo "^CPU: 1497 / light uv"
	echo "^GPU: 27 only;"
	
	exit 0
fi


# ************************************
# Configuration values (for profiles)
# ************************************

if [ "conf_presets" == "$1" ]; then
	if [ "Power extreme" ==  "$2" ]; then
		# gov, gov prof, sched int, sched ext, cpu max, cpu uv, gpu freq, gpu uv
		echo "zzmoove;zzmoove - performance;"
		echo "row;row;"
		echo "2880000;None;"
		echo "4,0;None"
	fi
	if [ "Power" ==  "$2" ]; then
		# gov, gov prof, sched int, sched ext, cpu max, cpu uv, gpu freq, gpu uv
		echo "ondemand;ondemand - standard;"
		echo "row;row;"
		echo "2726400;None;"
		echo "5,0;None"
	fi
	if [ "Standard" ==  "$2" ]; then
		# gov, gov prof, sched int, sched ext, cpu max, cpu uv, gpu freq, gpu uv
		echo "interactive;standard;"
		echo "row;row;"
		echo "2457600;None;"
		echo "6,1;None"
	fi
	if [ "Battery friendly" ==  "$2" ]; then
		# gov, gov prof, sched int, sched ext, cpu max, cpu uv, gpu freq, gpu uv
		echo "interactive;standard;"
		echo "zen;zen;"
		echo "1728000;undervolt -25mV;"
		echo "6,4;None"
	fi
	if [ "Battery saving" ==  "$2" ]; then
		# gov, gov prof, sched int, sched ext, cpu max, cpu uv, gpu freq, gpu uv
		echo "zzmoove;zzmoove - battery yank;"
		echo "zen;zen;"
		echo "1497600;undervolt light;"
		echo "6,6;None"
	fi
	exit 0
fi


if [ "conf_gpu_freq" == "$1" ]; then
	if [ "54 only" == "$2" ]; then
		echo "54;54;54;54;54"
	fi
	if [ "160 only" == "$2" ]; then
		echo "160;160;160;160;160"
	fi
	if [ "160/266" == "$2" ]; then
		echo "160;160;160;266;266"
	fi
	if [ "266/350" == "$2" ]; then
		echo "266;266;266;350;350"
	fi
	if [ "54/108/160/200/266" == "$2" ]; then
		echo "54;108;160;200;266"
	fi
	if [ "108/160/200/266/350" == "$2" ]; then
		echo "108;160;200;266;350"
	fi
	if [ "160/266/350/440/533 (default)" == "$2" ]; then
		echo "160;266;350;440;533"
	fi
	if [ "266/350/440/533/600" == "$2" ]; then
		echo "266;350;440;533;600"
	fi
	if [ "350/440/533/600/640" == "$2" ]; then
		echo "350;440;533;600;640"
	fi
	if [ "440/533/600/640/700" == "$2" ]; then
		echo "440;533;600;640;700"
	fi
	exit 0
fi


if [ "conf_gpu_volt" == "$1" ]; then
	if [ "No undervolting" == "$2" ]; then
		echo "0;0;0;0;0"
	fi
	if [ "undervolt -25mV" == "$2" ]; then
		echo "-25000;-25000;-25000;-25000;-25000"
	fi
	if [ "undervolt -50mV" == "$2" ]; then
		echo "-50000;-50000;-50000;-50000;-50000"
	fi
	if [ "undervolt -75mV" == "$2" ]; then
		echo "-75000;-75000;-75000;-75000;-75000"
	fi
	if [ "undervolt -100mV" == "$2" ]; then
		echo "-100000;-100000;-100000;-100000;-100000"
	fi
	if [ "undervolt light" == "$2" ]; then
		echo "-25000;-25000;-25000;-50000;-50000"
	fi
	if [ "undervolt medium" == "$2" ]; then
		echo "-50000;-50000;-50000;-75000;-75000"
	fi
	if [ "undervolt heavy" == "$2" ]; then
		echo "-75000;-75000;-75000;-100000;-100000"
	fi
	if [ "overvolt +25mV" == "$2" ]; then
		echo "25000;25000;25000;25000;25000"
	fi
	if [ "overvolt +50mV" == "$2" ]; then
		echo "50000;50000;50000;50000;50000"
	fi
	if [ "overvolt +75mV" == "$2" ]; then
		echo "75000;75000;75000;75000;75000"
	fi
	if [ "overvolt +100mV" == "$2" ]; then
		echo "100000;100000;100000;100000;100000"
	fi
	exit 0
fi

if [ "conf_cpu_volt" == "$1" ]; then
	if [ "No undervolting" == "$2" ]; then
		echo "0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0"
	fi
	if [ "undervolt -25mV" == "$2" ]; then
		echo "-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25;-25"
	fi
	if [ "undervolt -50mV" == "$2" ]; then
		echo "-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50;-50"
	fi
	if [ "undervolt -75mV" == "$2" ]; then
		echo "-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75;-75"
	fi
	if [ "undervolt -100mV" == "$2" ]; then
		echo "-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100;-100"
	fi
	if [ "undervolt light" == "$2" ]; then
		echo "-50;-50;-50;-50;-50;-25;-25;-25;-25;-25;-25;-25;0;0;0;0;0;0"
	fi
	if [ "undervolt medium" == "$2" ]; then
		echo "-75;-75;-75;-75;-75;-75;-50;-50;-50;-50;-50;-25;-25;-25;-25;-25;-25;-25"
	fi
	if [ "undervolt heavy" == "$2" ]; then
		echo "-100;-100;-100;-100;-100;-100;-100;-75;-75;-75;-75;-75;-50;-50;-50;-50;-50;-50"
	fi
	exit 0
fi

if [ "conf_eq_gains" == "$1" ]; then
	if [ "Flat" ==  "$2" ]; then
		echo "0;0;0;0;0"
	fi
	if [ "Archis audiophile" ==  "$2" ]; then
		echo "8;4;4;2;6"
	fi
	if [ "Eargasm" ==  "$2" ]; then
		echo "12;8;4;2;3"
	fi
	if [ "Pleasant" ==  "$2" ]; then
		echo "4;3;2;2;3"
	fi
	if [ "Classic" ==  "$2" ]; then
		echo "0;0;0;-3;-5"
	fi
	if [ "Bass treble" ==  "$2" ]; then
		echo "10;7;0;2;5"
	fi
	if [ "Bass extreme" ==  "$2" ]; then
		echo "12;8;3;-1;1"
	fi
	if [ "Treble" ==  "$2" ]; then
		echo "-5;1;0;4;3"
	fi
	if [ "Baseland" ==  "$2" ]; then
		echo "8;7;4;3;3"
	fi
	if [ "Dance" ==  "$2" ]; then
		echo "4;0;-6;0;3"
	fi
	if [ "Metal/Rock" ==  "$2" ]; then
		echo "4;3;0;-4;3"
	fi
	if [ "Googy" ==  "$2" ]; then
		echo "10;2;-1;2;10"
	fi
	exit 0
fi

# *******************
# Parameters
# *******************

if [ "param_readahead" == "$1" ]; then
	# Internal sd (min/max/steps)
	echo "128;3072;128;"
	# External sd (min/max/steps)
	echo "128;3072;128"
	exit 0
fi

if [ "param_boeffla_sound" == "$1" ]; then
	# Headphone min/max, Speaker min/max
	echo "-30;30;-30;30;"
	# Equalizer min/max
	echo "-12;12;"
	# Microphone gain min/max
	echo "-30;30;"
	# Stereo expansion min/max
	echo "0;31"
	exit 0
fi

if [ "param_cpu_uv" == "$1" ]; then
	# CPU UV min/max/steps
	echo "600;1500;25"
	exit 0
fi

if [ "param_gpu_uv" == "$1" ]; then
	# GPU UV min/max/steps
	echo "500000;1200000;25000"
	exit 0
fi

if [ "param_led" == "$1" ]; then
	# LED speed min/max/steps
	echo "0;20;1;"
	# LED brightness min/max/steps
	echo "0;100;1"
	exit 0
fi

if [ "param_touchwake" == "$1" ]; then
	# Touchwake min/max/steps
	echo "0;600000;5000;"
	# Knockon min/max/steps
	echo "100;2000;100"
	exit 0
fi

if [ "param_early_suspend_delay" == "$1" ]; then
	# Early suspend delay min/max/steps
	echo "0;700;25"
	exit 0
fi

if [ "param_zram" == "$1" ]; then
	# zRam size min/max/steps
	echo "104857600;838860800;20971520"
	exit 0
fi

if [ "param_charge_rates" == "$1" ]; then
	# AC charge min/max/steps
	echo "0;2000;50;"
	# USB charge min/max/steps
	echo "0;1600;50;"
	# Wireless charge min/max/steps
	# echo "100;1000;25"
	exit 0
fi

if [ "param_lmk" == "$1" ]; then
	# LMK size min/max/steps
	echo "5;300;1"
	exit 0
fi


# *******************
# Get settings
# *******************

if [ "get_ums" == "$1" ]; then
#	if [ "`busybox grep 179 /sys/devices/platform/s3c-usbgadget/gadget/lun0/file`" ]; then
#		echo "1"
#	else
#		echo "0"
#	fi
	echo ""
	exit 0
fi


if [ "get_tunables" == "$1" ]; then
	if [ -d /sys/devices/system/cpu/cpu0/cpufreq/$2 ]; then
		cd /sys/devices/system/cpu/cpu0/cpufreq/$2
		for file in *
		do
			content="`busybox cat $file`"
			busybox echo -ne "$file~$content;"
		done
	fi
fi

if [ "get_tunables_2" == "$1" ]; then
	if [ -d /sys/devices/system/cpu/cpu4/cpufreq/$2 ]; then
		cd /sys/devices/system/cpu/cpu4/cpufreq/$2
		for file in *
		do
			content="`busybox cat $file`"
			busybox echo -ne "$file~$content;"
		done
	fi
fi

if [ "get_kernel_version2" == "$1" ]; then
	busybox cat /proc/version
	exit 0
fi


if [ "get_kernel_specs" == "$1" ]; then
	echo $KERNEL_SPECS
	exit 0
fi

if [ "get_kernel_features" == "$1" ]; then
	echo $KERNEL_FEATURES
	exit 0
fi


# *******************
# Applying settings
# *******************

if [ "apply_cpu_hotplug_profile" == "$1" ]; then

	chmod 666 /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	chmod 666 /sys/devices/system/cpu/cpu0/core_ctl/max_cpus

	if [ "1 core" == "$2" ]; then
		echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		exit 0
	fi
	
	if [ "2 cores" == "$2" ]; then
		echo 2 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo 2 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		exit 0
	fi
	
	if [ "3 cores" == "$2" ]; then
		echo 3 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo 3 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		exit 0
	fi
	
	# Default "4 cores (default)", or when no profile set
	echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
	chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	chmod 444 /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
	exit 0;
fi

if [ "apply_cpu_hotplug_profile_2" == "$1" ] || [ "revert_big_cpu_cluster_online" == "$1" ]; then

	echo 0 > /sys/kernel/boeffla_config_mode/enabled

	chmod 666 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	chmod 666 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus

	# In CM, we always have to do that as msm_core_ctl does nt work when other drivers
	# like bcl, thermal etc. have taken over!!! So the if clauses are commented due to that !!!
	
	# if we should bring down cpu cluster 2 now, do exactly the following sequence:
	# - first instruct core_ctl (or msm_core_ctl) to disable all cores
	# - second bring down all cores via sysfs as core_ctl sometimes is lazy under some side condition
	#   Note: core_ctl in OOS is extremely sensitive, so it must be done exactly this way to not have reboots
	#if [ "revert_big_cpu_cluster_online" == "$1" ]; then
		# bring down via core_ctl
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus

		# now bring down via sysfs
		echo 0 > /sys/devices/system/cpu/cpu4/online
		echo 0 > /sys/devices/system/cpu/cpu5/online
		echo 0 > /sys/devices/system/cpu/cpu6/online
		echo 0 > /sys/devices/system/cpu/cpu7/online

		# reinitialize core_ctl to stock settings now,
		# otherwise next settings do not work properly (for whatever unkown reasons)
		echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	#fi

	if [ "min=0, max=0" == "$2" ]; then
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi

	if [ "min=0, max=1" == "$2" ]; then
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi

	if [ "min=0, max=2" == "$2" ]; then
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi

	if [ "min=0, max=3" == "$2" ]; then
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi

	if [ "min=0, max=4" == "$2" ]; then
		echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi

	if [ "min=1, max=4" == "$2" ]; then
		echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi

	if [ "min=1, max=3" == "$2" ]; then
		echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi	
	
	if [ "min=1, max=2" == "$2" ]; then
		echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi
	
	if [ "min=1, max=1" == "$2" ]; then
		echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi
	
	if [ "min=2, max=3" == "$2" ]; then
		echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi

	if [ "min=2, max=2" == "$2" ]; then
		echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi
	
	if [ "min=3, max=4" == "$2" ]; then
		echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi
	
	if [ "min=3, max=3" == "$2" ]; then
		echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi
	
	if [ "min=4, max=4" == "$2" ]; then
		echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		exit 0
	fi
	
	# Default "min=2, max=4", or when no profile set
	# this is full stock = permissions set so rom can change core_ctl settings
	# to e.g. switch off cores when certain apps running (like Chrome etc.) -- however not used in CM, anyways
	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
	chmod 644 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	chmod 644 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus

	exit 0;
fi


if [ "apply_governor_profile" == "$1" ]; then

	if [ "conservative - standard" == "$2" ]; then
		echo "20" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/down_threshold
		echo "5" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/freq_step
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/ignore_nice_load
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/sampling_down_factor
		echo "200000" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/sampling_rate
		echo "200000" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/sampling_rate_min
		echo "80" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_threshold

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "ondemand - standard" == "$2" ]; then
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice_load
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/io_is_busy
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_down_factor
		echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
		echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate_min
		echo "95" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "interactive - standard" == "$2" ]; then
		echo "19000 960000:39000 1248000:29000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
		echo "95" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
		echo "960000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
		echo "20000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
		echo "20000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
		echo "80 960000:95 1248000:99" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
		echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi
	
	if [ "interactive - battery" == "$2" ]; then
		echo "19000 960000:39000 1248000:29000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
		echo "98" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
		echo "768000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
		echo "5000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
		echo "5000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
		echo "80 768000:95 864000:99" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
		echo "25000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "interactive - battery extreme" == "$2" ]; then
		echo "19000 960000:39000 1248000:29000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
		echo "100" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
		echo "460800" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
		echo "2500" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
		echo "2500" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
		echo "80 460800:95 672000:99" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
		echo "40000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "interactive - performance" == "$2" ]; then
		echo "19000 960000:39000 1248000:29000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
		echo "80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
		echo "1344000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
		echo "30000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
		echo "30000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
		echo "80 1344000:95 1478400:99" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
		echo "7000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
		busybox sleep 0.5s
		busybox sync
	fi

	if [ "impulse - standard" == "$2" ]; then
		echo "20000" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/align_windows
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/boost
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/boostpulse_duration
		echo "99" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/go_hispeed_load
		echo "5" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/go_lowspeed_load
		echo "1555200" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/hispeed_freq
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/io_is_busy
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/max_freq_hysteresis
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/min_sample_time
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/powersave_bias
		echo "90" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/target_loads
		echo "20000" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/timer_slack
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/use_migration_notif
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/impulse/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "elementalx - standard" == "$2" ]; then
		echo "960000" > /sys/devices/system/cpu/cpu0/cpufreq/elementalx/active_floor_freq
		echo "20" > /sys/devices/system/cpu/cpu0/cpufreq/elementalx/down_differential
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/elementalx/powersave
		echo "4" > /sys/devices/system/cpu/cpu0/cpufreq/elementalx/sampling_down_factor
		echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/elementalx/sampling_rate
		echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/elementalx/sampling_rate_min
		echo "90" > /sys/devices/system/cpu/cpu0/cpufreq/elementalx/up_threshold

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "zzmoove - standard" == "$2" ]; then
		echo "25" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/afs_threshold1
		echo "50" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/afs_threshold2
		echo "75" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/afs_threshold3
		echo "90" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/afs_threshold4
		echo "40" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/down_threshold
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/fast_scaling_down
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/fast_scaling_up
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/ignore_nice_load
		echo "1" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/sampling_down_factor
		echo "200000" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/sampling_rate
		echo "200000" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/sampling_rate_min
		echo "0" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/scaling_proportional
		echo "75" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/smooth_up
		echo "80" > /sys/devices/system/cpu/cpu0/cpufreq/zzmoove/up_threshold

		busybox sleep 0.5s
		busybox sync
	fi

	exit 0
fi

if [ "apply_governor_profile_2" == "$1" ]; then

	if [ "conservative - standard" == "$2" ]; then
		echo "20" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/down_threshold
		echo "5" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/freq_step
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/ignore_nice_load
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/sampling_down_factor
		echo "200000" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/sampling_rate
		echo "200000" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/sampling_rate_min
		echo "80" > /sys/devices/system/cpu/cpu4/cpufreq/conservative/up_threshold

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "ondemand - standard" == "$2" ]; then
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/ignore_nice_load
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/io_is_busy
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/powersave_bias
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/sampling_down_factor
		echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/sampling_rate
		echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/sampling_rate_min
		echo "95" > /sys/devices/system/cpu/cpu4/cpufreq/ondemand/up_threshold

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "interactive - standard" == "$2" ]; then
		echo "19000 1400000:39000 1700000:19000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
		echo "90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
		echo "1248000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
		echo "40000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
		echo "90 1248000:95 1800000:70" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
		echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi
	
	if [ "interactive - battery" == "$2" ]; then
		echo "19000 1400000:39000 1700000:19000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
		echo "95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
		echo "864000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
		echo "20000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
		echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
		echo "90 864000:95 1500000:70" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
		echo "25000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "interactive - battery extreme" == "$2" ]; then
		echo "19000 1400000:39000 1700000:19000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
		echo "100" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
		echo "480000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
		echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
		echo "5000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
		echo "90 633600:95 1100000:70" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
		echo "40000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "interactive - performance" == "$2" ]; then
		echo "19000 1400000:39000 1700000:19000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
		echo "" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
		echo "80" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
		echo "1632000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
		echo "120000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
		echo "60000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
		echo "90 1536000:95 2000000:70" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
		echo "7000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "impulse - standard" == "$2" ]; then
		echo "20000" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/above_hispeed_delay
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/align_windows
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/boost
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/boostpulse_duration
		echo "99" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/go_hispeed_load
		echo "5" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/go_lowspeed_load
		echo "1766400" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/hispeed_freq
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/io_is_busy
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/max_freq_hysteresis
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/min_sample_time
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/powersave_bias
		echo "90" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/target_loads
		echo "20000" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/timer_rate
		echo "80000" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/timer_slack
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/use_migration_notif
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/impulse/use_sched_load

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "elementalx - standard" == "$2" ]; then
		echo "960000" > /sys/devices/system/cpu/cpu4/cpufreq/elementalx/active_floor_freq
		echo "20" > /sys/devices/system/cpu/cpu4/cpufreq/elementalx/down_differential
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/elementalx/powersave
		echo "4" > /sys/devices/system/cpu/cpu4/cpufreq/elementalx/sampling_down_factor
		echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/elementalx/sampling_rate
		echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/elementalx/sampling_rate_min
		echo "90" > /sys/devices/system/cpu/cpu4/cpufreq/elementalx/up_threshold

		busybox sleep 0.5s
		busybox sync
	fi

	if [ "zzmoove - standard" == "$2" ]; then
		echo "25" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/afs_threshold1
		echo "50" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/afs_threshold2
		echo "75" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/afs_threshold3
		echo "90" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/afs_threshold4
		echo "40" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/down_threshold
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/fast_scaling_down
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/fast_scaling_up
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/ignore_nice_load
		echo "1" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/sampling_down_factor
		echo "200000" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/sampling_rate
		echo "200000" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/sampling_rate_min
		echo "0" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/scaling_proportional
		echo "75" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/smooth_up
		echo "80" > /sys/devices/system/cpu/cpu4/cpufreq/zzmoove/up_threshold
	fi

	exit 0
fi


if [ "apply_system_tweaks" == "$1" ]; then

	if [ "Thermal - Custom" == "$2" ]; then
		# do nothing to allow custom thermal configuration to not be overwritten
		exit 0
	fi
	
	if [ "Thermal - Relaxed" == "$2" ]; then
		mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
		cp /res/thermal/thermal-engine-relaxed.conf /system/etc/thermal-engine.conf
		chmod 644 /system/etc/thermal-engine.conf
		busybox sync
		mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
		busybox sync
		exit 0
	fi

	if [ "Thermal - Performance" == "$2" ]; then
		mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
		cp /res/thermal/thermal-engine-performance.conf /system/etc/thermal-engine.conf
		chmod 644 /system/etc/thermal-engine.conf
		busybox sync
		mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
		busybox sync
		exit 0
	fi

	if [ "Thermal - Gaming" == "$2" ]; then
		mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
		cp /res/thermal/thermal-engine-gaming.conf /system/etc/thermal-engine.conf
		chmod 644 /system/etc/thermal-engine.conf
		busybox sync
		mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
		busybox sync
		exit 0
	fi

	if [ "Thermal - Extreme" == "$2" ]; then
		mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
		cp /res/thermal/thermal-engine-extreme.conf /system/etc/thermal-engine.conf
		chmod 644 /system/etc/thermal-engine.conf
		busybox sync
		mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
		busybox sync
		exit 0
	fi

	# fall back to stock thermal engine if no match
	mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
	cp /res/thermal/thermal-engine.conf /system/etc/thermal-engine.conf
	chmod 644 /system/etc/thermal-engine.conf
	busybox sync
	mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
	busybox sync

	exit 0
fi

if [ "apply_eq_bands" == "$1" ]; then
#	echo "1 4027 1031 0 276" > /sys/class/misc/boeffla_sound/eq_bands
#	echo "2 8076 61555 456 456" > /sys/class/misc/boeffla_sound/eq_bands
#	echo "3 7256 62323 2644 1368" > /sys/class/misc/boeffla_sound/eq_bands
#	echo "4 5774 63529 1965 4355" > /sys/class/misc/boeffla_sound/eq_bands
#	echo "5 1380 1369 0 16384" > /sys/class/misc/boeffla_sound/eq_bands
	exit 0
fi

if [ "apply_ext4_tweaks" == "$1" ]; then
	if [ "1" == "$2" ]; then
		busybox sync
		busybox mount -o remount,commit=20,noatime $CACHE_DEVICE /cache
		busybox sync
		busybox mount -o remount,commit=20,noatime $DATA_DEVICE /data
		busybox sync
	fi

	if [ "0" == "$2" ]; then
		busybox sync
		busyboxmount -o remount,commit=0,noatime $CACHE_DEVICE /cache
		busybox sync
		busybox mount -o remount,commit=0,noatime $DATA_DEVICE /data
		busybox sync
	fi
	exit 0
fi

if [ "apply_survival_script" == "$1" ]; then
	if [ "1" == "$2" ]; then
		mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
		busybox mkdir -p /system/addon.d
		busybox cp /res/misc/97-boeffla-kernel.sh /system/addon.d
		busybox chmod 755 /system/addon.d/97-boeffla-kernel.sh
		busybox sync
		mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
	fi

	if [ "0" == "$2" ]; then
		mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
		busybox rm /system/addon.d/97-boeffla-kernel.sh
		busybox sync
		mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
	fi
	exit 0
fi

#if [ "apply_zram" == "$1" ]; then
#	if [ "1" == "$2" ]; then
#		if [ "1" == "$3" ]; then
#			busybox swapoff /dev/block/zram0
#			busybox swapoff /dev/block/zram1
#			busybox swapoff /dev/block/zram2
#			busybox swapoff /dev/block/zram3
#			echo "1" > /sys/block/zram0/reset
#			echo "1" > /sys/block/zram1/reset
#			echo "1" > /sys/block/zram2/reset
#			echo "1" > /sys/block/zram3/reset
#			echo "$4" > /sys/block/zram0/disksize
#			echo "0" > /sys/block/zram1/disksize
#			echo "0" > /sys/block/zram2/disksize
#			echo "0" > /sys/block/zram3/disksize
#			busybox mkswap /dev/block/zram0
#			busybox swapon -p 2 /dev/block/zram0
#			busybox sleep 0.5s
#			busybox sync
#		fi
#		if [ "2" == "$3" ]; then
#			busybox swapoff /dev/block/zram0
#			busybox swapoff /dev/block/zram1
#			busybox swapoff /dev/block/zram2
#			busybox swapoff /dev/block/zram3
#			echo "1" > /sys/block/zram0/reset
#			echo "1" > /sys/block/zram1/reset
#			echo "1" > /sys/block/zram2/reset
#			echo "1" > /sys/block/zram3/reset
#			echo "$4" > /sys/block/zram0/disksize
#			echo "$4" > /sys/block/zram1/disksize
#			echo "0" > /sys/block/zram2/disksize
#			echo "0" > /sys/block/zram3/disksize
#			busybox mkswap /dev/block/zram0
#			busybox mkswap /dev/block/zram1
#			busybox swapon -p 2 /dev/block/zram0
#			busybox swapon -p 2 /dev/block/zram1
#			busybox sleep 0.5s
#			busybox sync
#		fi
#		if [ "4" == "$3" ]; then
#			busybox swapoff /dev/block/zram0
#			busybox swapoff /dev/block/zram1
#			busybox swapoff /dev/block/zram2
#			busybox swapoff /dev/block/zram3
#			echo "1" > /sys/block/zram0/reset
#			echo "1" > /sys/block/zram1/reset
#			echo "1" > /sys/block/zram2/reset
#			echo "1" > /sys/block/zram3/reset
#			echo "$4" > /sys/block/zram0/disksize
#			echo "$4" > /sys/block/zram1/disksize
#			echo "$4" > /sys/block/zram2/disksize
#			echo "$4" > /sys/block/zram3/disksize
#			busybox mkswap /dev/block/zram0
#			busybox mkswap /dev/block/zram1
#			busybox mkswap /dev/block/zram2
#			busybox mkswap /dev/block/zram3
#			busybox swapon -p 2 /dev/block/zram0
#			busybox swapon -p 2 /dev/block/zram1
#			busybox swapon -p 2 /dev/block/zram2
#			busybox swapon -p 2 /dev/block/zram3
#			busybox sleep 0.5s
#			busybox sync
#		fi
#		echo "80" > /proc/sys/vm/swappiness
#	fi
#
#	if [ "0" == "$2" ]; then
#		busybox swapoff /dev/block/zram0
#		busybox swapoff /dev/block/zram1
#		busybox swapoff /dev/block/zram2
#		busybox swapoff /dev/block/zram3
#		echo "1" > /sys/block/zram0/reset
#		echo "1" > /sys/block/zram1/reset
#		echo "1" > /sys/block/zram2/reset
#		echo "1" > /sys/block/zram3/reset
#		busybox sleep 0.5s
#		busybox sync
#	fi
#	exit 0
#fi

if [ "apply_cifs" == "$1" ]; then
	if [ "1" == "$2" ]; then
		busybox insmod $LIBPATH/cifs.ko
	fi

	if [ "0" == "$2" ]; then
		rmmod $LIBPATH/cifs.ko	
	fi
	exit 0
fi

if [ "apply_nfs" == "$1" ]; then
	if [ "1" == "$2" ]; then
		busybox insmod $LIBPATH/sunrpc.ko
		busybox insmod $LIBPATH/lockd.ko
		busybox insmod $LIBPATH/dns_resolver.ko
		busybox insmod $LIBPATH/nfs.ko
		busybox insmod $LIBPATH/nfsv3.ko
		busybox insmod $LIBPATH/nfsv4.ko
	fi

	if [ "0" == "$2" ]; then
		rmmod $LIBPATH/nfsv4.ko
		rmmod $LIBPATH/nfsv3.ko
		rmmod $LIBPATH/nfs.ko
		rmmod $LIBPATH/dns_resolver.ko
		rmmod $LIBPATH/lockd.ko
		rmmod $LIBPATH/sunrpc.ko
	fi
	exit 0
fi

if [ "apply_xbox" == "$1" ]; then
	if [ "1" == "$2" ]; then
		busybox insmod $LIBPATH/ff-memless.ko
		busybox insmod $LIBPATH/xpad.ko
	fi

	if [ "0" == "$2" ]; then
		rmmod $LIBPATH/xpad.ko
		rmmod $LIBPATH/ff-memless.ko
	fi
	exit 0
fi

if [ "apply_exfat" == "$1" ]; then
	if [ "1" == "$2" ]; then
		busybox insmod $LIBPATH/exfat_core.ko
		busybox insmod $LIBPATH/exfat_fs.ko
	fi

	if [ "0" == "$2" ]; then
		rmmod $LIBPATH/exfat_fs.ko
		rmmod $LIBPATH/exfat_core.ko
	fi
	exit 0
fi

if [ "apply_usb_ethernet" == "$1" ]; then
	if [ "1" == "$2" ]; then
		busybox insmod $LIBPATH/asix.ko
		netcfg eth0 up
		dhcpcd eth0
		DNS=`getprop net.eth0.dns1`
		ndc resolver setifdns eth0 "" $DNS  8.8.8.8
		ndc resolver setdefaultif eth0		
	fi

	if [ "0" == "$2" ]; then
		rmmod $LIBPATH/asix.ko
		netcfg eth0 down
	fi
	exit 0
fi

if [ "apply_ntfs" == "$1" ]; then
	if [ "1" == "$2" ]; then
		busybox insmod $LIBPATH/ntfs.ko
	fi

	if [ "0" == "$2" ]; then
		rmmod $LIBPATH/ntfs.ko
	fi
	exit 0
fi

if [ "apply_ums" == "$1" ]; then
#	if [ "1" == "$2" ]; then
#		busybox umount -l /mnt/extSdCard
#		busybox umount -l /storage/sdcard1
#		busybox umount -l /mnt/media_rw/sdcard1
#		busybox umount -l /mnt/secure/asec
#		/system/bin/setprop persist.sys.usb.config mass_storage,adb
#		echo /dev/block/vold/179:49 > /sys/devices/platform/s3c-usbgadget/gadget/lun0/file
#	fi
#
#	if [ "0" == "$2" ]; then
#		echo "" > /sys/devices/platform/s3c-usbgadget/gadget/lun0/file
#		/system/bin/vold
#		/system/bin/setprop persist.sys.usb.config mtp,adb
#	fi
	exit 0
fi


# *******************
# Actions
# *******************

if [ "action_debug_info_file" == "$1" ]; then
	echo $(date) Full debug log file start > $2
	echo -e "\n============================================\n" >> $2

	echo -e "\n**** Boeffla-Kernel version\n" >> $2
	cat /proc/version >> $2

	echo -e "\n**** Firmware information\n" >> $2
	busybox grep ro.build.version /system/build.prop >> $2

	echo -e "\n============================================\n" >> $2

	echo -e "\n**** Boeffla-Kernel log\n" >> $2
	cat /sdcard/boeffla-kernel-data/boeffla-kernel.log >> $2

	echo -e "\n**** Boeffla-Kernel log 1\n" >> $2
	cat /sdcard/boeffla-kernel-data/boeffla-kernel.log.1 >> $2

	echo -e "\n**** Boeffla-Kernel log 2\n" >> $2
	cat /sdcard/boeffla-kernel-data/boeffla-kernel.log.2 >> $2

	echo -e "\n**** Boeffla-Kernel log 3\n" >> $2
	cat /sdcard/boeffla-kernel-data/boeffla-kernel.log.3 >> $2

	echo -e "\n============================================\n" >> $2

	echo -e "\n**** Boeffla-Config app log\n" >> $2
	cat /sdcard/boeffla-kernel-data/bc.log >> $2

	echo -e "\n**** Boeffla-Config app log 1\n" >> $2
	cat /sdcard/boeffla-kernel-data/bc.log.1 >> $2

	echo -e "\n**** Boeffla-Config app log 2\n" >> $2
	cat /sdcard/boeffla-kernel-data/bc.log.2 >> $2

	echo -e "\n**** Boeffla-Config app log 3\n" >> $2
	cat /sdcard/boeffla-kernel-data/bc.log.3 >> $2

	echo -e "\n**** Boeffla-Config crash log\n" >> $2
	cat /sdcard/boeffla-kernel-data/bc.crashlog >> $2

	echo -e "\n============================================\n" >> $2

	echo -e "\n**** boeffla_sound\n" >> $2
	cd /sys/class/misc/boeffla_sound
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo "\n============================================\n" >> $2

	echo -e "\n**** SELinux:\n" >> $2
	getenforce >> $2

	echo -e "\n**** Loaded modules:\n" >> $2
	lsmod >> $2

	echo -e "\n**** CPU information:\n" >> $2
	cd /sys/devices/system/cpu/cpu0/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	cd /sys/devices/system/cpu/cpu1/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	cd /sys/devices/system/cpu/cpu2/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	cd /sys/devices/system/cpu/cpu3/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	cd /sys/devices/system/cpu/cpu4/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	cd /sys/devices/system/cpu/cpu5/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	cd /sys/devices/system/cpu/cpu6/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	cd /sys/devices/system/cpu/cpu7/cpufreq
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** GPU information:\n" >> $2
	cd /sys/class/kgsl/kgsl-3d0
	busybox find * -print -maxdepth 1 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** Root:\n" >> $2
	ls /system/xbin/su >> $2
	ls /system/app/Superuser.apk >> $2

	echo -e "\n**** Busybox:\n" >> $2
	ls /sbin/busybox >> $2
	ls /system/bin/busybox >> $2
	ls /system/xbin/busybox >> $2

	echo -e "\n**** Mounts:\n" >> $2
	mount | busybox grep /system >> $2
	mount | busybox grep /data >> $2
	mount | busybox grep /cache >> $2

	echo -e "\n**** SD Card read ahead:\n" >> $2
	cat /sys/block/mmcblk0/bdi/read_ahead_kb >> $2

	echo -e "\n**** Various kernel settings by config app:\n" >> $2
	cd /dev
	busybox find bk_* -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** Touch boost:\n" >> $2
	cd /sys/class/misc/touchboost_switch
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** Charging levels (ac/usb/wireless) and Charging instable power / ignore safety margin:\n" >> $2
	cd /sys/kernel/charge_levels
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** Scheduler:\n" >> $2
	cat /sys/block/mmcblk0/queue/scheduler >> $2

	echo -e "\n**** Scheduler hard:\n" >> $2
	cat /sys/block/mmcblk0/queue/scheduler_hard >> $2

	echo -e "\n**** Kernel Logger:\n" >> $2
	cat /sys/kernel/printk_mode/printk_mode >> $2

	#echo -e "\n**** Android Logger:\n" >> $2
	#cat /sys/kernel/logger_mode/logger_mode >> $2

	echo -e "\n**** LED information:\n" >> $2
	cd /sys/class/leds/red/device
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** Color control information:\n" >> $2
	cd /sys/devices/platform/kcal_ctrl.0
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2
	
	#echo -e "\n**** Swipe2wake information:\n" >> $2
	#cd /proc/touchpanel
	#busybox find sweep* -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	#echo -e "\n**** Swipe2sleep information:\n" >> $2
	#cd /sys/android_touch
	#busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** zRam information:\n" >> $2
	busybox find /sys/block/zram*/* -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** Uptime:\n" >> $2
	cat /proc/uptime >> $2

	echo -e "\n**** Frequency usage table:\n" >> $2
	cat /sys/devices/system/cpu/cpufreq/stats/cpu0/time_in_state >> $2
	cat /sys/devices/system/cpu/cpufreq/stats/cpu1/time_in_state >> $2

	echo -e "\n**** Memory:\n" >> $2
	busybox free -m >> $2

	echo -e "\n**** Meminfo:\n" >> $2
	cat /proc/meminfo >> $2

	echo -e "\n**** Swap:\n" >> $2
	cat /proc/swaps >> $2

	echo -e "\n**** Low memory killer:\n" >> $2
	cat /sys/module/lowmemorykiller/parameters/minfree >> $2

	echo -e "\n**** Swappiness:\n" >> $2
	cat /proc/sys/vm/swappiness >> $2

	echo -e "\n**** Storage:\n" >> $2
	busybox df >> $2

	echo -e "\n**** Mounts:\n" >> $2
	mount >> $2

	echo -e "\n**** Governor first cluster tuneables\n" >> $2
	GOVERNOR0=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
	cd /sys/devices/system/cpu/cpu0/cpufreq/$GOVERNOR0
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n**** Governor second cluster tuneables\n" >> $2
	GOVERNOR4=`cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor`
	cd /sys/devices/system/cpu/cpu4/cpufreq/$GOVERNOR4
	busybox find * -print -maxdepth 0 -type f -exec busybox tail -v -n +1 {} + >> $2

	echo -e "\n============================================\n" >> $2

	echo -e "\n**** /data/app folder\n" >> $2
	ls -l /data/app >> $2

	echo -e "\n**** /system/app folder\n" >> $2
	ls -l /system/app >> $2

	echo -e "\n============================================\n" >> $2

	echo -e "\n**** /system/etc/init.d folder\n" >> $2
	ls -l /system/etc/init.d >> $2

	echo -e "\n**** /etc/init.d folder\n" >> $2
	ls -l /etc/init.d >> $2

	echo -e "\n**** /data/init.d folder\n" >> $2
	ls -l /data/init.d >> $2

	echo -e "\n============================================\n" >> $2

	echo -e "\n**** pstore console-ramoops*\n" >> $2
	cat /sys/fs/pstore/console-ramoops*  >> $2

	echo -e "\n**** pstore dmesg-ramoops*\n" >> $2
	cat /sys/fs/pstore/dmesg-ramoops*  >> $2

	echo -e "\n============================================\n" >> $2

	echo -e "\n**** dmesg\n" >> $2
	dmesg  >> $2

	echo -e "\n============================================\n" >> $2
	echo $(date) Full debug log file end >> $2

	busybox chmod 666 $2
	exit 0
fi

if [ "action_reboot" == "$1" ]; then
	echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_active
	busybox sync
	busybox sleep 1s
	/system/bin/reboot
	exit 0
fi

if [ "action_reboot_cwm" == "$1" ]; then
	echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_active
	busybox sync
	busybox sleep 1s
	/system/bin/reboot recovery
	exit 0
fi

if [ "action_reboot_download" == "$1" ]; then
	echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_active
	busybox sync
	busybox sleep 1s
	/system/bin/reboot download
	exit 0
fi

if [ "action_wipe_caches_reboot" == "$1" ]; then
	echo 0 > /sys/kernel/dyn_fsync/Dyn_fsync_active
	busybox rm -rf /cache/*
	busybox rm -rf /data/dalvik-cache/*
	busybox sync
	busybox sleep 1s
	/system/bin/reboot
	exit 0
fi

if [ "action_wipe_cache" == "$1" ]; then
	busybox rm -rf /cache/*
	busybox sync
	busybox sleep 1s
	exit 0
fi

if [ "action_wipe_clipboard_cache" == "$1" ]; then
	busybox rm -rf /data/clipboard/*
	busybox sync
	exit 0
fi

if [ "action_clean_initd" == "$1" ]; then
	busybox tar cvz -f $2 /system/etc/init.d
	mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
	busybox rm /system/etc/init.d/*
	busybox sync
	mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
	exit 0
fi

if [ "action_fix_permissions" == "$1" ]; then
	mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system

	# User apps
	busybox chmod 644 /data/app/*.apk
	busybox chown 1000:1000 /data/app/*.apk
	# System apps
	busybox chmod 644 /system/app/*.apk
	busybox chown 0:0 /system/app/*.apk
	# System framework
	busybox chmod 644 /system/framework/*.apk
	busybox chown 0:0 /system/framework/*.apk
	busybox chmod 644 /system/framework/*.jar
	busybox chown 0:0 /system/framework/*.jar

	mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
	busybox sync
	exit 0
fi

if [ "action_fstrim" == "$1" ]; then
	echo -e "Trim /data"
	/sbin/busybox fstrim -v /data
	echo -e ""
	echo -e "Trim /cache"
	/sbin/busybox fstrim -v /cache
	echo -e ""
	echo -e "Trim /system"
	/sbin/busybox fstrim -v /system
	echo -e ""
	busybox sync
	exit 0
fi


if [ "flash_kernel" == "$1" ]; then
	setenforce 0
	busybox dd if=$2 of=$BOOT_DEVICE
	exit 0
fi

if [ "archive_kernel" == "$1" ]; then
	IMGPATH=$2
	cd ${IMGPATH%/*}
	busybox rm $3.tar
	busybox rm $3.tar.md5
	busybox tar cvf $3.tar ${IMGPATH##*/}
	busybox md5sum $3.tar >> $3.tar
	busybox mv $3.tar $3.tar.md5
	busybox chmod 666 $3.tar.md5
	busybox rm $2
	busybox sync
	exit 0
fi

if [ "extract_kernel" == "$1" ]; then
	busybox tar -xvf $2 -C $3
	exit 0
fi

if [ "flash_recovery" == "$1" ]; then
	setenforce 0
	busybox dd if=$2 of=$RECOVERY_DEVICE
	exit 0
fi

if [ "extract_recovery" == "$1" ]; then
	busybox tar -xvf $2 -C $3
	exit 0
fi

if [ "flash_modem" == "$1" ]; then
	setenforce 0
	busybox dd if=$2 of=$RADIO_DEVICE
	exit 0
fi

if [ "extract_modem" == "$1" ]; then
	busybox tar -xvf $2 -C $3
	exit 0
fi

if [ "flash_cm_kernel" == "$1" ]; then
	setenforce 0
	busybox dd if=$2/boot.img of=$BOOT_DEVICE
	mount -o remount,rw -t ext4 $SYSTEM_DEVICE /system
	busybox mkdir -p $LIBPATH
	busybox chmod 755 $LIBPATH
	busybox rm -f $LIBPATH/*
	busybox cp $2$LIBPATH/* $LIBPATH
	busybox chmod 644 $LIBPATH/*
	busybox sync
	mount -o remount,ro -t ext4 $SYSTEM_DEVICE /system
	exit 0
fi

if [ "extract_cm_kernel" == "$1" ]; then
	busybox unzip $2 -d $3
	exit 0
fi

if [ "bring_big_cpu_cluster_online" == "$1" ]; then
	echo 1 > /sys/kernel/boeffla_config_mode/enabled

	# To bring up cpu cluster 2 now, do exactly the following sequence:
	# - first instruct core_ctl (or msm_core_ctl) to enable all cores
	# - second bring up all cores via sysfs as core_ctl sometimes is lazy under some side condition
	#   Note: core_ctl in OOS is extremely sensitive, so it must be done exactly this way to not have reboots

	# bring up via core_ctl
	chmod 666 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	chmod 666 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
	echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
	echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	chmod 444 /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
	
	# now bring up via sysfs
	echo 1 > /sys/devices/system/cpu/cpu4/online
	echo 1 > /sys/devices/system/cpu/cpu5/online
	echo 1 > /sys/devices/system/cpu/cpu6/online
	echo 1 > /sys/devices/system/cpu/cpu7/online

	exit 0
fi
