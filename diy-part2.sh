#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i '155s/^#//' target/linux/rockchip/image/armv8.mk
sed -i 's/5.4/6.1/g' ./target/linux/rockchip/Makefile
rm -rf package/kernel/mac80211 
rm -rf package/kernel/rtl8821cu
rm -rf package/network/services/hostapd
svn export https://github.com/openwrt/openwrt/trunk/package/kernel/mac80211 package/kernel/mac80211
svn export https://github.com/openwrt/openwrt/trunk/package/network/services/hostapd package/network/services/hostapd
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile
sed -i '/uci commit system/i\uci set system.@system[0].hostname='GouPeng'' package/lean/default-settings/files/zzz-default-settings
sed -i "s/OpenWrt /goupeng build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
./scripts/feeds update -a
./scripts/feeds install -a
