#
# Makefile for the overlay filesystem.
#

obj-$(CONFIG_OVERLAY_FS) += overlay.o

overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
		copy_up.o export.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
