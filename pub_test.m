    anglepub = rospublisher('/gimbal/angles', 'geometry_msgs/Vector3');
    msg = rosmessage(anglepub);
    msg.X = 0;
    msg.Y = 0;
    msg.Z = 0;
    send(anglepub, msg);