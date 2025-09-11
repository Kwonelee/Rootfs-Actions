#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 集成开机脚本
cp $GITHUB_WORKSPACE/configfiles/99-custom.sh package/base-files/files/etc/uci-defaults/

# 添加定时限速
#git clone --depth=1 https://github.com/sirpdboy/luci-app-eqosplus package/luci-app-eqosplus

# 添加amlogic
#rm -rf package/luci-app-amlogic
#git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
