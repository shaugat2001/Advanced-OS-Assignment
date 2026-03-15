import os
import time

filename = input("Enter assignment filename: ")

if not (filename.endswith(".pdf") or filename.endswith(".docx")):
    print("Invalid file format")
    exit()

if not os.path.exists(filename):
    print("File does not exist")
    exit()

size = os.path.getsize(filename)

if size > 5 * 1024 * 1024:
    print("File larger than 5MB rejected")
    exit()

log = open("submission_log.txt","a")
sub = open("submissions.txt","a")

sub.write(filename + "\n")

timestamp = time.strftime("%Y-%m-%d %H:%M:%S")

log.write(timestamp + " Submission accepted: " + filename + "\n")

log.close()
sub.close()

print("Submission successful")
