#!/bin/sh
#from hiboy
killall npc
mkdir -p /tmp/nps
#启动nps功能后会运行以下脚本
#nps项目地址教程: https://github.com/fatedier/nps/blob/master/README_zh.md
#请自行修改 token 用于对客户端连接进行身份验证
# IP查询： http://119.29.29.29/d?dn=github.com

cat > "/tmp/nps/mynpc.ini" <<-\EOF
# ==========客户端配置：==========
[common]
server_addr = 1192.0.0.3
server_port = 7000
token = 12345

#log_file = /dev/null
#log_level = info
#log_max_days = 3

[web]
remote_port = 6000
type = http
local_ip = 192.168.2.1
local_port = 80
subdomain = test
#host_header_rewrite = 实际你内网访问的域名，可以供公网的域名不一致，如果一致可以不写
# ====================
EOF

#启动：
npc_enable=`nvram get npc_enable`

if [ "$npc_enable" = "1" ] ; then
    npc -c /tmp/nps/mynpc.ini 2>&1 &
fi
 