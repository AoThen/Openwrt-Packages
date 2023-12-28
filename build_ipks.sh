#!/bin/sh

EMAIL=${EMAIL:-"AoThen@GitHub.com"}
echo EMAIL: "$EMAIL"
echo PASSWORD: "$PASSWORD"

WORKDIR="$(pwd)"

sudo -E apt-get update
sudo -E apt-get install git  asciidoc bash bc binutils bzip2 fastjar flex gawk gcc genisoimage gettext git intltool jikespg libgtk2.0-dev libncurses5-dev libssl-dev make mercurial patch perl-modules python2.7-dev rsync ruby sdcc subversion unzip util-linux wget xsltproc zlib1g-dev zlib1g-dev -y

sudo -E apt-get install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libfuse-dev libglib2.0-dev libgmp3-dev \
libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libpython3-dev libreadline-dev \
libssl-dev libtool lrzsz mkisofs msmtp ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 \
python3-pyelftools python3-setuptools qemu-utils rsync scons squashfs-tools subversion swig texinfo \
uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev


git config --global user.email "${EMAIL}"
git config --global user.name "AoThen"
[ -n "${PASSWORD}" ] && git config --global user.password "${PASSWORD}"

mkdir -p  ${WORKDIR}/buildsource
# cd  ${WORKDIR}/buildsource


# git clone  --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git -b main passwall_packages
# git clone  --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git -b main passwall_packages


# cd  ${WORKDIR}


git clone  --depth 1 https://github.com/AoThen/openwrt-sdk-mt7981.git  openwrt-sdk
cd openwrt-sdk


echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"

# sed -i "1i\src-link githubaction ${WORKDIR}/buildsource" feeds.conf.default


# ls -l
# cat feeds.conf.default


./scripts/feeds update -a
./scripts/feeds install -a

# ./scripts/feeds update packages

rm -rf ./package/feeds/packages/lang/golang
#23.05？
svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang ./package/feeds/packages/lang/golang


cd ${WORKDIR}
mv .config openwrt-sdk/.config
cd openwrt-sdk
# echo CONFIG_ALL=y >.config
make defconfig

make download -j8

#修复bash: po2lmo: command not found
make ./package/feeds/luci/luci-base/compile V=s
make -j1 V=s

make V=s ./package/feeds/openclash/luci-app-openclash/compile

pkgs=$(ls ./package/feeds/passwall_packages)

# 遍历所有包名
for pkg in $pkgs
do
    # 编译每个包
    echo $pkg
    make V=s ./package/feeds/passwall_packages/$pkg/compile
done

make V=s ./package/feeds/passwall/luci-app-passwall/compile


# make -j$(nproc) || make -j1 || make -j1 V=s

find bin -type f -exec ls -lh {} \;
find bin -type f -name "*.ipk" -exec cp -f {} "${WORKDIR}/buildsource" \; 


# rm -rf feeds/packages/lang/golang
# git clone  --depth 1 https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang



