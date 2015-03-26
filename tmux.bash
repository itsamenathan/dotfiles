#!/bin/bash 

source $HOME/.bashter/bashter

DISK=$(($STAT_DISK1_FREE/1024))
CPU0="C:$STAT_CPU_P_CPU0"
CPU1=":$STAT_CPU_P_CPU1"
LOAD="L:$STAT_LOAD"

DOWN=$(eval "echo \$STAT_NETSPEED_RCV_$STAT_GW_DEF | awk '{ printf \"%.1f\", \$1/1024 }'")
UP=$(eval "echo \$STAT_NETSPEED_TX_$STAT_GW_DEF | awk '{ printf \"%.1f\", \$1/1024 }'")

net=''
for i in $(set | awk -F= "/^STAT_IP_[^L][^O]/"'{ print tolower(substr($1, 9, length($1)))":"$2 }'); do
  echo -n $i" "
done

echo -n "M:$STAT_MEM_U /:$DISK $CPU0$CPU1 $LOAD D:$DOWN/$UP"

