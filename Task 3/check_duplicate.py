import hashlib

filename = input("Enter filename to check: ")

try:
    with open(filename,"rb") as f:
        filehash = hashlib.md5(f.read()).hexdigest()
except:
    print("File not found")
    exit()

duplicates = False

with open("submissions.txt") as f:
    for line in f:
        name=line.strip()
        try:
            with open(name,"rb") as existing:
                existinghash=hashlib.md5(existing.read()).hexdigest()
                if existinghash == filehash:
                    duplicates = True
        except:
            pass

if duplicates:
    print("Duplicate submission detected")
else:
    print("No duplicate found")
