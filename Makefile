# 
# Copyright (C) 2014 DNI
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/kernel-build.mk
include $(INCLUDE_DIR)/package.mk

PKG_NAME:=hfsplus-journal
PKG_VERSION:=2.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
KERNEL_CROSS:=mips-linux-

define KernelPackage/$(PKG_NAME)
  SUBMENU:=File System Support
  DEFAULT:=y
  TITLE:=HFS+ Module for HFS+ Journal
  DESCRIPTION:=\
	This package contains a HFS+ Journal kernel modules.
  URL:=http://www.dninetwork.com/
  VERSION:=$(LINUX_VERSION)+$(PKG_VERSION)-$(BOARD)-$(PKG_RELEASE)
  FILES:= $(PKG_BUILD_DIR)/*.ko
endef

KERNEL_MAKEOPTS=  PATH="$(KERNEL_STAGING_DIR):$(TARGET_PATH)" \
		TOOLPREFIX="$(KERNEL_CROSS)" \
		TOOLPATH="$(KERNEL_CROSS)"

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	ln -s ${PWD}/${PKG_NAME}-mod/src $(PKG_BUILD_DIR)
endef

define Build/Compile
	$(MAKE) -C $(LINUX_DIR) KERNELPATH="$(LINUX_DIR)" SUBDIRS=$(PKG_BUILD_DIR) MODVERDIR=$(PKG_BUILD_DIR)/modules modules $(KERNEL_MAKEOPTS)
endef

define Build/Clean
	rm -rf $(PKG_INSTALL_DIR)
	rm -rf $(PKG_BUILD_DIR)
endef

define Build/InstallDev
endef

define Build/UninstallDev
endef

define KernelPackage/$(PKG_NAME)/install
	echo "Install HFS+ Journal Kernel Module"
	$(STRIP) -S $(FILES)
	mkdir -p $(BUILD_DIR)/root/lib/modules/$(LINUX_VERSION)
	cp -f $(FILES) $(BUILD_DIR)/root/lib/modules/$(LINUX_VERSION)
endef

$(eval $(call KernelPackage,$(PKG_NAME)))
