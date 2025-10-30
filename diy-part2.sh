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
# 集成config
wget -qO- https://raw.githubusercontent.com/Kwonelee/iStoreOS-Actions/refs/heads/main/files/etc/rc.local > package/base-files/files/etc/rc.local
#mkdir -p files/etc/opkg
#wget -qO- https://raw.githubusercontent.com/Kwonelee/iStoreOS-Actions/refs/heads/main/files/etc/opkg/distfeeds.conf > files/etc/opkg/distfeeds.conf

# 移除要替换的包
rm -rf feeds/packages/net/adguardhome
rm -rf feeds/third_party/luci-app-LingTiGameAcc
rm -rf feeds/luci/applications/luci-app-filebrowser

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
  mv -f $@ ../package/new
  cd .. && rm -rf $repodir
}

# golang
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# node
rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt feeds/packages/lang/node -b packages-24.10

# ophub/amlogic
git_sparse_clone main https://github.com/ophub/luci-app-amlogic luci-app-amlogic

# sbwml/openwrt_pkgs
git_sparse_clone main https://github.com/sbwml/openwrt_pkgs filebrowser luci-app-filebrowser-go luci-app-ramfree
