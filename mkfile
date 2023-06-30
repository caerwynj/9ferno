# Directories common to all architectures.
# Build in order:
#	- critical libraries used by the limbo compiler
#	- the limbo compiler (used to build some subsequent libraries)
#	- the remaining libraries
#	- commands
#	- utilities

EMUDIRS=\
	lib9\
	libbio\
#	libmp\
	libsec\
	libmath\
	utils/iyacc\
	limbo\
	libinterp\
	libkeyring\
	libdraw\
	libprefab\
	libtk\
	libfreetype\
	libmemdraw\
	libmemlayer\
	libdynld\
	utils/data2c\
	utils/ndate\
	emu\


KERNEL_DIRS=\
	os/boot/pc\
	os/boot/efi\
	os/pc64\

# mkconfig is included at this point to allow it to override
#the preceding declarations (particularly KERNEL_DIRS) if need be

<mkconfig

DIRS=\
	$EMUDIRS\
	appl\

foo:QV:
	echo mk all, clean, install, installall or nuke

all:V:		all-$HOSTMODEL
clean:V:	clean-$HOSTMODEL
install:V:	install-$HOSTMODEL
installall:V:	installall-$HOSTMODEL
emu:V:	emu/all-$HOSTMODEL
emuinstall:V:	emu/install-$HOSTMODEL
emuclean:V:	emu/clean-$HOSTMODEL
emunuke:V:	emu/nuke-$HOSTMODEL
# TODO the kernel targets are obsolete(?). definitely need cleanup
#	mk kernel/pc64-9front tries to build pc64 in os/boot/pc
kernel:V:	kernel/all-$HOSTMODEL
kernelall:V:	kernel/all-$HOSTMODEL
kernelclean:V:	kernel/clean-$HOSTMODEL
kernelinstall:V:	kernel/install-$HOSTMODEL
kernelinstallall:V:	kernel/installall-$HOSTMODEL
kernelnuke:V:	kernel/nuke-$HOSTMODEL
nuke:V:		nuke-$HOSTMODEL

cleandist:V: clean
	rm -f $ROOT/$OBJDIR/lib/lib*.a

nukedist:V: nuke
	rm -f $ROOT/$OBJDIR/bin/*.exe
	rm -f $ROOT/$OBJDIR/lib/lib*.a
	
&-Posix:QV:
	for j in $DIRS utils tools
	do
		echo "(cd $j; mk $MKFLAGS $stem)"
		(cd $j; mk $MKFLAGS $stem) || exit 1
	done

&-Nt:QV:
	for (j in $DIRS utils tools)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk.exe $MKFLAGS $stem }
	}

&-Inferno:QV:
	for (j in $DIRS utils)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

&-Plan9:QV:
	for (j in $DIRS utils)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

&-9front:QV:
	for (j in $DIRS utils)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

emu/&-Posix:QV:
	for j in $EMUDIRS
	do
		echo "(cd $j; mk $MKFLAGS $stem)"
		(cd $j; mk $MKFLAGS $stem) || exit 1
	done

emu/&-Nt:QV:
	for (j in $EMUDIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

emu/&-Plan9:QV:
	for (j in $EMUDIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

emu/&-9front:QV:
	for (j in $EMUDIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

kernel/&-Posix:QV:
	for j in $KERNEL_DIRS
	do
		echo "(cd $j; mk $MKFLAGS $stem)"
		(cd $j; mk $MKFLAGS $stem) || exit 1
	done

kernel/&-Nt:QV:
	for (j in $KERNEL_DIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

kernel/&-Inferno:QV:
	for (j in $KERNEL_DIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

kernel/&-Plan9:QV:
	for (j in $KERNEL_DIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

kernel/&-9front:QV:
	for (j in $KERNEL_DIRS)
	{
		echo '@{builtin cd' $j '; mk $MKFLAGS $stem}'
		@{builtin cd $j; mk $MKFLAGS $stem }
	}

# Convenience targets

Inferno-% inferno-% Inferno-386-% inferno-386-%:V:
	mk 'SYSHOST=Inferno' 'OBJTYPE=386' $stem

Inferno-arm-% inferno-arm-%:V:
	mk 'SYSHOST=Inferno' 'OBJTYPE=arm' $stem

Plan9-% plan9-%:V:
	mk 'SYSHOST=Plan9' 'OBJTYPE=386' $stem

9front-% 9front-%:V:
	mk 'SYSHOST=9front' 'OBJTYPE=amd64' $stem

Irix-% irix-%:V:
	mk 'SYSHOST=Irix' 'OBJTYPE=mips' $stem

Linux-% linux-%:V:
	mk 'SYSHOST=Linux' 'OBJTYPE=386' $stem

NetBSD-% netbsd-%:V:
	mk 'SYSHOST=NetBSD' 'OBJTYPE=386' $stem

Nt-% nt-% Win95-% win95-%:V:
	mk 'SYSHOST=Nt' 'OBJTYPE=386' $stem

Solaris-% solaris-%:V:
	mk 'SYSHOST=Solaris' 'OBJTYPE=sparc' $stem

mkdirs:V:	mkdirs-$SHELLTYPE

mkdirs-rc:V:
	mkdir -p `{cat lib/emptydirs}
	chmod 555 mnt/* n/client/* n/*

mkdirs-sh:V:
	mkdir -p `cat lib/emptydirs`
	chmod 555 mnt/* n/client/* n/*

mkdirs-nt:V:
	mkdir -p `{cmd /c type lib\emptydirs}

# got the below ideas from plan9front/sys/lib/dist/mkfile
#	can only be used on 9front. should technically work on plan9 and inferno too.

# build iso using 9front's 9bootfat
#	details in 9front's
#		/sys/lib/dist/mkfile
#		/sys/src/boot/{pc,efi}/mkfile
# TODO
#	inferno manual talks about plan9.ini being in / and not cfg/
root=$ROOT
cd:V:	/tmp/9ferno.386.iso.gz

%.gz:D:	%
	gzip -9 < $prereq > $target

%.386.iso:
	@{rfork n
	objtype=386
	kernel=/n/src9/Inferno/$objtype/ipc
	mk binds
	mk $target.$pid.pc.iso
	mv $target.$pid.pc.iso $target
	}

%.amd64.iso:
	@{rfork n
	objtype=amd64
	kernel=/n/src9/Inferno/$objtype/ipc64
	mk binds
	mk $target.$pid.pc.iso
	mv $target.$pid.pc.iso $target
	}

# 9boot iso.c is not able to read /Inferno/amd64/ipc64 but works fine with ipc64
#	it needs the filenames to be lower cased
#	Hence, putting the kernels and plan9.ini in / as we do with fat partitions
# TODO correct/fix the warnings due to the proto files
%.pc.iso:D:	install kernelinstall
	@{rfork n
	mk binds
	{	#echo 'console=0 b115200'
		#echo '*dumpmp=1'
		#echo '*apicdebug=1'
		#echo '*nomp=1'
		echo 'cdboot=1'
		echo 'sys=bootcd'
		grep -v '^bootfile=' /n/src9/os/pc/plan9.ini
		#echo 'bootfile='^`{echo $kernel | sed 's!^/n/src9!!'}
		#echo 'bootfile=9pc64'
		echo 'bootfile=ipc64'
		echo wait
	} > /env/plan9.ini
	bind /env/plan9.ini /n/src9/plan9.ini
	cat /n/src9/plan9.ini
	disk/mk9660 -c9j -B Inferno/386/9bootiso -E Inferno/386/efiboot.fat \
		-p <{echo ipc64; echo 9pc64; echo plan9.ini; \
				cat /n/src9/lib/proto/^(9boot inferno os src utils);} \
		-s /n/src9 -v 'Inferno 9 Front ('^$objtype^')' $target
	if(test -r /n/src9/Inferno/386/9boothyb){
		dd -if /dev/zero -bs 2048 -count 1024 >> $target
		disk/partfs -m /n/partfs $target
		disk=/n/partfs/sdXX
		disk/mbr -m /n/src9/Inferno/386/mbr $disk/data
		@{echo a p1 '$-1' '$'
			echo t p1 ESP
			echo A p1
			echo w
			echo q} | disk/fdisk -b $disk/data
		disk/format -b /n/src9/Inferno/386/pbs -xd -t hard $disk/esp
		s = esp.$pid
		dossrv -f $disk/esp $s
		mount -c /srv/$s /n/esp
		cp /n/src9/Inferno/386/9boothyb /n/esp/9bootfat
		mkdir /n/esp/efi
		mkdir /n/esp/efi/boot
		cp /n/src9/Inferno/386/boot*.efi /n/esp/efi/boot
		unmount /n/esp
		rm -f /srv/$s
	}}

# backup kernel 9pc64 when building on 9front
# stub directories needed by proto files
binds:V:
	bind $root /n/src9
	aux/stub /n/src9/plan9.ini
	aux/stub /n/src9/ipc64
	bind $kernel /n/src9/ipc64
	aux/stub /n/src9/9pc64
	aux/stub /n/src9/9front/amd64/9pc64
	test -f /root/amd64/9pc64 && { \
		bind /root/amd64/9pc64 /n/src9/9front/amd64/9pc64
		bind /root/amd64/9pc64 /n/src9/9pc64
	} || {
		bind /dev/null /n/src9/9front/amd64/9pc64
		bind /dev/null /n/src9/9pc64
	}
	for(b in chan dev env net net.alt nvfs prof prog sys wrap){
		aux/stub -d /n/src9/^$b
	}
	# ns

# obsolete rules to be deleted
%inferno.amd64.iso:D: /root/386/9bootiso /root/386/mbr /root/386/pbs
	ROOT=/mnt/term/home/j/local/plan9/custom/inferno-os
	rm -fr $target 386 amd64 cfg
	@{rfork n
		mkdir 386
		mkdir cfg
		mkdir amd64
		cp /root/386/^(9bootiso mbr pbs) 386
		cp /root/386/9pc 386
		cp /root/amd64/9pc64 amd64
		cp $ROOT/Inferno/amd64/bin/ipc64 amd64
		cp /sys/lib/dist/cfg/plan9.ini cfg/plan9.ini
		echo '-----' cfg/plan9.ini '-----'
		echo 'console=0 b115200' >>cfg/plan9.ini
		echo 'bootfile=/amd64/ipc64' >>cfg/plan9.ini
		# echo 'bootfile=/amd64/9pc64' >>cfg/plan9.ini
		# echo wait >>cfg/plan9.ini
		cat cfg/plan9.ini
		echo '        ' '-----'
		disk/mk9660 -c9j -B 386/9bootiso -p <{echo +} -s $ROOT -v 'Inferno amd64' $target
		rm -fr 386 amd64 cfg
	}
	test -d /mnt/term/tmp && cp -x $target /mnt/term/$target

%inferno.amd64.hybrid.iso:D: /root/386/9bootiso /root/386/9boothyb /root/386/9bootfat /root/386/9bootpxe /root/386/mbr /root/386/pbs /root/386/efiboot.fat /root/386/bootia32.efi /root/386/bootx64.efi
	ROOT=/mnt/term/home/j/local/plan9/custom/inferno-os
	rm -fr 386 cfg efi $target
	@{rfork n
		mkdir 386
		mkdir cfg
		mkdir efi
		mkdir efi/boot
		cp /root/386/^(9bootiso 9boothyb 9bootfat 9bootpxe mbr pbs efiboot.fat bootia32.efi bootx64.efi) 386
		cp /root/386/^(bootia32.efi bootx64.efi) efi/boot
		cp /root/386/9pc 386
		cp /sys/lib/dist/cfg/plan9.ini cfg/plan9.ini
		echo cfg/plan9.ini '-----'
		echo 'console=0 b115200' >>cfg/plan9.ini
		echo 'bootfile=Inferno/amd64/bin/ipc64' >>cfg/plan9.ini
		echo wait >>cfg/plan9.ini
		cat cfg/plan9.ini
		echo '           ' '-----'
		disk/mk9660 -c9j -B 386/9bootiso -E 386/efiboot.fat -p <{echo +} -s $ROOT -v 'Inferno amd64' $target
		@{rfork n
			bind /root/386/9boothyb /root/386/9bootfat
			dd -if /dev/zero -bs 512 -count 4096 >> $target
			disk/partfs -m /n/partfs $target
			disk=/n/partfs/sdXX
			disk/mbr -m /root/386/mbr $disk/data
			@{echo a p1 '$-1' '$'
				echo t p1 FAT16
				echo A p1
				echo w
				echo q} | disk/fdisk -b $disk/data
			disk/format -b /root/386/pbs -d -r 1 $disk/dos /root/386/9bootfat
		}
		rm -fr 386 cfg efi
	}
