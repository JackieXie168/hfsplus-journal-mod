#
## Makefile for the linux hfsplus filesystem routines.
#

#obj-$(CONFIG_HFSPLUS_JOURNAL) += hfsplus_journal.o

hfsplus_journal-objs := super.o options.o inode.o ioctl.o extents.o catalog.o dir.o btree.o \
		bnode.o brec.o bfind.o tables.o unicode.o wrapper.o bitmap.o part_tbl.o journal.o \
		transaction.o commit.o recovery.o checkpoint.o revoke.o jbd_journal.o


obj= .

obj-m := hfsplus_journal.o
 	
INCS += -I.
-include $(TOPDIR)/Rules.make
STRIP=${TOOLPREFIX}strip

all:
	$(MAKE) -C ${KERNELPATH} SUBDIRS=$(shell pwd) modules

install: all
	$(STRIP) -S hfsplus_journal.o

clean:
	-rm -f *~ *.o *.ko *.mod.c Module.symvers modules.order
	-rm -f .version-* .*.o.flags .*.o.d .*.o.cmd .*.ko.cmd
	-rm -rf modules ipkg modules .built .configured .prepared

