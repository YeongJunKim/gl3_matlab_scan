

close all;
global app

make_video = 1;
figure(1);
ax = axes;

% plotting = plot(ax, 0,0, '-*');
%     grid on;
%     axis equal
%     xlim([0,500]);
%     ylim([-1.5, 1.5]);
for i = 1:99
    fprintf("step = %d",i);
    ranges = app.ranges(:,i)';
    angles = linspace(-pi/2, pi/2, numel(ranges));
    scan = lidarScan(ranges,angles);
    clf;
    plot(scan);
    pause(0.1);
    if make_video == 1
        F1(i) = getframe(1);
    end
end

if make_video == 1
 video_name = sprintf('robot_%s_%s',datestr(now,'yymmdd'),datestr(now,'HHMMSS'));
    video = VideoWriter(video_name,'MPEG-4');
    video.Quality = 100;
    video.FrameRate = 1/0.1;   % 영상의 FPS, 값이 클수록 영상이 빨라짐
    open(video);
    writeVideo(video,F1);
    close(video);
end