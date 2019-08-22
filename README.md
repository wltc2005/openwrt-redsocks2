RedSocks2 for OpenWrt
===
版本 0.67

为OpenWRT编译Redsocks2而写的Makefile


简介
---

 软件包包含 redsocks2 的可执行文件，配置文件和启动脚本，不需要配合luci-app-redsocsk2使用
 
 本项目是 [RedSocks2][1] 在 OpenWrt 上的移植
 
 当前版本: 0.67(2019.8.1最后一次commit)
 
 可以修改Makefile中PKG_SOURCE_VERSION为你需要编译的commit id
 
新版特性
---

1、支持Socks5协议的透明代理

2、内置Shadowsocks协议，支持全局UDP转发，无需再专门安装Shadowsocks

3、支持透明代理转VPN，可以把流量直接转发到VPN的虚拟网卡上去

4、支持TCPDNS，配合透明代理不仅可有效避免污染，还能实现国内外智能分流

注：TCPDNS要配合黑名单端口

5、启动脚本修改黑白名单功能，原理：先判断匹配黑名单，如果目的地IP在黑名单之中则转给黑名单端口，黑单名端口可以由redsocks2接管

注：此黑名单作用不同于luci-app-redsocsk2中的黑名单功能，修改目的是为了强制一部分目的地IP走代理以便访问costco或netflix等直连可以打开但无法正常使用的情况。再判断匹配白名单，如果目的地IP不在白名单之中则转给redsocks2端口

编译
---

 - 从 OpenWrt 的 [SDK][S] 编译

   ```bash
   # 以 ar71xx 平台为例
   tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
   cd OpenWrt-SDK-ar71xx-*
   # 获取 Makefile
   git clone https://github.com/wltc2005/openwrt-redsocks2.git package/redsocks2
   # 安装依赖包源码
   ./scripts/feeds update base
   ./scripts/feeds install libevent2
   ./scripts/feeds install ipset
   # 选择要编译的包 Network -> redsocks2
   make menuconfig V=s
   # 开始编译
   make package/redsocks2/compile V=s
   ```

编译错误解决方案
---

1、报错`awk: include/scan.awk: line 21: function asort never defined`

错误原因：缺少gawk

解决方案：sudo apt-get install gawk

2、报错`fatal error: curses.h: no such file or directory`

错误原因：缺少libncurses5-dev

解决方案：sudo apt-get install libncurses5-dev

----------


  [1]: https://github.com/semigodking/redsocks
  [S]: http://wiki.openwrt.org/doc/howto/obtain.firmware.sdk
