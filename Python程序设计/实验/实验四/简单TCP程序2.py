import socket
clientsocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
clientsocket.connect(('127.0.0.1', 8000))
while True:
    data = input('>')
    clientsocket.send(data.encode())
    if not data:
        break
    newdata = clientsocket.recv(1024)
    print("Received from server:", repr(newdata))
clientsocket.close()