import time
import socket

class kg_robot_dashboard():
    def __init__(self, host):
        self.open=False
        try:
            self.c = socket.create_connection((host, 29999), timeout=1)
            time.sleep(2)
        except socket.error as socketerror:
            print("problem connecting to the socket")
            self.reconnect(host)

        if self.open == False:
            try:
                print(bytes.decode(self.c.recv(1024)))
                self.open=True
            except socket.error as socketerror:
                print("problem reading from the socket")
                self.c.close()
                time.sleep(1)
                self.reconnect(host)

    def init(self):
        print(self.socket_send("PolyscopeVersion\n"))
        if self.socket_send("robotmode\n")!="Robotmode: RUNNING\n":
            print(self.socket_send("power on\n"))
            print(self.socket_send("brake release\n"))
        print(self.socket_send("unlock protective stop\n"))
        print(self.socket_send("load kg_client.urp\n"))
        #print(self.socket_send("load kg_force_client.urp\n"))
        print(self.socket_send("stop\n"))
        while self.socket_send("robotmode\n")!="Robotmode: RUNNING\n":
            time.sleep(0.5)
        print(self.socket_send("close popup\n"))
        print(self.socket_send("play\n"))
        #print(self.socket_send("quit\n"))
        self.c.close()
        self.open=False

    def reconnect(self,host):
        print("attempting to reconnect...")
        if self.open==False:
            try:
                time.sleep(1)
                self.c = socket.create_connection((host, 29999), timeout=0.5)
                time.sleep(1)
            except socket.error as socketerror:
                self.reconnect(host)

            if self.open == False:
                try:
                    print(bytes.decode(self.c.recv(1024)))
                    self.open=True
                except socket.error as socketerror:
                    print("problem reading from the socket")
                    self.c.close()
                    time.sleep(1)
                    self.reconnect(host)
        
    def socket_send(self,prog):
        msg = "No message from robot"
        try:
            self.c.send(str.encode(prog))
            # Wait for reply
            msg=bytes.decode(self.c.recv(1024))

        except socket.error as socketerror:
            print("........................Dashboard error :(.........................")
        return msg

