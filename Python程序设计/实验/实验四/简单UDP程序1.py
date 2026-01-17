import socket

serversocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
serversocket.bind(('127.0.0.1', 8000))
while True:
    data, address = serversocket.recvfrom(1024)
    if not data:
        break
    print("Reveived from client:", address, repr(data))
    print("Echo:", repr(data))
    serversocket.sendto(data, address)
serversocket.close()