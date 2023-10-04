clear all

unzip('results.zip','./results');

file_name = '2023_09_26_15_52';

source = readmatrix(['./results/',file_name,'.csv']);

time = source(:,1);
ref_x = source(:,2);
x = source(:,3);
ref_y = source(:,4);
y = source(:,5);
ref_z = source(:,6);
z = source(:,7);
ref_u = source(:,8);
u = source (:,9);
ref_v = source(:,10);
v = source(:,11);
ref_w = source(:,12);
w = source(:,13);
ref_phi = rad2deg(source(:,14));
phi = rad2deg(source(:,15));
ref_theta = rad2deg(source(:,16));
theta = rad2deg(source(:,17));
ref_psi = rad2deg(source(:,18));
psi = rad2deg(source(:,19));
thrust = source(:,20);
yaw_prediction = rad2deg(source(:,21:end));

% fig1 = figure('Name','Position Tracking Results','Position',[700 250 900 600]);
% tiledlayout(3,1,'Padding','none');
% nexttile
% plot(time,x,'Color',[0 0.4470 0.7410],'LineWidth',2);
% hold on
% plot(time,ref_x,'Color','k','LineStyle','--','LineWidth',2);
% legend(file_name,'Reference','Location','northoutside','Orientation','horizontal');
% ylabel('X Position [m]');
% set(gca,'FontSize',17,'LineWidth',1.5);
% nexttile
% plot(time,y,'Color',[0 0.4470 0.7410],'LineWidth',2);
% hold on
% plot(time,ref_y,'Color','k','LineStyle','--','LineWidth',2);
% ylabel('Y Position [m]');
% set(gca,'FontSize',17,'LineWidth',1.5);
% nexttile
% plot(time,z,'Color',[0 0.4470 0.7410],'LineWidth',2);
% hold on
% plot(time,ref_z,'Color','k','LineStyle','--','LineWidth',2);
% ylabel('Z Position [m]');
% set(gca,'FontSize',17,'LineWidth',1.5);
% 
% fig2 = figure('Name','Velocity Tracking Results','Position',[700 250 900 600]);
% tiledlayout(3,1,'Padding','none');
% nexttile
% plot(time,u,'Color',[0 0.4470 0.7410],'LineWidth',2);
% hold on
% plot(time,ref_u,'Color','k','LineStyle','--','LineWidth',2);
% legend(file_name,'Reference','Location','northoutside','Orientation','horizontal');
% ylabel('X Velocity [m/s]');
% set(gca,'FontSize',17,'LineWidth',1.5);
% nexttile
% plot(time,v,'Color',[0 0.4470 0.7410],'LineWidth',2);
% hold on
% plot(time,ref_v,'Color','k','LineStyle','--','LineWidth',2);
% ylabel('Y Velocity [m/s]');
% set(gca,'FontSize',17,'LineWidth',1.5);
% nexttile
% plot(time,w,'Color',[0 0.4470 0.7410],'LineWidth',2);
% hold on
% plot(time,ref_w,'Color','k','LineStyle','--','LineWidth',2);
% ylabel('Z Velocity [m/s]');
% set(gca,'FontSize',17,'LineWidth',1.5);

fig3 = figure('Name','Attitude Tracking Results','Position',[700 250 900 600]);
tiledlayout(3,1,'Padding','none');
nexttile
plot(time,phi,'Color',[0 0.4470 0.7410],'LineWidth',2);
hold on
plot(time,ref_phi,'Color','k','LineStyle','--','LineWidth',2);
legend(file_name,'Reference','Location','northoutside','Orientation','horizontal');
ylabel('Phi Angle [deg]');
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(time,theta,'Color',[0 0.4470 0.7410],'LineWidth',2);
hold on
plot(time,ref_theta,'Color','k','LineStyle','--','LineWidth',2);
ylabel('Theta Angle [deg]');
set(gca,'FontSize',17,'LineWidth',1.5);
nexttile
plot(time,psi,'Color',[0 0.4470 0.7410],'LineWidth',2);
hold on
plot(time,ref_psi,'Color','k','LineStyle','--','LineWidth',2);
hold on
i = 95;
plot(time(i:i+20),yaw_prediction(i,:),'Color',[0.6350 0.0780 0.1840],'LineWidth',2);
ylabel('Psi Angle [deg]');
set(gca,'FontSize',17,'LineWidth',1.5);

% saveas(fig1,'position_tracking_results.png');