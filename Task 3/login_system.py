import time

attempts = 0
first_attempt_time = None

while attempts < 3:

    password = input("Enter password: ")

    current_time = time.time()

    if first_attempt_time is None:
        first_attempt_time = current_time

    if password == "admin123":
        print("Login successful")
        exit()

    else:
        attempts += 1
        print("Login failed")

        if attempts >= 3:
            if current_time - first_attempt_time <= 60:
                print("Suspicious activity detected: multiple attempts within 60 seconds")

            print("Account locked due to multiple failed attempts")

            log = open("submission_log.txt","a")
            timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
            log.write(timestamp + " Account locked after repeated login attempts\n")
            log.close()
