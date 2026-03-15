###Description####

1.Bash-based job scheduler for multi-user computing:

2.Menu-driven interface to submit jobs, view pending jobs, process jobs, and view completed jobs.

3.Supports Round Robin scheduling with a fixed 5-second time quantum.

4.Supports Priority scheduling (priority 1–10).

5.Logs all job submissions and executions.

######How to run#####

1. Make the script executable:

Command: chmod +x hpc_scheduler.sh

Run the scheduler:

command: ./scheduler.sh

#####Notes#####

* Pending jobs are stored in job_queue.txt.

* Completed jobs are stored in completed_jobs.txt.

* All events are logged in scheduler_log.txt.
