include $(TOPDIR)/rules.mk


PKG_NAME:=redsocks2
PKG_VERSION:=0.67
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/semigodking/redsocks.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=b9cafa94664551362fb6a17b2933c1fefc14bf8f
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MAINTAINER:=semigodking  <semigodking@gmail.com>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/redsocks2
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Redirect any TCP connection to a SOCKS or HTTPS proxy server
	URL:=https://github.com/semigodking/redsocks
	DEPENDS:=+libevent2 +libopenssl +ipset
endef

define Package/redsocks2/description
This is a modified version of original redsocks. \
The name is changed to be REDSOCKS2 since this release to distinguish with original redsocks. \
This variant is useful for anti-GFW (Great Fire Wall).
endef

define Package/redsocks2/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/redsocks2 $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/redsocks2.config $(1)/etc/config/redsocks2
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/redsocks2.init $(1)/etc/init.d/redsocks2
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) ./files/chnroute.txt $(1)/etc/chnroute.txt
endef

$(eval $(call BuildPackage,redsocks2))
