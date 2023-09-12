clear all

sample_time = 0.025;
circle_start = 121;
circle_end = 1521;
lemni_start = 121;
lemni_end = 1521;

%% cirecle fast

source = readmatrix('quadrotor_circle_fast.csv');
source(:,1) = source(:,1) - source(circle_start,1);
quadrotor_circle.time_raw = source(circle_start:circle_end,1);
quadrotor_circle.position_raw = source(circle_start:circle_end,2:4) + [-0.5 -0.5 0];
quadrotor_circle.ref_raw = source(circle_start:circle_end,5:7) + [-0.5 -0.5 0];
quadrotor_circle.time = 0:sample_time:(circle_end-circle_start)*sample_time;
quadrotor_circle.position = interp1(quadrotor_circle.time_raw,quadrotor_circle.position_raw,quadrotor_circle.time);
quadrotor_circle.ref = interp1(quadrotor_circle.time_raw,quadrotor_circle.ref_raw,quadrotor_circle.time);

fig1 = figure;
plot3(quadrotor_circle.position(:,1),quadrotor_circle.position(:,2),quadrotor_circle.position(:,3),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
hold on
plot3(quadrotor_circle.ref(1:350,1),quadrotor_circle.ref(1:350,2),quadrotor_circle.ref(1:350,3),'Color','k','LineStyle','--','LineWidth',1.5);
axis equal
grid on
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
view(-67.6747,29.2705);
legend('MPC','Reference','Location','northeast');
set(gca,'FontSize',12,'LineWidth',1.5);
xlim([-2,2]);
ylim([-2,2]);
saveas(fig1,'circle_fast_trajectory.png');

fig2 = figure('Name','Circle Error','Position',[700 250 900 600]);
tiledlayout(3,1,'Padding','none');
nexttile
plot(quadrotor_circle.time,quadrotor_circle.ref(:,1)-quadrotor_circle.position(:,1),'Color',[0 0.4470 0.7410],'LineWidth',2);
ylabel('x error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(quadrotor_circle.time,quadrotor_circle.ref(:,2)-quadrotor_circle.position(:,2),'Color',[0 0.4470 0.7410],'LineWidth',2);
ylabel('y error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(quadrotor_circle.time,quadrotor_circle.ref(:,3)-quadrotor_circle.position(:,3),'Color',[0 0.4470 0.7410],'LineWidth',3);
ylabel('z error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
saveas(fig2,'circle_fast_error.png');

v = VideoWriter('cirlce_fast_path.avi','Motion JPEG AVI');
v.FrameRate = 40;
tail_length = 1;
open(v)

for i = 1:length(quadrotor_circle.time)
    figure(3)
    plot(quadrotor_circle.ref(80:175,1),quadrotor_circle.ref(80:175,2),'--k','LineWidth',1.5);
    hold on
    axis([-2 2 -2 2])
    axis equal
    
    % reference
    plot(quadrotor_circle.ref(i,1),quadrotor_circle.ref(i,2),'.','MarkerSize',20,'Color',[0 0.4470 0.7410]);
    if i < tail_length/sample_time+1
        p1 = plot(quadrotor_circle.ref(1:i,1),quadrotor_circle.ref(1:i,2),'-','Color',[0 0.4470 0.7410],'LineWidth',1.5);
    else
        p1 = plot(quadrotor_circle.ref(i-tail_length/sample_time:i,1),quadrotor_circle.ref(i-tail_length/sample_time:i,2),'-','Color',[0 0.4470 0.7410],'LineWidth',1.5);
    end
    
    % hybrid
        plot(quadrotor_circle.position(i,1),quadrotor_circle.position(i,2),'.','MarkerSize',20,'Color',[0.6350 0.0780 0.1840]);
    if i < tail_length/sample_time+1
        p2 = plot(quadrotor_circle.position(1:i,1),quadrotor_circle.position(1:i,2),'-','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
    else
        p2 = plot(quadrotor_circle.position(i-tail_length/sample_time:i,1),quadrotor_circle.position(i-tail_length/sample_time:i,2),'-','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
    end
    
    title('Top view');
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    hold off
    set(gca,'FontSize',13,'LineWidth',1.5);
    legend('Trajectory','','Reference','','MPC');
    drawnow
    thisFrame = getframe(gcf);
    writeVideo(v,thisFrame);
end

close(v)

%% circle slow

source = readmatrix('quadrotor_circle_slow.csv');
source(:,1) = source(:,1) - source(circle_start,1);
quadrotor_circle.time_raw = source(circle_start:circle_end,1);
quadrotor_circle.position_raw = source(circle_start:circle_end,2:4) + [-0.5 -0.5 0];
quadrotor_circle.ref_raw = source(circle_start:circle_end,5:7) + [-0.5 -0.5 0];
quadrotor_circle.time = 0:sample_time:(circle_end-circle_start)*sample_time;
quadrotor_circle.position = interp1(quadrotor_circle.time_raw,quadrotor_circle.position_raw,quadrotor_circle.time);
quadrotor_circle.ref = interp1(quadrotor_circle.time_raw,quadrotor_circle.ref_raw,quadrotor_circle.time);

fig4 = figure;
plot3(quadrotor_circle.position(:,1),quadrotor_circle.position(:,2),quadrotor_circle.position(:,3),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
hold on
plot3(quadrotor_circle.ref(1:350,1),quadrotor_circle.ref(1:350,2),quadrotor_circle.ref(1:350,3),'Color','k','LineStyle','--','LineWidth',1.5);
axis equal
grid on
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
view(-67.6747,29.2705);
legend('MPC','Reference','Location','northeast');
set(gca,'FontSize',12,'LineWidth',1.5);
xlim([-2,2]);
ylim([-2,2]);
saveas(fig4,'circle_slow_trajectory.png');

fig5 = figure('Name','Circle Error','Position',[700 250 900 600]);
tiledlayout(3,1,'Padding','none');
nexttile
plot(quadrotor_circle.time,quadrotor_circle.ref(:,1)-quadrotor_circle.position(:,1),'Color',[0 0.4470 0.7410],'LineWidth',2);
ylabel('x error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(quadrotor_circle.time,quadrotor_circle.ref(:,2)-quadrotor_circle.position(:,2),'Color',[0 0.4470 0.7410],'LineWidth',2);
ylabel('y error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(quadrotor_circle.time,quadrotor_circle.ref(:,3)-quadrotor_circle.position(:,3),'Color',[0 0.4470 0.7410],'LineWidth',3);
ylabel('z error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
saveas(fig5,'circle_slow_error.png');

v = VideoWriter('cirlce_slow_path.avi','Motion JPEG AVI');
v.FrameRate = 40;
tail_length = 1;
open(v)

for i = 1:length(quadrotor_circle.time)
    figure(6)
    plot(quadrotor_circle.ref(80:333,1),quadrotor_circle.ref(80:333,2),'--k','LineWidth',1.5);
    hold on
    axis([-2 2 -2 2])
    axis equal
    
    % reference
    plot(quadrotor_circle.ref(i,1),quadrotor_circle.ref(i,2),'.','MarkerSize',20,'Color',[0 0.4470 0.7410]);
    if i < tail_length/sample_time+1
        p1 = plot(quadrotor_circle.ref(1:i,1),quadrotor_circle.ref(1:i,2),'-','Color',[0 0.4470 0.7410],'LineWidth',1.5);
    else
        p1 = plot(quadrotor_circle.ref(i-tail_length/sample_time:i,1),quadrotor_circle.ref(i-tail_length/sample_time:i,2),'-','Color',[0 0.4470 0.7410],'LineWidth',1.5);
    end
    
    % hybrid
        plot(quadrotor_circle.position(i,1),quadrotor_circle.position(i,2),'.','MarkerSize',20,'Color',[0.6350 0.0780 0.1840]);
    if i < tail_length/sample_time+1
        p2 = plot(quadrotor_circle.position(1:i,1),quadrotor_circle.position(1:i,2),'-','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
    else
        p2 = plot(quadrotor_circle.position(i-tail_length/sample_time:i,1),quadrotor_circle.position(i-tail_length/sample_time:i,2),'-','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
    end
    
    title('Top view');
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    hold off
    set(gca,'FontSize',13,'LineWidth',1.5);
    legend('Trajectory','','Reference','','MPC');
    drawnow
    thisFrame = getframe(gcf);
    writeVideo(v,thisFrame);
end

close(v)

%% lemniscate

source = readmatrix('quadrotor_lemni.csv');
source(:,1) = source(:,1) - source(lemni_start,1);
quadrotor_lemni.time_raw = source(lemni_start:lemni_end,1);
quadrotor_lemni.position_raw = source(lemni_start:lemni_end,2:4) + [0 0.15 0];
quadrotor_lemni.velocity_raw = source(lemni_start:lemni_end,8:10);
quadrotor_lemni.ref_raw = source(lemni_start:lemni_end,5:7);
quadrotor_lemni.time = 0:sample_time:(lemni_end-lemni_start)*sample_time;
quadrotor_lemni.position = interp1(quadrotor_lemni.time_raw,quadrotor_lemni.position_raw,quadrotor_lemni.time);
quadrotor_lemni.velocity = interp1(quadrotor_lemni.time_raw,quadrotor_lemni.velocity_raw,quadrotor_lemni.time);
quadrotor_lemni.ref = interp1(quadrotor_lemni.time_raw,quadrotor_lemni.ref_raw,quadrotor_lemni.time);
quadrotor_lemni.velocity_scalar = sqrt(quadrotor_lemni.velocity(:,1).^2+quadrotor_lemni.velocity(:,2).^2+quadrotor_lemni.velocity(:,3).^2);
quadrotor_lemni.velocity_scalar = smoothdata(quadrotor_lemni.velocity_scalar);

fig7 = figure;
plot3(quadrotor_lemni.position(:,1),quadrotor_lemni.position(:,2),quadrotor_lemni.position(:,3),'Color',[0 0.4470 0.7410],'LineWidth',1.5);
hold on
plot3(quadrotor_lemni.ref(1:350,1),quadrotor_lemni.ref(1:350,2),quadrotor_lemni.ref(1:350,3),'Color','k','LineStyle','--','LineWidth',1.5);
axis equal
grid on
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
view(-58.2976,63.6538);
legend('MPC','Reference','Location','northeast');
set(gca,'FontSize',12,'LineWidth',1.5);
xlim([-2.2,2.2]);
ylim([-1.2,1.2]);
saveas(fig7,'lemni_trajectory.png');

fig8 = figure('Name','Lemniscate Error','Position',[700 250 900 600]);
tiledlayout(3,1,'Padding','none');
nexttile
plot(quadrotor_lemni.time,quadrotor_lemni.ref(:,1)-quadrotor_lemni.position(:,1),'Color',[0 0.4470 0.7410],'LineWidth',2);
ylabel('x error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(quadrotor_lemni.time,quadrotor_lemni.ref(:,2)-quadrotor_lemni.position(:,2),'Color',[0 0.4470 0.7410],'LineWidth',2);
ylabel('y error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(quadrotor_lemni.time,quadrotor_lemni.ref(:,3)-quadrotor_lemni.position(:,3),'Color',[0 0.4470 0.7410],'LineWidth',3);
ylabel('z error [m]');
ylim([-0.7 0.7]);
set(gca,'FontSize',17,'LineWidth',1.5);
saveas(fig8,'lemni_error.png');

v = VideoWriter('lemniscate_path.avi','Motion JPEG AVI');
v.FrameRate = 40;
tail_length = 1;
open(v)

for i = 1:length(quadrotor_lemni.time)
    figure(9)
    tiledlayout(2,1,'Padding','none');
    nexttile
    barh(quadrotor_lemni.velocity_scalar(i));
    yticklabels({''});
    xlabel('Vehicle Velocity (m/s)');
    xlim([0 5]);
    set(gca,'FontSize',13,'LineWidth',1.5);
    
    nexttile
    plot(quadrotor_lemni.ref(121:247,1),quadrotor_lemni.ref(121:247,2),'--k','LineWidth',1.5);
    hold on
    
    plot(quadrotor_lemni.ref(i,1),quadrotor_lemni.ref(i,2),'.','MarkerSize',20,'Color',[0 0.4470 0.7410]);
    if i < tail_length/sample_time+1
        p1 = plot(quadrotor_lemni.ref(1:i,1),quadrotor_lemni.ref(1:i,2),'-','Color',[0 0.4470 0.7410],'LineWidth',1.5);
    else
        p1 = plot(quadrotor_lemni.ref(i-tail_length/sample_time:i,1),quadrotor_lemni.ref(i-tail_length/sample_time:i,2),'-','Color',[0 0.4470 0.7410],'LineWidth',1.5);
    end
    
        plot(quadrotor_lemni.position(i,1),quadrotor_lemni.position(i,2),'.','MarkerSize',20,'Color',[0.6350 0.0780 0.1840]);
    if i < tail_length/sample_time+1
        p2 = plot(quadrotor_lemni.position(1:i,1),quadrotor_lemni.position(1:i,2),'-','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
    else
        p2 = plot(quadrotor_lemni.position(i-tail_length/sample_time:i,1),quadrotor_lemni.position(i-tail_length/sample_time:i,2),'-','Color',[0.6350 0.0780 0.1840],'LineWidth',1.5);
    end
    
    title('Top view');
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    axis equal
    hold off
    set(gca,'FontSize',13,'LineWidth',1.5);
    legend('Trajectory','','Reference','','MPC','Location','northoutside','NumColumns',3);
    drawnow
    thisFrame = getframe(gcf);
    writeVideo(v,thisFrame);
end

close(v)