function timer_0(obj, event)
global app
persistent firstrun;
persistent step;
if isempty(firstrun)
%     app.sub = rossubscriber('/scan', @sub_scan_callback);
    app.sub = rossubscriber('/scan');
    step = 1;
    app.ranges = zeros(500,1000);
    firstrun = 1;
    
    app.angles = zeros(3,1); %roll pitch yaw
    app.pitch_dir_flag = 0;

    title('Distributed Multirobot Localization');
        
    fprintf("initializing");
    pause(2);
end
if(step < 300)
    fprintf("saving... %d\n",step);
    
    if app.pitch_dir_flag == 0
        app.angles(2) = app.angles(2) + 0.1;
        
        if app.angles(2) > 4
           app.pitch_dir_flag = 1; 
        end
        
    elseif app.pitch_dir_flag == 1
        app.angles(2) = app.angles(2) - 0.1;
        if app.angles(2) < -4
           app.pitch_dir_flag = 0; 
        end
    end
    
    [pub_control, pub_control_msg] = rospublisher('/gimbal/angles', 'geometry_msgs/Vector3');
    
    pub_control_msg.X = app.angles(1);
    pub_control_msg.Y = app.angles(2);
    pub_control_msg.Z = app.angles(3);
    send(pub_control, pub_control_msg);
    
    pub_control_msg = receive(app.sub,10);
    
    
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