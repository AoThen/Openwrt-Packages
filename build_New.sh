#!/bin/sh

echo PKGNAME: "$PKGNAME"

# [ -n "${PKGNAME}" ] && PKGNAME="luci-app-alist"

# echo PKGNAME: "$PKGNAME"

WORKDIR="$(pwd)"

# sudo -E apt-get update
# sudo -E apt-get install git  asciidoc bash bc binutils bzip2 fastjar flex gawk gcc genisoimage gettext git intltool jikespg libgtk2.0-dev libncurses5-dev libssl-dev make mercurial patch perl-modules python2.7-dev rsync ruby sdcc subversion unzip util-linux wget xsltproc zlib1g-dev zlib1g-dev golang -y

# sudo -E apt-get install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
# bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
# git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev \
# libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev \
# libssl-dev libtool lrzsz mkisofs msmtp ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 \
# python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion swig texinfo \
# uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev

git config --global user.email "${EMAIL}"
git config --global user.name "${NAME}"
[ -n "${PASSWORD}" ] && git config --global user.password "${PASSWORD}"

mkdir -p ${WORKDIR}/buildsource
# mkdir -p  ${WORKDIR}/buildsource/NetSpeedTest
# mkdir -p  ${WORKDIR}/buildsource/openclash
# mkdir -p  ${WORKDIR}/buildsource/smartdns
# mkdir -p  ${WORKDIR}/buildsource/luci-app-passwall
# mkdir -p  ${WORKDIR}/buildsource/luci-app-passwall2
# mkdir -p  ${WORKDIR}/buildsource/passwall_packages
# cd  ${WORKDIR}/buildsource

# git clone  --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git  openwrt-sdk
# cd openwrt-sdk

# git clone  --depth 1 https://github.com/openwrt/openwrt.git -b openwrt-21.02  openwrt-sdk
# cp -f MT2500-3.config openwrt-sdk/.config
cd openwrt-sdk

case "$PKGNAME" in
"ALLAPP")

    cd ..
    # rm -rf openwrt-sdk
    # git clone --depth=1 https://github.com/hanwckf/immortalwrt-mt798x.git openwrt-sdk
    cp -f MT2500.config openwrt-sdk/.config
    cd openwrt-sdk
    git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
    # git clone --depth 1 https://github.com/AoThen/luci-theme-edge.git package/luci-theme-edge
    git clone --depth 1 https://github.com/AoThen/luci-app-cloudflarespeedtest.git package/luci-app-cloudflarespeedtest
    git clone --depth 1 https://github.com/AoThen/luci-app-adguardhome.git package/luci-app-adguardhome
    # find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
    # find ./ | grep Makefile | grep mosdns | xargs rm -f
    git clone --depth 1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
    # git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

    ;;
"luci-app-adguardhome")

    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    git clone --depth 1 https://github.com/AoThen/luci-app-adguardhome.git package/luci-app-adguardhome

    ;;
"luci-theme-argon")

    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

    ;;
"luci-app-netspeedtest")

    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    git clone --depth 1 https://github.com/AoThen/luci-app-netspeedtest.git package/luci-app-netspeedtest

    ;;
"luci-app-cloudflarespeedtest")

    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    # git clone --depth 1 https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git package/openwrt-cdnspeedtest
    echo "src-git cdnspeedtest https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git" >>"feeds.conf.default"
    echo "src-git lucicdnspeedtest https://github.com/AoThen/luci-app-cloudflarespeedtest.git" >>"feeds.conf.default"

    # git clone --depth 1 https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest.git package/luci-app-cloudflarespeedtest

    ;;
"alist" | \
    "luci-app-alist")

    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    git clone --depth 1 https://github.com/sbwml/luci-app-alist package/alist

    ;;
"mosdns" | \
    "luci-app-mosdns")

    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    # find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
    find ./ | grep Makefile | grep mosdns | xargs rm -f
    git clone --depth 1 https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
    git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

    ;;
"NetSpeedTest")
    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    git clone --depth 1 https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
    ;;
"smartdns" | \
    "luci-app-smartdns")
    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    echo 'src-git smartdns https://github.com/pymumu/openwrt-smartdns' >>feeds.conf.default
    echo 'src-git luci-app-smartdns https://github.com/pymumu/luci-app-smartdns' >>feeds.conf.default
    ;;
"openclash" | \
    "luci-app-openclash")
    # git clone --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git openwrt-sdk

    echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default
    ;;
"passwall2" | \
    "luci-app-passwall2")

    echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main" >>"feeds.conf.default"
    ;;
"passwall" | \
    "luci-app-passwall")

    echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >>"feeds.conf.default"
    ;;
"passwall_packages" | \
    "passwall_packages")
    # cd ..
    # rm -rf openwrt-sdk
    # git clone --depth=1 https://github.com/hanwckf/immortalwrt-mt798x.git openwrt-sdk
    # cp -f MT2500.config openwrt-sdk/.config
    # cd openwrt-sdk
    echo "src-git pspackages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >>"feeds.conf.default"

    # sudo apt install gcc-10 g++-10
    # sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 100
    # sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 100
    ./scripts/feeds clean -a
    ;;
*) ;;
esac

./scripts/feeds update -a
./scripts/feeds install -a

# rm -rf feeds/packages/lang/golang
# git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 21.x feeds/packages/lang/golang

# ./scripts/feeds update packages
# 更新go版本

# rm -rf ./feeds/packages/lang/golang
# svn co https://github.com/openwrt/packages/branches/openwrt-23.05/lang/golang ./feeds/packages/lang/golang

# cd ..
# mv .config openwrt-sdk/.config
# cd openwrt-sdk

# make savedefconfig

case "$PKGNAME" in
"ALLAPP")

    #下载包
    make download -j$(nproc)

    make -j$(nproc) || make -j1 V=s
    ;;
"luci-app-adguardhome")

    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)

    make ./package/luci-app-adguardhome/compile -j$(nproc) || make package/luci-app-adguardhome/compile -j1 V=sc

    ;;
"luci-app-cloudflarespeedtest")

    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)

    make ./package/feeds/cdnspeedtest/cdnspeedtest/compile -j$(nproc) || make package/feeds/cdnspeedtest/cdnspeedtest/compile -j1 V=sc
    make ./package/luci-app-cloudflarespeedtest/compile V=s -j$(nproc)

    ;;
"luci-theme-argon")
    # make toolchain/compile  V=s -j$(nproc) || make toolchain/compile V=s -j1
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    make ./package/luci-theme-argon/compile V=s -j1

    ;;
"luci-app-netspeedtest")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    make ./package/luci-app-netspeedtest/compile V=s -j1

    ;;
"alist" | \
    "luci-app-alist")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    make ./package/alist/luci-app-alist/compile V=s -j1

    ;;
"mosdns" | \
    "luci-app-mosdns")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    # make ./package/feeds/luci/luci-base/compile V=s -j1
    # rm -rf feeds/packages/net/v2ray-geodata
    # git clone --depth 1 https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

    make -j$(nproc) || make -j1 V=s
    # make ./package/mosdns/luci-app-mosdns/compile V=s -j1
    # find bin -type f -name "*.ipk"

    ;;
"NetSpeedTest")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    make ./package/netspeedtest/luci-app-netspeedtest/compile V=s -j1
    # find bin/packages -type f -name "*.ipk"
    ;;
"smartdns" | \
    "luci-app-smartdns")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    make V=s ./package/feeds/smartdns/smartdns/compile
    make V=s ./package/feeds/luci-app-smartdns/luci-app-smartdns/compile

    # find bin -type f -name "*.ipk" -exec cp -f {} "${WORKDIR}/buildsource/smartdns" \;
    ;;
"openclash" | \
    "luci-app-openclash")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    #修复openclash编译报错bash: po2lmo: command not found
    make ./package/feeds/luci/luci-base/compile V=s -j1
    # make -j1 V=s
    make V=s ./package/feeds/openclash/luci-app-openclash/compile -j$(nproc)
    # find bin/packages/aarch64_cortex-a53/openclash -type f -name "*.ipk" -exec cp -f {} "${WORKDIR}/buildsource/openclash" \;
    ;;
"passwall2" | \
    "luci-app-passwall2")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    make V=s ./package/feeds/passwall2/luci-app-passwall2/compile
    # find bin/packages/aarch64_cortex-a53 -type f -name "*.ipk" -exec cp -f {} "${WORKDIR}/buildsource/luci-app-passwall2" \;
    ;;
"passwall" | \
    "luci-app-passwall")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    make V=s ./package/feeds/passwall/luci-app-passwall/compile
    # find bin/packages/aarch64_cortex-a53/passwall -type f -name "*.ipk" -exec cp -f {} "${WORKDIR}/buildsource/luci-app-passwall" \;
    ;;
"passwall_packages")
    # echo 'CONFIG_ALL=y' >>.config
    # make defconfig
    # #下载包
    # make download -j$(nproc)
    pkgs=$(ls ./package/feeds/pspackages)

    # make -j$(nproc) ||  make -j1 V=s

    # 遍历所有包名
    for pkg in $pkgs; do
        # 编译每个包
        echo $pkg
        make ./package/feeds/pspackages/$pkg/compile -j$(nproc) || make ./package/feeds/pspackages/$pkg/compile -j1 V=sc || echo "Error building $pkg"
    done

    # find bin/packages/aarch64_cortex-a53/passwall_packages -type f -name "*.ipk" -exec cp -f {} "${WORKDIR}/buildsource/passwall_packages" \;
    ;;
*) ;;
esac

#优先使用多线程编译，出错则使用单线程并输出详细信息
# make -j$(nproc) ||  make -j1 V=s

# find . -name "*.ipk" -print

# find . -name "*.ipk" -exec cp -f {} "${WORKDIR}/buildsource" \;
