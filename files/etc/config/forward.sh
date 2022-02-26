#!/bin/bash
ID= ID
TOKEN= TOKEN
LOOP=3
DATE=$(date '+%Y/%m/%d %H:%M')
if [ "$1" == "RECEIVED" ]; then
	FROM=$(sed -n '1p' < "$2" | awk -F ': ' '{printf $2}')
	BODY=$(sed -e '1,/^$/ d' < "$2" | iconv -f UNICODEBIG -t UTF-8)
	CONTENT="短信通知%20$DATE%0a来自:%20$FROM%0a$BODY"
	echo -e "$DATE\n$FROM\n$BODY\n" >> /root/Messenger/sms.log
fi

toQmsg(){
	curl -d "qq=$ID&msg=$CONTENT" https://qmsg.zendee.cn/send/${TOKEN} --retry 3 --retry-delay 5 
}

toTG(){
	curl -d "chat_id=$ID&text=$CONTENT" https://api.telegram.org/bot${TOKEN}/sendMessage --retry 3 --retry-delay 5 
}

forward(){
	#toQmsg
	toTG
	if [ $? -ne 0 -a $LOOP -gt 0 ]; then
		echo "failure at $(date '+%Y/%m/%d %H:%M')"
		((LOOP--))
		sleep 60
		forward
	fi
}

forward