#!/bin/bash

while true
do
echo "===== Student Submission System ====="
echo "1. Submit Assignment"
echo "2. Check Duplicate Submission"
echo "3. List Submitted Assignments"
echo "4. Simulate Login Attempt"
echo "5. Exit"

read -p "Enter choice: " choice

case $choice in
1) python3  submit_assignment.py ;;
2) python3  check_duplicate.py ;;
3) cat submissions.txt ;;
4) python3 login_system.py ;;
5) read -p "Confirm Exit (Y/N): " confirm
   if [ "$confirm" = "Y" ]; then
   echo "System exiting..."
   break
   fi ;;
*) echo "Invalid choice";;
esac

done
