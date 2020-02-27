################################################################################
#
# python-usagedata
#
################################################################################

PYTHON_USAGEDATA_VERSION = 9e504b006796199df2d4b7c7d965ce0f119c834c
PYTHON_USAGEDATA_SITE = $(call github,hifiberry,usagecollector,$(PYTHON_USAGEDATA_VERSION))
PYTHON_USAGEDATA_SETUP_TYPE = setuptools
PYTHON_USAGEDATA_LICENSE = MIT
PYTHON_USAGEDATA_LICENSE_FILES = LICENSE.md

define PYTHON_USAGEDATA_POST_INSTALL_TARGET_CMD
	mkdir -p $(TARGET_DIR)/var/lib/hifiberry
endef

PYTHON_USAGEDATA_POST_INSTALL_TARGET_HOOKS += PYTHON_USAGEDATA_POST_INSTALL_TARGET_CMD

define PYTHON_USAGEDATA_INSTALL_INIT
	$(INSTALL) -D -m 0644 $(BR2_EXTERNAL_HIFIBERRY_PATH)/package/python-usagedata/datacollector.service \
		$(TARGET_DIR)/usr/lib/systemd/system/datacollector.service
	if [ -d $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants ]; then \
		ln -fs ../../../../usr/lib/systemd/system/datacollector.service \
			$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/datacollector.service; \
	fi
endef

PYTHON_USAGEDATA_POST_INSTALL_TARGET_HOOKS += PYTHON_USAGEDATA_INSTALL_INIT

$(eval $(python-package))
