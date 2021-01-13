clear all; close all; clc;
% Tweak simulation here
n=1000;
x0= [1.172187 -17.664478 2.095336 17.76225 4.122752 -63.754815]; %initial states nodist
%x0= [-1.768308 61.464412  17.76225 4.122752 -63.754815]; %initial states dist100
global k kp m d
rng(0)
k=217;  %[N/m^2]
kp= 63.5; %[N/m^2]
m= 0.49; %mass [kg]
d= 0.25;

yy1=zeros(n,4);     %output is the st   ate x1 and x3, which is denoted here as y(1) and y(5)

%Runge-Kutta parameters
t0=0;
h=0.001;
tfinal=0.001;

%youtnl= csvread('exploration_dist100.csv')
nodist= csvread('nodist.csv')
youtnl=nodist(end-n:end,:);
% Set up video
v=VideoWriter('nodist.avi');
v.FrameRate=60;
open(v);
t=39600:(39600+n);
for i=2:n+1
   % u1= 1*(rand(1,1)-0.5); %[-1500 1500]  
    %u2= 1*(rand(1,1)-0.5); %[-1500 1500]
    %u3= 1*(rand(1,1)-0.5); %[-400 400]
    %youtnl=ode4(@(t,x)myode(t,x,u1,u2,u3), t0, h, tfinal, x0); % linear
    %x0=youtnl(2,:);          %reinitialize yo to the last produced outputs
    yy1(i,:)=[youtnl(i-1,4),youtnl(i-1,5),youtnl(i-1,1),youtnl(i-1,3)];               %save outputs x1 and x3
    %y(i,:)= youtnl(1,:);
    disp(i-1)
  % Plot everything for the video
  subplot(3,1,1)
  hold on;
  plot(t(:,1:i),yy1(1:i,1),'r')
  plot(t(:,1:i),yy1(1:i,2),'m')
  xlim([39600 40600])
  ylim([-5 5])
  xline(40000,'--g');
  xline(40300,'--');
  xlabel('Time (ms)')
  ylabel('States (m)')
  line([40000 40300], [1 1], 'LineStyle', ':','Color', 'blue');
  line([40000 40300], [2 2], 'LineStyle', ':','Color', '#D95319');
  line([40300 40600], [0 0], 'LineStyle', ':','Color', 'k');
  title('Mass-Spring-Damper System');
  legend({'Mass 1','Mass 3'},'Location','south','FontSize', 6)
  
  subplot(3,1,2)
  hold on;
  plot(t(:,1:i),yy1(1:i,3),'b')
  xlim([39600 40600])
  xlabel('Time (ms)')
  ylabel('u1 (N)')

  subplot(3,1,3)
  hold on;
  plot(t(:,1:i),yy1(1:i,4),'b')
  xlim([39600 40600])
  xlabel('Time (ms)')
  ylabel('u2 (N)')
%   fill([0 25 25 0],[0 0 1.5 1.5],'w'); % clears background
%   plot([0 yy1(i,1)+5],[0.25 0.25],'y'); % damper1
%   plot([yy1(i,1)+5 yy1(i,2)+10],[0.25 0.25],'y'); % damper2
%   plot([yy1(i,2)+10 yy1(i,3)+15],[0.25 0.25],'y'); % damper3
%   plot([0 yy1(i,1)+5],[0.75 0.75],'b'); % spring1
%   plot([yy1(i,1)+5 yy1(i,2)+10],[0.75 0.75],'b'); % spring2
%   plot([yy1(i,2)+10 yy1(i,3)+15],[0.75 0.75],'b'); % spring3
%   fill([yy1(i,1)+4 yy1(i,1)+5 yy1(i,1)+5 yy1(i,1)+4],[0 0 1 1],'r'); % mass 1
%   fill([yy1(i,2)+9 yy1(i,2)+10 yy1(i,2)+10 yy1(i,2)+9],[0 0 1 1],'r'); % mass 2
%   fill([yy1(i,3)+14 yy1(i,3)+15 yy1(i,3)+15 yy1(i,3)+14],[0 0 1 1],'r'); % mass 3
%   fill([0 0.1 0.1 0],[0 0 1 1],[0.5 0.5 0.5]);
%   set(gca,'YTick', [])
  frame=getframe(gcf);
  writeVideo(v,frame)
end

close(v);




