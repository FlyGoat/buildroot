################################################################################
#
# musl headers
#
################################################################################

MUSL_HEADERS_VERSION = $(MUSL_VERSION)
MUSL_HEADERS_SITE = $(MUSL_SITE)
MUSL_HEADERS_SOURCE = musl-$(MUSL_HEADERS_VERSION).tar.gz
MUSL_HEADERS_LICENSE = MIT
MUSL_HEADERS_LICENSE_FILES = COPYRIGHT
MUSL_HEADERS_DEPENDENCIES = host-clang linux-headers

# musl does not provide an implementation for sys/queue.h or sys/cdefs.h.
# So, add the musl-compat-headers package that will install those files,
# into the staging directory:
#   sys/queue.h:  header from NetBSD
#   sys/cdefs.h:  minimalist header bundled in Buildroot
MUSL_HEADERS_DEPENDENCIES += musl-compat-headers

# musl is part of the toolchain so disable the toolchain dependency
MUSL_HEADERS_ADD_TOOLCHAIN_DEPENDENCY = NO

MUSL_HEADERS_INSTALL_STAGING = YES
MUSL_HEADERS_INSTALL_TARGET = NO

define MUSL_HEADERS_CONFIGURE_CMDS
	$(MUSL_CONFIGURE_CMDS)
endef

define MUSL_HEADERS_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		DESTDIR=$(STAGING_DIR) install-headers
endef

$(eval $(generic-package))
