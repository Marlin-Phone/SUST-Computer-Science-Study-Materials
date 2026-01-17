# file = open("data.txt", "r", encoding = "utf-8")
# print(file.read())
# file.close()

# with open("data.txt", "r", encoding = "utf-8") as f:
#     lines = f.readlines()

# for line in lines:
#     print(line)

# with open("test.txt", "w", encoding  = "utf-8") as f:
#     f.write("Hello, world!\n")


try:
    with open("test.txt", "r", encoding = "utf-8") as f:
        lines = f.readlines()
except FileNotFoundError:
    print("File not found.")
except IOError as e:
    print("I/O error:", e)

for line in lines:
    print(line)