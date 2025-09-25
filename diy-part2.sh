#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# ================================================================
# DIY编译⬇⬇⬇
# ================================================================
# 移除要替换的包
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/third_party/luci-app-LingTiGameAcc
rm -rf feeds/luci/applications/luci-app-filebrowser
# istoreos-theme
rm -rf feeds/third/luci-theme-argon
rm -rf feeds/third/luci-app-argon-config

# Set Rust build arg llvm.download-ci-llvm to false.
RUST_MAKEFILE="feeds/packages/lang/rust/Makefile"
if [[ -f "${RUST_MAKEFILE}" ]]; then
  printf "Modifying %s...\n" "${RUST_MAKEFILE}"
  sed -i 's/--set=llvm\.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' "${RUST_MAKEFILE}"
else
  echo "File ${RUST_MAKEFILE} does not exist." >&2
fi

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 更新golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 常见插件
#git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash
#git_sparse_clone main https://github.com/gdy666/luci-app-lucky luci-app-lucky lucky
#git_sparse_clone main https://github.com/sbwml/luci-app-openlist2 luci-app-openlist2 openlist2
#git clone -b master https://github.com/w9315273/luci-app-adguardhome package/luci-app-adguardhome

# sbwml/luci-theme-argon
git_sparse_clone openwrt-24.10 https://github.com/sbwml/luci-theme-argon luci-theme-argon luci-app-argon-config

# 添加amlogic
git clone https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic

# sbwml/openwrt_pkgs
git_sparse_clone main https://github.com/sbwml/openwrt_pkgs luci-app-ramfree
git_sparse_clone main https://github.com/Kwonelee/package filebrowser luci-app-filebrowser-go
