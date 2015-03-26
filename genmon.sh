#!/bin/bash 

declare -a  CLASS_101=(300 'getgitary')

F_getgitary (){
  local prefix="GITARY"
  unsett $prefix
  date=$(date +'%Y-%m-%d')
  read Y M D  <<< ${date//[-: ]/ }
  if [ -f $HOME/.gitary/$Y/$M/$D ]; then
    gitary="0"
  else
    gitary="1"
  fi
  eval "STAT_GITARY=$gitary"
  [ $1 ] && printSTAT $prefix
}

source $HOME/bin/bashter

## Color Batt
if [ $STAT_BATT_P -le 15 ]; then
  BATT="B:<span color=\"red\">$STAT_BATT_P</span>"
else
  BATT="B:$STAT_BATT_P"
fi

if [ $STAT_BATT_C -eq 1 ]; then
  BATT="$BATT+"
else
  BATT="$BATT-"
fi

# Color Mem
if [ $((($STAT_MEM_U*100)/$STAT_MEM_F)) -ge 50 ]; then
  MEM="M:<span color=\"red\">$STAT_MEM_U</span>"
else
  MEM="M:$STAT_MEM_U"
fi

DISK=$(($STAT_DISK1_FREE/1024))
if [ $DISK -le 20 ]; then
  DISK="/:<span color=\"red\">$DISK</span>"
else
  DISK="/:$DISK"
fi

if [ $STAT_CPU_P_CPU0 -ge 75 ]; then
  CPU0="C:<span color=\"red\">$STAT_CPU_P_CPU0</span>"
else
  CPU0="C:$STAT_CPU_P_CPU0"
fi

if [ $STAT_CPU_P_CPU1 -ge 75 ]; then
  CPU1=":<span color=\"red\">$STAT_CPU_P_CPU1</span>"
else
  CPU1=":$STAT_CPU_P_CPU1"
fi

if [ $STAT_CPU_P_CPU2 -ge 75 ]; then
  CPU2=":<span color=\"red\">$STAT_CPU_P_CPU2</span>"
else
  CPU2=":$STAT_CPU_P_CPU2"
fi

if [ $STAT_CPU_P_CPU3 -ge 75 ]; then
  CPU3=":<span color=\"red\">$STAT_CPU_P_CPU3</span>"
else
  CPU3=":$STAT_CPU_P_CPU3"
fi

if [ ${STAT_LOAD:0:1} -ge 1 ]; then
  LOAD='L:<span color="red">'$STAT_LOAD'</span>'
else
  LOAD="L:$STAT_LOAD"
fi

if [ $STAT_TEMP -ge 70 ]; then
  TEMP="T:<span color=\"red\">$STAT_TEMP</span>"
else
  TEMP="T:$STAT_TEMP"
fi


[ ! -z $STAT_GW_DEF ] && GW="${STAT_GW_DEF,,}"

if [ $GW == "TINC0" ]; then
  [ ! -z $STAT_IP_WLAN0 ] && IP="$STAT_IP_WLAN0"
  [ ! -z $STAT_IP_ETH0 ] && IP="$STAT_IP_ETH0"
else
  [ ! -z $STAT_GW_DEF ] && eval "IP=\"\$STAT_IP_$STAT_GW_DEF\""
fi

if [[ $IP =~ 10\.207.* ]] && [ $GW != "TINC0" ]; then
  GW="<span color=\"red\">${GW,,}</span>"
fi

if [ $STAT_ESSID_WLP3S0 != "ff/any" ]; then
  ESSID="$STAT_ESSID_WLP3S0"
fi

DOWN=$(eval "echo \$STAT_NETSPEED_RCV_$STAT_GW_DEF | awk '{ printf \"%.1f\", \$1/1024 }'")
UP=$(eval "echo \$STAT_NETSPEED_TX_$STAT_GW_DEF | awk '{ printf \"%.1f\", \$1/1024 }'")

if [ $STAT_GITARY -eq 1 ]; then
  GITARY="G:<span color=\"red\">☹</span>"
else
  GITARY="G:<span color=\"green\">☺</span>"
fi

echo -n "<txt>"
echo -n "$BATT $MEM $DISK $CPU0$CPU1$CPU2$CPU3 $LOAD $TEMP"
echo 
echo -n "$GW $IP"
[ $ESSID ] && echo -n " $ESSID"
echo -n " D:$DOWN/$UP $GITARY"
echo -n "</txt>"


