function timer_0(obj, event)
global app
persistent firstrun;
persistent step;
if isempty(firstrun)
%     app.sub = rossubscriber('/scan', @sub_scan_callback);
    app.sub = rossubscriber('/scan');
    step = 1;
    app.ranges = zeros(500,100);
    firstrun = 1;

    title('Distributed Multirobot Localization');
        
    fprintf("initializing");
    pause(2);
end
if(step < 100)
    fprintf("saving... \n");
    msg = receive(app.sub,10);
    app.range = msg.Ranges;
    app.ranges(:,step) = app.range(:);
else
    fprintf("saving end... \n");
    rosshutdown;
    delete_timer;
end


step = step + 1;
end



function sub_scan_callback(src, msg)
    global app
    fprintf("get topics\n");
    app.range = msg.Ranges;
%     app.msg = msg;sd
%     plot(msg);
end