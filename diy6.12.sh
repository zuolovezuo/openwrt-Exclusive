#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================
sed -i 's/KERNEL_PATCHVER:=6.6/KERNEL_PATCHVER:=6.12/g' ./target/linux/x86/Makefile
sed -i '/openwrt-23.05/d' feeds.conf.default
sed -i '/openwrt-24.10/d' feeds.conf.default
sed -i 's/^#\(.*luci\)/\1/' feeds.conf.default
# sed -i '2i src-git luci https://github.com/coolsnowwolf/luci.git' feeds.conf.default


function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    # find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/custom/
    rm -rf $repo
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -rf
}

rm -rf package/custom; mkdir package/custom

# Add a feed source
# git clone https://github.com/fw876/helloworld.git package/ssr
git clone https://github.com/firker/diy-ziyong.git package/diy-ziyong
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge.git package/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon-18.06
git clone https://github.com/gngpp/luci-theme-neobird.git package/luci-theme-neobird
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
git clone https://github.com/sirpdboy/luci-app-advancedplus.git package/luci-app-advancedplus
git clone https://github.com/sirpdboy/luci-app-parentcontrol.git package/luci-app-parentcontrol
# find ./ | grep Makefile | grep mosdns | xargs rm -f
# git clone https://github.com/firkerword/openwrt-mos.git package/openwrt-mos
# git clone https://github.com/QiuSimons/openwrt-mos.git package/openwrt-mos
# find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/openwrt-passwall
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall
# git clone -b luci-smartdns-new-version https://github.com/xiaorouji/openwrt-passwall.git package/passwall
# git clone https://github.com/firkerword/luci-app-mosdns.git package/mosdns
# git clone https://github.com/xiaorouji/openwrt-passwall2.git package/passwall2
# find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
# find ./ | grep Makefile | grep mosdns | xargs rm -f
# git clone https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns
# git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone https://github.com/firkerword/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky
# git clone https://github.com/firkerword/luci-app-lucky.git package/lucky
chmod 755 ./package/lucky/luci-app-lucky/root/usr/bin/luckyarch
# git clone https://github.com/liudf0716/luci-app-apfree-wifidog.git package/wifidog
