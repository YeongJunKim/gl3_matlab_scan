clear all;
close all;
addpath('./../matlab_utils');
delete_timer();
rosshutdown;
pause(3);
rosinit('192.168.0.18');
global app;


app.ts = 0.5;


tm = timer('BusyMode', 'drop', 'ExecutionMode', 'fixedRate', 'Period', app.ts, 'TimerFcn', @timer_0);
start(tm);
fprintf("initialize end\n");