import socket
clientsocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
while True:
    data = input('>')
    clientsocket.sendto(data.encode(), ('127.0.0.1', 8000))
    if not data:
        break
    newdata = clientsocket.recvfrom(1024)
    print("Reveived from server:", repr(newdata))
clientsocket.close()