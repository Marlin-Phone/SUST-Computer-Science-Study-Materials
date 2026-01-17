# 简单tcp程序:Echo Server
import socket # 导入socket模块
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) # 创建服务器socket
serversocket.bind(('127.0.0.1', 8000)) # 绑定IP地址和端口号
serversocket.listen(1) # 开始监听,队列长度为1
clientsocket, clientaddress = serversocket.accept() # 等待客户端连接,并返回客户端的socket和地址
clientsocket.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, True) 
while True:
    data = clientsocket.recv(1024) # 接收客户端发送的数据
    if not data:
        break
    # print("Received from client:", repr(data))

    print("Echo:", repr(data))
    # print("Sent to client:", repr(data))  # 添加这一行

    clientsocket.send(data)
clientsocket.close() # 关闭客户端socket
serversocket.close() # 关闭服务器socket
