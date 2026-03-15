#!/bin/bash

LOGFILE="system_monitor_log.txt"
ARCHIVE="ArchiveLogs"

log_action(){
echo "$(date) - $1" >> $LOGFILE
}

while true
do

echo "===== University Data Centre System ====="
echo "1. Display CPU and Memory Usage"
echo "2. Show Top 10 Memory Processes"
echo "3. Terminate a Process"
echo "4. Inspect Disk Usage"
echo "5. Archive Large Log Files"
echo "6. Bye"
echo "=========================================="

read -p "Enter option: " option

case $option in

1)
top -b -n1 | head -5
log_action "Checked CPU and memory usage"
;;

2)
ps aux --sort=-%mem | head -11
log_action "Viewed top 10 processes"
;;

3)
read -p "Enter PID to terminate: " pid

if [ $pid -le 100 ]
then
echo "Critical process cannot be terminated"
log_action "Attempted termination of protected PID $pid"
else
read -p "Confirm termination (Y/N): " confirm

if [ "$confirm" = "Y" ]
then
kill $pid
echo "Process terminated"
log_action "Process $pid terminated"
fi
fi
;;

4)

read -p "Enter directory path: " dir
du -sh $dir
log_action "Checked disk usage for $dir"
;;

5)

if [ ! -d "$ARCHIVE" ]
then
mkdir ArchiveLogs
fi

find . -name "*.log" -size +50M | while read file
do
time=$(date +%Y%m%d%H%M%S)
gzip -c "$file" > "$ARCHIVE/${file##*/}_$time.gz"
echo "Archived $file"
log_action "Archived $file"
done

size=$(du -sm $ARCHIVE | cut -f1)

if [ $size -gt 1024 ]
then
echo "Warning: ArchiveLogs folder exceeds 1GB"
fi
;;

6)

read -p "Are you sure you want to exit? (Y/N): " exitc

if [ "$exitc" = "Y" ]
then
log_action "System exited"
echo "Bye"
break
fi
;;

*)

echo "Invalid option"

;;

esac

done
