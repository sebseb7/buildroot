################################################################################
#
# libreswan
#
################################################################################

LIBRESWAN_VERSION = 4.9
LIBRESWAN_SITE = $(call github,libreswan,libreswan,v$(LIBRESWAN_VERSION))
LIBRESWAN_LICENSE = GPL-2.0+
LIBRESWAN_LICENSE_FILES = 
LIBERSWAN_CPE_ID_VENDOR = libreswan

LIBRESWAN_DEPENDENCIES = host-bison host-flex gmp iproute2 libnss libevent libcap-ng libcurl
LIBRESWAN_MAKE_OPTS = ARCH=$(BR2_ARCH) CC="$(TARGET_CC)" POD2MAN="" XMLTO="" \
	USERCOMPILE="$(TARGET_CFLAGS) $(if $(BR2_TOOLCHAIN_SUPPORTS_PIE),-fPIE)" \
	USERLINK="$(TARGET_LDFLAGS) $(if $(BR2_TOOLCHAIN_SUPPORTS_PIE),-fPIE)" \
	PREFIX=/usr INITSYSTEM=sysvinit OPTIMIZE_CFLAGS="-O2" USE_AUTHPAM=false USE_DNSSEC=false USE_LIBCURL=true USE_XFRM=true USE_UNBOUND=false USE_MAST=false USE_NM=false \
	USE_NOMANINSTALL=true WERROR=""

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBRESWAN_DEPENDENCIES += openssl
LIBRESWAN_MAKE_OPTS += HAVE_OPENSSL=true
ifeq ($(BR2_PACKAGE_OCF_LINUX),y)
LIBRESWAN_MAKE_OPTS += HAVE_OCF=true
endif
endif

define LIBRESWAN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) \
		$(LIBRESWAN_MAKE_OPTS) base
endef

define LIBRESWAN_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) \
		$(LIBRESWAN_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install-base
endef

$(eval $(generic-package))
