#!/bin/bash
#=================================================
# Description: Build OpenWrt using GitHub Actions
WORKDIR=/workdir
HOSTNAME=OpenWrt
IPADDRESS=192.168.8.1
SSID=Sirpdboy
ENCRYPTION=psk2
KEY=123456

# ʹ�� O2 ������Ż�
# sed -i 's/O3/O2/g' include/target.mk
git clone https://github.com/sirpdboy/build.git ./package/build
git clone https://github.com/sirpdboy/sirpdboy-package ./package/diy


rm -rf ./feeds/luci/themes/luci-theme-argon
rm -rf ./feeds/luci/applications/luci-theme-opentomcat
rm -rf ./feeds/luci/applications/luci-app-wrtbwmon
rm -rf ./feeds/luci/applications/luci-app-mentohust 
rm -rf ./feeds/packages/net/MentoHUST-OpenWrt-ipk
rm -rf ./feeds/luci/applications/luci-proto-minieap
# rm -rf ./feeds/luci/applications/luci-app-cpufreq
rm -rf ./package/diy/luci-app-cpufreq

# version=$(grep "DISTRIB_REVISION=" package/lean/default-settings/files/zzz-default-settings  | awk -F "'" '{print $2}')
# sed -i '/root:/d' ./package/base-files/files/etc/shadow
# sed -i 's/root::0:0:99999:7:::/root:$1$tzMxByg.$e0847wDvo3JGW4C3Qqbgb.:19052:0:99999:7:::/g' ./package/base-files/files/etc/shadow   #tiktok
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' ./package/base-files/files/etc/shadow    #password

#sed -i 's/US/CN/g ; s/OpenWrt/iNet/g ; s/none/psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i "s/hostname='OpenWrt'/hostname='${HOSTNAME}'/g" package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

echo '�滻smartdns'
# rm -rf ./package/diy/smartdns
rm -rf ./feeds/packages/net/smartdns&& svn co https://github.com/sirpdboy/sirpdboy-package/trunk/smartdns ./feeds/packages/net/smartdns
rm -rf ./feeds/luci/applications/luci-app-netdata && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./feeds/luci/applications/luci-app-netdata
rm -rf ./feeds/packages/admin/netdata && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./feeds/packages/admin/netdata
cat  ./package/build/mwan3/files/etc/config/mwan3   > ./feeds/packages/net/mwan3/files/etc/config/mwan3 && rm -rf ./package/build/mwan3
# rm -rf ./package/build/mwan3 && curl -fsSL  https://raw.githubusercontent.com/sirpdboy/build/master/mwan3/files/etc/config/mwan3   > ./feeds/packages/net/mwan3/files/etc/config/mwan3
# rm -rf ./feeds/packages/net/mwan3 && svn co https://github.com/sirpdboy/build/trunk/mwan3 ./feeds/packages/net/mwan3
# rm -rf ./feeds/packages/net/https-dns-proxy  && svn co https://github.com/Lienol/openwrt-packages/trunk/net/https-dns-proxy ./feeds/packages/net/https-dns-proxy
# rm -rf ./feeds/packages/devel/ninja   && svn co https://github.com/Lienol/openwrt-packages/trunk/devel/ninja feeds/packages/devel/ninja
rm -rf ./package/build/miniupnpd  
# rm -rf ./feeds/packages/net/miniupnpd  && svn co https://github.com/sirpdboy/build/trunk/miniupnpd ./feeds/packages/net/miniupnpd
rm -rf ./package/emortal/automount
rm -rf ./package/emortal/autosamba
rm -rf ./feeds/luci/applications/luci-app-accesscontrol
# rm -rf ./package/build/autocore
rm -rf ./package/emortal/autocore
rm -rf ./package/emortal/default-settings
# rm -rf ./feeds/luci/applications/luci-app-ramfree
rm -rf ./feeds/luci/applications/luci-app-arpbind
rm -rf ./feeds/luci/applications/luci-app-docker
rm -rf ./feeds/luci/applications/luci-app-dockerman

# rm -rf ./feeds/packages-master/utils/docker


# rm -rf ./feeds/luci/applications/luci-app-vlmcsd
# rm -rf ./feeds/luci/applications/vlmcsd 


pushd feeds/luci/applications

# Add luci-aliyundrive-webdav
rm -rf ./luci-app-aliyundrive-webdav 
rm -rf ./aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav

# Add ddnsto & linkease
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease
svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease
sed -i 's/1/0/g' linkease/files/linkease.config

#zerotier
rm -rf  luci-app-zerotier && git clone https://github.com/rufengsuixing/luci-app-zerotier.git
sed -i '/45)./d' luci-app-zerotier/luasrc/controller/zerotier.lua  #zerotier
sed -i 's/vpn/services/g' luci-app-zerotier/luasrc/controller/zerotier.lua   #zerotier
sed -i 's/vpn/services/g' luasrc/view/zerotier/zerotier_status.htm   #zerotier

#syncdial
rm -rf luci-app-syncdial  && git clone https://github.com/rufengsuixing/luci-app-syncdial.git 
popd

rm -rf ./feeds/luci/applications/luci-app-baidupcs-web && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-baidupcs-web ./feeds/luci/applications/luci-app-baidupcs-web
# ksmbd
rm -rf ./feeds/packages/net/ksmbd-tools 
# svn co https://github.com/sirpdboy/build/trunk/ksmbd-tools ./feeds/packages/net/ksmbd-tools
rm -rf ./feeds/luci/applications/luci-app-samba 
# svn co https://github.com/sirpdboy/build/trunk/luci-app-samba ./feeds/luci/applications/luci-app-samba
rm -rf ./package/network/services/samba36 
svn co https://github.com/sirpdboy/build/trunk/samba36 ./package/network/services/samba36

# samba4
rm -rf ./package/build/samba4
# rm -rf ./feeds/packages/net/samba4 && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/samba4 ./feeds/packages/net/samba4
# rm -rf ./feeds/packages/net/samba4 && svn co https://github.com/sirpdboy/sirpdboy-package/trunk/samba4 ./package/build/set/samba4
rm -rf ./feeds/luci/applications/luci-app-samba4 &&svn co https://github.com/sirpdboy/build/trunk/luci-app-samba4 ./feeds/luci/applications/luci-app-samba4

git clone --depth 1 https://github.com/zxlhhyccc/luci-app-v2raya.git package/new/luci-app-v2raya
svn co https://github.com/v2rayA/v2raya-openwrt/trunk/v2raya package/new/v2raya

# Boost ͨ�ü��弴��
# curl -fsSL https://raw.githubusercontent.com/loso3000/other/master/patch/autocore/files/x86/index.htm > package/lean/autocore/files/x86/index.htm
# curl -fsSL https://raw.githubusercontent.com/loso3000/other/master/patch/autocore/files/arm/index.htm > package/lean/autocore/files/arm/index.htm
# curl -fsSL  https://raw.githubusercontent.com/loso3000/other/master/patch/default-settings/zzz-default-settings1 > ./package/build/default-settings/files/zzz-default-settings
# curl -fsSL  https://raw.githubusercontent.com/sirpdboy/sirpdboy-package/master/set/sysctl.conf > ./package/base-files/files/etc/sysctl.conf
echo '��ӹػ�'
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm 
curl -fsSL  https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

sed -i 's/����洢/�洢/g' ./feeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/Turbo ACC �������/ACC�������/g' ./feeds/luci/applications/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/Turbo ACC �������/ACC�������/g' ./feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/Turbo ACC �������/ACC�������/g' ./feeds/luci/applications/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/���������ƻ�ɫ����/������ɫ����/g' ./feeds/luci/applications/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
sed -i 's/��ͥ��//g' ./feeds/luci/applications/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i 's/ʵʱ�������/����/g' ./feeds/luci/applications/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/KMS ������/KMS����/g' ./feeds/luci/applications/luci-app-vlmcsd/po/zh-cn/vlmcsd.po
sed -i 's/USB ��ӡ������"/��ӡ����/g' ./feeds/luci/applications/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/����洢/�洢/g' ./feeds/luci/applications/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/aMule����/��¿����/g' ./feeds/luci/applications/luci-app-amule/po/zh-cn/amule.po
sed -i 's/����洢/�洢/g' ./feeds/luci/applications/luci-app-amule/po/zh-cn/amule.po
sed -i 's/�����˿�/�����˿� �û���admin����adminadmin/g' ./feeds/luci/applications/luci-app-qbittorrent/po/zh-cn/qbittorrent.po
sed -i 's/������/���/g' ./feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
sed -i 's/a.default = "0"/a.default = "1"/g' ./feeds/luci/applications/luci-app-cifsd/luasrc/controller/cifsd.lua   #������
echo  "        option tls_enable 'true'" >> ./feeds/luci/applications/luci-app-frpc/root/etc/config/frp   #FRP��͸����
sed -i 's/invalid/# invalid/g' ./package/network/services/samba36/files/smb.conf.template  #��������
sed -i '/mcsub_renew.datatype/d'  ./feeds/luci/applications/luci-app-udpxy/luasrc/model/cbi/udpxy.lua  #�޸�UDPXY������ʱ55�Ĵ���

sed -i '/filter_/d' ./package/network/services/dnsmasq/files/dhcp.conf   #DHCP����IPV6����
sed -i 's/�������û��������롣/��ӭʹ��!�������û�����~/g' ./feeds/luci/modules/luci-base/po/zh-cn/base.po   #�û�������
echo '��ɫ����'
rm -rf ./feeds/luci/applications/luci-app-unblockmusic
git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic.git  ./package/diy/luci-app-unblockneteasemusic
sed -i 's/������������ֲ�������/������ɫ����/g' ./package/diy/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua


#����nat���� 
cat ./package/build/set/sysctl.conf >>  package/base-files/files/etc/sysctl.conf
#���������� 
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf
# ���������
sed -i 's/65535/165535/g' ./package/kernel/linux/files/sysctl-nf-conntrack.conf
# ipv6
# # sed -i "s/6.ifname='$ifname'/6.ifname='@wan'/g" package/base-files/files/bin/config_generate
# sed -i "s/6.ifname='@${1}'/6.ifname='@wan'/g" package/base-files/files/bin/config_generate

#docker err
#rm -rf ./feeds/packages/utils/runc/Makefile
#svn export https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

#echo "�����޸�"
sed -i 's/option commit_interval 24h/option commit_interval 2h/g' feeds/packages/net/nlbwmon/files/nlbwmon.config #�޸�����ͳ��д��Ϊ2
sed -i 's#option database_directory /var/lib/nlbwmon#option database_directory /etc/config/nlbwmon_data#g' feeds/packages/net/nlbwmon/files/nlbwmon.config #�޸�����ͳ�����ݴ��Ĭ��λ��
# sed -i 's@interval: 5@interval: 2@g' package/lean/luci-app-wrtbwmon/htdocs/luci-static/wrtbwmon.js #wrtbwmonĬ��ˢ��ʱ�����Ϊ1��


# echo 'Ĭ�Ͽ��� Irqbalance'
# sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

cat ./package/build/profile > package/base-files/files/etc/profile


git clone https://github.com/kiddin9/luci-app-dnsfilter package/luci-app-dnsfilter

echo '�滻aria2'
rm -rf feeds/luci/applications/luci-app-aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-aria2 feeds/luci/applications/luci-app-aria2
rm -rf feeds/packages/net/aria2 && \
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/net/aria2 feeds/packages/net/aria2


# svn co https://github.com/small-5/luci-app-adblock-plus/trunk/ ./package/diy/luci-app-adblock-plus

#sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/x86/image/64.mk

echo '
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_DRM=y
CONFIG_DRM_I915=y
' >> ./target/linux/x86/config-5.4


# svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns package/new/mosdns
# svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/new/luci-app-mosdns
# sed -i "/filter_aaaa='1'/d" package/new/luci-app-mosdns/root/etc/init.d/mosdns


git clone https://github.com/iwrt/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
sed -i 's,1).dep,11).dep,g' ./package/luci-app-ikoolproxy/luasrc/controller/koolproxy.lua  #koolproxy

svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash ./package/diy/luci-app-openclash

git clone -b master --single-branch https://github.com/destan19/OpenAppFilter ./package/diy/OpenAppFilter

# Fix libssh
# rm -rf feeds/packages/libs
# svn co https://github.com/openwrt/packages/trunk/libs/libssh feeds/packages/libs/
# Add apk (Apk Packages Manager)
# svn co https://github.com/openwrt/packages/trunk/utils/apk package/new/

# Add luci-udptools
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/luci-udptools  package/new/
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/udp2raw package/new/
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/udpspeeder package/new/

# Add subconverter
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter  package/new/

# rm -rf ./feeds/packages/utils/runc/Makefile
# svn export https://github.com/openwrt/packages/trunk/utils/runc/Makefile ./feeds/packages/utils/runc/Makefile

# Add luci-app-dockerman
# rm -rf ./feeds/luci/collections/luci-lib-docker
# git clone --depth=1 https://github.com/lisaac/luci-lib-docker ./feeds/luci/collections/luci-lib-docker

rm -rf ./packages/build/ddns-scripts_dnspod
rm -rf ./package/lean/ddns-scripts_aliyun
# rm -rf ./package/lean/ddns-scripts_dnspod
svn co https://github.com/sirpdboy/build/trunk/ddns-scripts_aliyun package/lean/ddns-scripts_aliyun
# svn co https://github.com/sirpdboy/build/trunk/ddns-scripts_dnspod package/lean/ddns-scripts_dnspod

# Passwall
rm -rf ./feeds/packages/net/pdnsd-alt
rm -rf ./feeds/packages/net/shadowsocks-libev
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/brook
rm -rf ./feeds/packages/net/chinadns-ng
rm -rf ./feeds/packages/net/dns2socks
rm -rf ./feeds/packages/net/hysteria
rm -rf ./feeds/packages/net/ipt2socks
rm -rf ./feeds/packages/net/microsocks
rm -rf ./feeds/packages/net/naiveproxy
rm -rf ./feeds/packages/net/shadowsocks-rust
rm -rf ./feeds/packages/net/simple-obfs
rm -rf ./feeds/packages/net/ssocks
rm -rf ./feeds/packages/net/tcping
rm -rf ./feeds/packages/net/v2ray*
rm -rf ./feeds/packages/net/xray*
rm -rf ./feeds/packages/net/trojan*
rm -rf ./package/build/pass/luci-app-passwall
#bypass
#sed -i 's,default n,default y,g' ./package/build/pass/luci-app-bypass/Makefile
rm -rf package/build/pass/luci-app-bypass
git clone https://github.com/kiddin9/openwrt-bypass package/bypass
sed -i 's,default n,default y,g' ./package/bypass/luci-app-bypass/Makefile

#  git clone https://github.com/loso3000/openwrt-passwall package/passwall
svn co https://github.com/loso3000/openwrt-passwall/trunk/luci-app-passwall package/passwall/luci-app-passwall
pushd package/passwall/luci-app-passwall
sed -i 's,default n,default y,g' Makefile
sed -i '/trojan-go/d' Makefile
sed -i '/v2ray-core/d' Makefile
sed -i '/v2ray-plugin/d' Makefile
sed -i '/xray-plugin/d' Makefile
sed -i '/shadowsocks-libev-ss-redir/d' Makefile
sed -i '/shadowsocks-libev-ss-server/d' Makefile
sed -i '/shadowsocks-libev-ss-local/d' Makefile
popd
pushd package/pass/luci-app-ssr-plus
sed -i 's,default n,default y,g' Makefile
sed -i '/trojan-go/d' Makefile
sed -i '/v2ray-core/d' Makefile
sed -i '/v2ray-plugin/d' Makefile
sed -i '/xray-plugin/d' Makefile
sed -i '/shadowsocks-libev-ss-redir/d' Makefile
sed -i '/shadowsocks-libev-ss-server/d' Makefile
sed -i '/shadowsocks-libev-ss-local/d' Makefile
popd

svn co https://github.com/loso3000/openwrt-passwall/trunk/tcping package/new/tcping
svn co https://github.com/loso3000/openwrt-passwall/trunk/trojan-go package/new/trojan-go
svn co https://github.com/loso3000/openwrt-passwall/trunk/brook package/new/brook
svn co https://github.com/QiuSimons/OpenWrt-Add/trunk/trojan-plus package/new/trojan-plus
svn co https://github.com/loso3000/openwrt-passwall/trunk/ssocks package/new/ssocks
svn co https://github.com/loso3000/openwrt-passwall/trunk/hysteria package/new/hysteria

echo ' ShadowsocksR Plus+'
# git clone https://github.com/fw876/helloworld package/ssr
# rm -rf  ./package/ssr/luci-app-ssr-plus
# ShadowsocksR Plus+ ����
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/shadowsocks-libev
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/pdnsd-alt
svn co https://github.com/coolsnowwolf/packages/trunk/net/shadowsocks-libev package/lean/shadowsocks-libev
svn co https://github.com/loso3000/openwrt-passwall/trunk/shadowsocksr-libev package/lean/shadowsocksr-libev
svn co https://github.com/loso3000/openwrt-passwall/trunk/pdnsd-alt package/lean/pdnsd-alt
svn co https://github.com/loso3000/openwrt-passwall/trunk/chinadns-ng package/lean/chinadns-ng
svn co https://github.com/loso3000/openwrt-passwall/trunk/hysteria package/lean/hysteria
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/srelay package/lean/srelay
svn co https://github.com/loso3000/openwrt-passwall/trunk/microsocks package/lean/microsocks
svn co https://github.com/loso3000/openwrt-passwall/trunk/dns2socks package/lean/dns2socks
svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/lean/redsocks2
svn co https://github.com/loso3000/openwrt-passwall/trunk/ipt2socks package/lean/ipt2socks
svn co https://github.com/loso3000/openwrt-passwall/trunk/trojan package/lean/trojan
svn co https://github.com/loso3000/openwrt-passwall/trunk/tcping package/lean/tcping
svn co https://github.com/loso3000/openwrt-passwall/trunk/trojan-go package/lean/trojan-go
svn co https://github.com/fw876/helloworld/trunk/simple-obfs package/lean/simple-obfs
svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/lean/naiveproxy
svn co https://github.com/fw876/helloworld/trunk/v2ray-core package/lean/v2ray-core
svn co https://github.com/fw876/helloworld/trunk/xray-core package/lean/xray-core
svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/lean/v2ray-plugin
svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/lean/xray-plugin
svn co https://github.com/loso3000/openwrt-passwall/trunk/shadowsocks-rust package/lean/shadowsocks-rust
svn co https://github.com/immortalwrt/packages/trunk/net/kcptun feeds/packages/net/kcptun

# VSSR
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  ./package/lean/luci-app-vssr
# git clone -b master --depth 1 https://github.com/jerrykuku/luci-app-vssr.git package/lean/luci-app-vssr
# git clone -b master --depth 1 https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb
sed -i 's,default n,default y,g' ./package/lean/luci-app-vssr/Makefile
#sed -i '/result.encrypt_method/a\result.fast_open = "1"' package/lean/luci-app-vssr/root/usr/share/vssr/subscribe.lua
#sed -i 's,ispip.clang.cn/all_cn.txt,raw.sevencdn.com/QiuSimons/Chnroute/master/dist/chnroute/chnroute.txt,g' package/lean/luci-app-vssr/luasrc/controller/vssr.lua
#sed -i 's,ispip.clang.cn/all_cn.txt,raw.sevencdn.com/QiuSimons/Chnroute/master/dist/chnroute/chnroute.txt,g' package/lean/luci-app-vssr/root/usr/share/vssr/update.lua


# �� X86 �ܹ����Ƴ� Shadowsocks-rust
sed -i '/Rust:/d' package/passwall/luci-app-passwall/Makefile
sed -i '/Rust:/d' package/lean/luci-app-vssr/Makefile
sed -i '/Rust:/d' ./package/build/pass/luci-ssr-plus/Makefile
sed -i '/Rust:/d' ./package/build/pass/luci-app-bypass/Makefile
sed -i '/Rust:/d' ./package/bypass/luci-app-bypass/Makefile
#
# svn co https://github.com/jerrykuku/luci-app-ttnode/trunk/  package/diy/luci-app-ttnode
# sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.4/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.4/g' ./target/linux/x86/Makefile
# sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile
# sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.4/g' ./target/linux/*/Makefile

# ʹ��Ĭ��ȡ���Զ�
# sed -i "s/bootstrap/chuqitopd/g" feeds/luci/modules/luci-base/root/etc/config/luci
# sed -i 's/bootstrap/chuqitopd/g' feeds/luci/collections/luci/Makefile
echo "�޸�Ĭ������"
sed -i 's/+luci-theme-bootstrap/+luci-theme-opentopd/g' feeds/luci/collections/luci/Makefile
# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

rm -rf ./package/diy/luci-theme-edge
rm -rf ./package/build/luci-theme-darkmatter

svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/lean/luci-theme-atmaterial_new
git clone https://github.com/john-shine/luci-theme-darkmatter.git package/diy/darkmatter
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/diy/luci-theme-argon
git clone -b 18.06  https://github.com/kiddin9/luci-theme-edge.git package/new/luci-theme-edge

#luci-app-filebrowser
svn co https://github.com/immortalwrt/luci/branches/openwrt-18.06/applications/luci-app-filebrowser ./feeds/luci/applications/
svn co https://github.com/immortalwrt/packages/branches/openwrt-18.06/net/filebrowser ./feeds/packages/net/

# git clone https://github.com/openwrt-dev/po2lmo.git
# cd po2lmo
# make && sudo make install

# Fix SDK
# sed -i '/$(SDK_BUILD_DIR)\/$(STAGING_SUBDIR_HOST)\/usr\/bin/d;/LICENSE/d' ./target/sdk/Makefile


# echo 'Ĭ�Ͽ��� Irqbalance'
# sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
# str1=`grep "KERNEL_PATCHVER:="  ./Makefile | cut -d = -f 2` 
ver1=`grep "KERNEL_PATCHVER:="  target/linux/x86/Makefile | cut -d = -f 2` #�жϵ�ǰĬ���ں˰汾����5.10
export VER2="$(grep "KERNEL_PATCHVER:="  ./target/linux/x86/Makefile | cut -d = -f 2)"
date1='Ipv6-Mini-S'`TZ=UTC-8 date +%Y.%m.%d -d +"12"hour`
# date1='Ipv6-S2022.02.01'
if [ "$VER2" = "5.4" ]; then
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Mini-5.4-/g' include/image.mk
elif [ "$VER2" = "5.10" ]; then
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Mini-5.10-/g' include/image.mk
elif [ "$VER2" = "5.15" ]; then
    sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/$(shell TZ=UTC-8 date +%Y%m%d -d +12hour)-Ipv6-Mini-5.15-/g' include/image.mk
fi
# sed -i 's/$(VERSION_DIST_SANITIZED)-$(IMG_PREFIX_VERNUM)$(IMG_PREFIX_VERCODE)$(IMG_PREFIX_EXTRA)/20220201-Ipv6-Mini-${str1}-/g' include/image.mk
echo "DISTRIB_REVISION='${date1} by Sirpdboy'" > ./package/base-files/files/etc/openwrt_release1
echo ${date1}' by Sirpdboy ' >> ./package/base-files/files/etc/banner
echo '---------------------------------' >> ./package/base-files/files/etc/banner
# sed -i '/root:/d' ./package/base-files/files/etc/shadow

sed -i 's/+"), 10)/+"), 0)/g' ./package/ssr/luci-app-ssr-plus//luasrc/controller/shadowsocksr.lua  #shadowsocksr
sed -i 's/+"), 10)/+"), 0)/g' ./package/lean/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua  #shadowsocksr
# sed -i 's/h"), 50)/h"), 8)/g' ./package/diy/luci-app-openclash/luasrc/controller/openclash.lua   #openclash
sed -i 's/+"),1)/+"),11)/g' ./package/diy/luci-app-adblock-plus/luasrc/controller/adblock.lua   #adblock
sed -i 's/),9)/),12)/g' ./package/luci-app-dnsfilter/luasrc/controller/dnsfilter.lua   #dnsfilter
# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Fix mt76 wireless driver
sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' package/kernel/mt76/Makefile
./scripts/feeds update -i
