#!/bin/sh
#
# This Script create iot server 3.0.0 pack point to Mysql 
PERF_SCRIPT_PATH="$1"
REPORT_FILE=$(date +%Y%m%d%H%M%S)
sh refresh_pack.sh root root
sleep 300
jmeter -n -t $PERF_SCRIPT_PATH -l report/$REPORT_FILE/100-2.jtl -Jdevice_count=100 -Jloop_count=2 -Jrampup_time=1
sleep 20
jmeter -n -t $PERF_SCRIPT_PATH -l report/$REPORT_FILE/200-2.jtl -Jdevice_count=200 -Jloop_count=2 -Jrampup_time=2
sleep 20
jmeter -n -t $PERF_SCRIPT_PATH -l report/$REPORT_FILE/300-2.jtl -Jdevice_count=300 -Jloop_count=2 -Jrampup_time=3
sleep 20
jmeter -n -t $PERF_SCRIPT_PATH -l report/$REPORT_FILE/400-2.jtl -Jdevice_count=400 -Jloop_count=2 -Jrampup_time=4
sleep 20
jmeter -n -t $PERF_SCRIPT_PATH -l report/$REPORT_FILE/500-2.jtl -Jdevice_count=500 -Jloop_count=2 -Jrampup_time=5
sleep 20
jmeter -n -t $PERF_SCRIPT_PATH -l report/$REPORT_FILE/1000-2.jtl -Jdevice_count=1000 -Jloop_count=2 -Jrampup_time=10
sleep 20
jmeter -n -t $PERF_SCRIPT_PATH -l report/$REPORT_FILE/2000-2.jtl -Jdevice_count=2000 -Jloop_count=2 -Jrampup_time=20
sh wso2iot-3.0.0-SNAPSHOT/core/bin/wso2server.sh stop
sleep 300

