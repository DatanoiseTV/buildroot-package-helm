HELM_VERSION=newui-patched-nojack
HELM_SITE=git://github.com/DatanoiseTV/helm.git
HELM_INSTALL_STAGING=YES

HELM_DEPENDENCIES = \
        host-pkgconf \
        freetype \
        libcurl \
        xlib_libXinerama \
        jack2 \
        mesa3d

HELM_MAKE_ENV = \
        PKG_CONFIG_SYSROOT_DIR="$(STAGING_DIR)" \
        PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig" \

define HELM_BUILD_CMDS
        $(HELM_MAKE_ENV) $(MAKE) CXX="$(TARGET_CXX)" CXXFLAGS="$(TARGET_CXXFLAGS) -I$(BUILD_DIR)/mesa3d-20.1.4/include" LDFLAGS="$(TARGET_LDFLAGS) -L$(TARGET_DIR)/usr/lib/" -C $(@D)/standalone/builds/linux
endef

define HELM_INSTALL_STAGING_CMDS
        $(INSTALL) -D -m 0755 $(@D)/standalone/builds/linux/build/helm $(STAGING_DIR)/bin/helm
endef

define HELM_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/standalone/builds/linux/build/helm $(TARGET_DIR)/bin/helm
endef

$(eval $(generic-package))
