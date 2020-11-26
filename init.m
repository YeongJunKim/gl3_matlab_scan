clear all;
close all;
addpath('./../matlab_utils');
rosshutdown;
pause(3);
rosinit('192.168.0.26');
global app;


app.ts = 0.1;


tm = timer('BusyMode', 'drop', 'ExecutionMode', 'fixedRate', 'Period', app.ts, 'TimerFcn', @timer_0);
start(tm);
fprintf("initialize end\n");