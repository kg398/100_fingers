import time
import numpy as np
import copy
import _thread

import kg_robot as kgr

thread_flag = False

def wait_for_enter():
    global thread_flag
    thread_flag = True
    input()
    thread_flag = False
    return

def main():
    print("------------Configuring Burt-------------\r\n")
    #burt = kgr.kg_robot(lc_port='',db_host="169.254.130.80",host="169.254.130.84",port=30010)
    burt = kgr.kg_robot()
    print("----------------Hi Burt!-----------------\r\n\r\n")

    name = ''
    try:
        while 1:
            ipt = input("cmd: ")
            if ipt == 'fd':
                burt.socket_send(burt.format_prog(30))
                global thread_flag
                _thread.start_new_thread(wait_for_enter,())
                time.sleep(1)
                while thread_flag==True:
                    pass
                burt.socket_send(burt.format_prog(31))

            if ipt == 't':
                name = 'data/index_ex/' + ipt + '_0'
                #burt.data.simple_motion(name,position=True,loadcell=True,camera=True)
                burt.data.simple_motion(name,camera=True)

            elif ipt == 'close':
                break
        
    finally:
        print("Goodbye")
        burt.close()
if __name__ == '__main__': main()
