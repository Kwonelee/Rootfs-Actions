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

# 添加turboacc
rm -rf feeds/luci/applications/luci-app-turboacc
git_sparse_clone luci https://github.com/chenmozhijin/turboacc luci-app-turboacc

#在线OTA
rm -rf package/diy/luci-app-ota
git_sparse_clone main https://github.com/sos801107/istoreos-ota luci-app-ota
git_sparse_clone main https://github.com/sos801107/istoreos-ota fw_download_tool

git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

# golong25.x依赖
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 必要的补丁
pushd
   curl -sSL https://raw.githubusercontent.com/Jaykwok2999/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
popd


./scripts/feeds update -a
./scripts/feeds install -a
