#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 添加定时限速
#git clone --depth=1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus

# 添加amlogic
rm -rf package/luci-app-amlogic
git clone --depth=1 https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

# 添加openlist2
git clone --depth=1 https://github.com/sbwml/luci-app-openlist2 package/openlist
