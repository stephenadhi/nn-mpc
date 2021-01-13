clear all; close all; clc;
% Tweak simulation here
n=40000;
x0= [1.172187 -17.664478 2.095336 17.76225 4.122752 -63.754815]; %initial states nodist
%x0= [-1.768308 61.464412  17.76225 4.122752 -63.754815]; %initial states dist100
global k kp m d
rng(0)
k=217;  %[N/m^2]
kp= 63.5; %[N/m^2]
m= 0.49; %mass [kg]
d= 0.25;

yy1=zeros(n,3);     %output is the st   ate x1 and x3, which is denoted here as y(1) and y(5)

%Runge-Kutta parameters
t0=0;
h=0.001;
tfinal=0.001;

youtnl= csvread('exploration_dist100.csv')
%nodist= csvread('nodist.csv')
%youtnl=nodist(end-n:end,:);
for a=2:n+1
 yy1(a-1,:)=[youtnl(a-1,1),youtnl(a-1,3),youtnl(a-1,5)];               %save outputs x1 and x3
end
%%
for j=287:287
%Set up video
filename = sprintf('threemass_spring_damper_%d.avi', j)
v=VideoWriter(filename);
v.FrameRate=60;
open(v);
t=0:n;
    for i=2:100
        % u1= 1*(rand(1,1)-0.5); %[-1500 1500]
        %u2= 1*(rand(1,1)-0.5); %[-1500 1500]
        %u3= 1*(rand(1,1)-0.5); %[-400 400]
        %youtnl=ode4(@(t,x)myode(t,x,u1,u2,u3), t0, h, tfinal, x0); % linear
        %x0=youtnl(2,:);          %reinitialize yo to the last produced outputs
       
        %y(i,:)= youtnl(1,:);
        disp((j-1)*100+i-1)
        % Plot everything for the video
        %   subplot(3,1,1)
        %   hold on;
        %   plot(t(:,1:i),yy1(1:i,1),'r')
        %   plot(t(:,1:i),yy1(1:i,2),'m')
        %   xlim([0 n])
        %   ylim([-5 5])
        %   xline(40000,'--g');
        %   xline(40300,'--');
        %   xlabel('Time (ms)')
        %   ylabel('States (m)')
        %   line([40000 40300], [1 1], 'LineStyle', ':','Color', 'blue');
        %   line([40000 40300], [2 2], 'LineStyle', ':','Color', '#D95319');
        %   line([40300 40600], [0 0], 'LineStyle', ':','Color', 'k');
        %   title('Mass-Spring-Damper System');
        %   legend({'Mass 1','Mass 3'},'Location','south','FontSize', 6)
        %
        %   subplot(3,1,2)
        %   hold on;
        %   plot(t(:,1:i),yy1(1:i,3),'b')
        %   xlim([39600 40600])
        %   xlabel('Time (ms)')
        %   ylabel('u1 (N)')
        %
        %   subplot(3,1,3)
        %   hold on;
        %   plot(t(:,1:i),yy1(1:i,4),'b')
        %   xlim([39600 40600])
        %   xlabel('Time (ms)')
        %   ylabel('u2 (N)')
        figure(1)
        subplot(2,1,1)
        hold on;
        plot(t(:,1:(j-1)*100+i),yy1(1:(j-1)*100+i,1),'r')
        plot(t(:,1:(j-1)*100+i),yy1(1:(j-1)*100+i,2),'m')
        xlim([0 n])

        xlabel('Time (ms)')
        ylabel('States (m)')
        title('Mass-Spring-Damper System');
        legend({'Mass 1','Mass 3'},'Location','northwest','FontSize', 6)
        
        subplot(2,1,2)
        hold on;
        fill([0 50 50 0],[0 0 1.2 1.2],'w'); % clears background
        plot([0 yy1((j-1)*100+i,1)+12],[0.25 0.25],'y'); % damper1
        plot([yy1((j-1)*100+i,1)+12 yy1((j-1)*100+i,2)+24],[0.25 0.25],'y'); % damper2
        plot([yy1((j-1)*100+i,2)+24 yy1((j-1)*100+i,3)+36],[0.25 0.25],'y'); % damper3
        plot([0 yy1((j-1)*100+i,1)+12],[0.75 0.75],'b'); % spring1
        plot([yy1((j-1)*100+i,1)+12 yy1((j-1)*100+i,2)+24],[0.75 0.75],'b'); % spring2
        plot([yy1((j-1)*100+i,2)+24 yy1((j-1)*100+i,3)+36],[0.75 0.75],'b'); % spring3
        fill([yy1((j-1)*100+i,1)+11 yy1((j-1)*100+i,1)+12 yy1((j-1)*100+i,1)+12 yy1((j-1)*100+i,1)+11],[1.1 1.1 1.2 1.2],'g'); % motor 1
        fill([yy1((j-1)*100+i,1)+11 yy1((j-1)*100+i,1)+12 yy1((j-1)*100+i,1)+12 yy1((j-1)*100+i,1)+11],[0 0 1 1],'r'); % mass 1
        fill([yy1((j-1)*100+i,2)+23 yy1((j-1)*100+i,2)+24 yy1((j-1)*100+i,2)+24 yy1((j-1)*100+i,2)+23],[1.1 1.1 1.2 1.2],'k'); % motor 2
        fill([yy1((j-1)*100+i,2)+23 yy1((j-1)*100+i,2)+24 yy1((j-1)*100+i,2)+24 yy1((j-1)*100+i,2)+23],[0 0 1 1],'r'); % mass 2
        fill([yy1((j-1)*100+i,3)+35 yy1((j-1)*100+i,3)+36 yy1((j-1)*100+i,3)+36 yy1((j-1)*100+i,3)+35],[1.1 1.1 1.2 1.2],'g'); % motor 3
        fill([yy1((j-1)*100+i,3)+35 yy1((j-1)*100+i,3)+36 yy1((j-1)*100+i,3)+36 yy1((j-1)*100+i,3)+35],[0 0 1 1],'r'); % mass 3
        fill([0 0.1 0.1 0],[0 0 1 1],[0.5 0.5 0.5]);
        xlim([0 50]);
        ylim([0 1.2]);
        xlabel('Absolute position (m)')
        set(gca,'YTick', [])
        set(gcf,'doublebuffer','off');
        frame=getframe(gcf);
        writeVideo(v,frame)
        %filename = sprintf('mat_img_%d.jpg', i-1)
        
        %exportgraphics(figure(1),filename,'Resolution',150)
        %   F = getframe(gcf);
        %   figure;
        %   A = imshow(F.cdata);
        %   imwrite(F, filename, 'png') ;
    end
    close(v);
end
%close(v);

