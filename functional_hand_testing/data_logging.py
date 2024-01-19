import time
import numpy as np
import nidaqmx
import _thread
import copy
import serial
import scipy.optimize as optimize
import csv
import cv2
import json
import matplotlib.pyplot as plt
import random


thread_flag = False
lc_thread_flag = False
ps_thread_flag = False
cam_thread_flag = False

lc_data = 0
ps_data = []

filename = 'video.avi'
frames_per_second = 24.0
res = '720p'

def wait_for_enter():
    global thread_flag
    thread_flag = True
    input()
    thread_flag = False
    return

class data():
    def __init__(self,robot,loadcell_port=False,pressure_port=False):
        self.robot = robot

        if loadcell_port!=False:
            self.lc = serial.Serial(loadcell_port, 115200)  # open serial port
            self.lc.close()
            self.lc.open()
            while self.lc.isOpen()==False:
                print("Waiting for loadcell")
            print("Connected to loadcell")

        if pressure_port!=False and pressure_port!=loadcell_port:
            self.ps = serial.Serial(pressure_port, 115200)  # open serial port
            self.ps.close()
            self.ps.open()
            while self.ps.isOpen()==False:
                print("Waiting for pressure")
            print("Connected to pressure")
        elif pressure_port!=False and pressure_port==loadcell_port:
            self.ps=self.lc

    #----------------custom data collection interfaces--------------------
    def lc_single_read(self):
        lc = 0
        ipt = ""
        self.lc.reset_input_buffer()
        self.lc.write(str.encode("l0\n"))
        while True:
            ipt = bytes.decode(self.lc.readline())
            if ipt == "done\r\n":
                break
            else:
                lc = float(ipt)
        return lc

    def lc_tare(self):
        ipt = ""
        self.lc.reset_input_buffer()
        self.lc.write(str.encode("t0\n"))
        while True:
            ipt = bytes.decode(self.lc.readline())
            if ipt == "done\r\n":
                break
        return

    def ps_single_read(self):
        ps = []
        ipt = ""
        self.ps.flush()
        ipt = bytes.decode(self.ps.readline()).strip()
        ps = list(ipt.split(" "))
        return ps

    #-----------------main recording and controllers----------------------
    def simple_motion(self,name='test',loadcell=False,position=False,pressure=False,camera=False):
        start_time = int(time.time())
        self.move_and_read(name,start_time,loadcell,position,pressure,camera)
        return '{}_raw_{}'.format(name,start_time)

    def move_and_read(self,name,start_time,lc,pos,ps,cam):
        global lc_data
        lc_data = 0
        global ps_data
        ps_data = []
        global pos_data
        pos_data = [0,0,0,0,0,0]
        start_pos = self.robot.getl()
        
        with open('{}_data.csv'.format(name), 'w', newline='') as csvfile:
            names = ['n']+['t']+['x','y','z','rx','ry','rz']+['load']+['sense']
            csvwriter = csv.writer(csvfile)
            csvwriter.writerow(names)
       
            n=0
            if lc == True:
                global ft_thread_flag
                _thread.start_new_thread(self.read_lc,(start_time,))
            if ps == True:
                global ps_thread_flag
                _thread.start_new_thread(self.read_ps,(start_time,))
            if pos == True:
                global pos_thread_flag
                _thread.start_new_thread(self.read_pos,(start_time,))
            if cam == True:
                global cam_thread_flag
                _thread.start_new_thread(self.read_cam,(name,))

            time.sleep(0.1)
            tic = time.time()
            csvwriter.writerow([n,0]+pos_data+[lc_data]+ps_data)

            #motion params
            dist=0.03
            motion=[0,dist,0,0,0,0]
            steps=25
            timestep=0.1

            demand_pos=copy.deepcopy(start_pos)+motion
            self.robot.movel(demand_pos,vel=dist/(steps*timestep),wait=False)
            for i in range(1,steps):
                n+=1
                time.sleep(timestep)
                current_time = time.time()-tic
                csvwriter.writerow([n,current_time]+pos_data+ps_data)
            self.robot.movel(start_pos,vel=dist/(steps*timestep),wait=False)
            for i in range(1,steps):
                n+=1
                time.sleep(timestep)
                current_time = time.time()-tic
                csvwriter.writerow([n,current_time]+pos_data+ps_data)


            print(n)
            lc_thread_flag = False
            ps_thread_flag = False
            pos_thread_flag = False
            cam_thread_flag = False
            time.sleep(0.5)
            self.robot.ping()
        return

    #----------------------data streaming threads-------------------------
    def read_lc(self,start_time):
        global lc_thread_flag
        lc_thread_flag = True
        global lc_data
        lc_data = 0

        print('lc data start')

        while lc_thread_flag == True:
            lc_data = self.lc_single_read()
            time.sleep(0.01)
        return

    def read_ps(self,start_time):
        global ps_thread_flag
        ps_thread_flag = True
        global ps_data
        ps_data = []

        print('pressure data start')

        while ps_thread_flag == True:
            ps_data = self.ps_single_read()
            time.sleep(0.01)
        return

    def read_pos(self,start_time):
        global pos_thread_flag
        pos_thread_flag = True
        global pos_data
        pos_data = [0,0,0,0,0,0]

        print('pos data start')
        self.robot.ping()
        self.robot.stream_data_start(0.01)
        while pos_thread_flag == True:
            raw = self.robot.read_msg()
            if raw != []:
                pos_data = raw
        self.robot.stream_data_stop()
        return

    def read_cam(self,name):
        global cam_thread_flag
        cam_thread_flag = True

        filename = "{}_vid.avi".format(name)
        cap = cv2.VideoCapture(1,cv2.CAP_DSHOW)
        cap.set(cv2.CAP_PROP_AUTOFOCUS,0)
        out = cv2.VideoWriter(filename, cv2.VideoWriter_fourcc(*'XVID'), 25, (640, 480))# [1920, 1080])
        ret, frame = cap.read()
        cv2.imwrite('{}_start.jpg'.format(name), frame)

        while cam_thread_flag == True:
            ret, frame = cap.read()
            out.write(frame)

        ret, frame = cap.read()
        cv2.imwrite('{}_end.jpg'.format(name), frame)

        cap.release()
        out.release()
        return


