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
    
    app.angles = zeros(3,1); %roll pitch yaw
    app.pitch_dir_flag = 0;

    title('Distributed Multirobot Localization');
        
    fprintf("initializing");
    pause(2);
end
if(step < 300)
    fprintf("saving... \n");
    
    if app.pitch_dir_flag == 0
        app.angles(2) = app.angles(2) + 0.05;
        
        if app.angles(2) > 1
           app.pitch_dir_flag = 1; 
        end
        
    elseif app.pitch_dir_flag == 1
        app.angles(2) = app.angles(2) - 0.05;
        if app.angles(2) < -1
           app.pitch_dir_flag = 0; 
        end
    end
    
    anglepub = rospublisher('/gimbal/angles', 'geometry_msgs/Vector3');
    msg = rosmessage(anglepub);
    msg.X = app.angles(1);
    msg.Y = app.angles(2);
    msg.Z = app.angles(3);
    send(anglepub, msg);
    
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