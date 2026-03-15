#!/bin/bash

queue="job_queue.txt"
completed="completed_jobs.txt"
log="scheduler_log.txt"

log_action(){
echo "$(date) - $1" >> $log
}

while true
do
echo "========Job Scheduler============="
echo "1. View Pending Jobs"
echo "2. Submit Job Request"
echo "3. Round Robin-Process Queue"
echo "4. Priority-Process Queue"
echo "5. View Completed Jobs"
echo "6. Exit"
echo "================================"

read -p "Enter choice: " choice

case $choice in

1)
echo "------ Pending Jobs ------"
cat $queue
;;

2)
read -p "Student ID: " sid
read -p "Job Name: " job
read -p "Execution Time (seconds): " time
read -p "Priority (1-10): " priority

echo "$sid,$job,$time,$priority" >> $queue

log_action "Job Submitted - Student:$sid Job:$job"

echo "Job added to queue"
;;

3)

quantum=5

echo "Running Round Robin Scheduling"

> temp.txt

while IFS=',' read sid job time priority
do

echo "Processing $job from $sid"

if [ $time -gt $quantum ]
then
remaining=$((time-quantum))

echo "$sid,$job,$remaining,$priority" >> temp.txt

echo "Executed for $quantum seconds"
sleep 2

else

echo "Job Completed: $job"
echo "$sid,$job" >> $completed

log_action "Executed $job by $sid using Round Robin"

sleep 2

fi

done < $queue

mv temp.txt $queue

;;

4)

echo "Running Priority Scheduling"

sort -t',' -k4 -nr $queue > sorted.txt

while IFS=',' read sid job time priority
do

echo "Executing $job (Priority $priority)"

sleep 2
echo "Job Completed: $job"
echo "$sid,$job" >> $completed

log_action "Executed $job by $sid using Priority"

done < sorted.txt

> $queue

;;

5)

echo "------ Completed Jobs ------"

cat $completed

;;

6)

read -p "Are you sure you want to exit? (Y/N): " confirm

if [ "$confirm" = "Y" ]
then
echo "Bye"
exit
fi

;;

*)

echo "Invalid choice"

;;

esac

done
