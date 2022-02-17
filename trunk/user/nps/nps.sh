#!/bin/sh
npc_enable=`nvram get npc_enable`
http_username=`nvram get http_username`

check_nps () 
{
	check_net
	result_net=$?
	if [ "$result_net" = "1" ] ;then
		if [ -z "`pidof npc`" ] && [ "$npc_enable" = "1" ];then
			nps_start
		fi
	fi
}

check_net() 
{
	/bin/ping -c 3 223.5.5.5 -w 5 >/dev/null 2>&1
	if [ "$?" == "0" ]; then
		return 1
	else
		return 2
		logger -t "nps" "检测到互联网未能成功访问,稍后再尝试启动nps"
	fi
}

nps_start () 
{
	/etc/storage/nps_script.sh
	sed -i '/nps/d' /etc/storage/cron/crontabs/$http_username
	cat >> /etc/storage/cron/crontabs/$http_username << EOF
*/1 * * * * /bin/sh /usr/bin/nps.sh C >/dev/null 2>&1
EOF
	[ ! -z "`pidof npc`" ] && logger -t "nps" "nps启动成功"
}

nps_close () 
{
	if [ "$npc_enable" = "0" ]; then
		if [ ! -z "`pidof npc`" ]; then
		killall -9 npc nps_script.sh
		[ -z "`pidof npc`" ] && logger -t "nps" "已停止 nps"
	    fi
	fi
	if [ "$npc_enable" = "0" ]; then
	sed -i '/nps/d' /etc/storage/cron/crontabs/$http_username
    fi
}


case $1 in
start)
	nps_start
	;;
stop)
	nps_close
	;;
C)
	check_nps
	;;
esac
