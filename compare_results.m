clear all

unzip('results.zip','./results');

file_names = {'2023_10_26_06_37','2023_10_26_06_41'};

fig1 = figure('Name','Tracking Results','Position',[700 250 900 600]);
tiledlayout(3,1,'Padding','none');
for i = 1:size(file_names,2)
   plot_figure(file_names{i},i);
end
ax = nexttile(1);
legend(['Reference',file_names],'Location','northoutside','Orientation','horizontal');
saveas(fig1,'compare_results.png');

function plot_figure(file_name,i)
    color_selections = [0 0.4470 0.7410;0.6350 0.0780 0.1840;0.4660 0.6740 0.1880;0.9290 0.6940 0.1250;0.4940 0.1840 0.5560;0.8500 0.3250 0.0980];

    % t,ref_x,x,ref_y,y,ref_z,z,ref_u,u,ref_v,v,ref_w,w,ref_phi,phi,ref_theta,theta,ref_psi,psi,thrust
    source = readmatrix(['./results/',file_name,'.csv']);
    
    time = source(:,1);
    x = source(:,3);
    y = source(:,5);
    z = source(:,7);
    
    if i == 1   % Plot reference only for first csv
        ref_x = source(:,2);
        ref_y = source(:,4);
        ref_z = source(:,6);
        ax = nexttile(1);
        plot(time,ref_x,'Color','k','LineStyle','--','LineWidth',2);
        xlim([0 time(end)]);
        hold on
        ax = nexttile(2);
        plot(time,ref_y,'Color','k','LineStyle','--','LineWidth',2);
        xlim([0 time(end)]);
        hold on
        ax = nexttile(3);
        plot(time,ref_z,'Color','k','LineStyle','--','LineWidth',2);
        xlim([0 time(end)]);
        hold on
    end
    
    ax = nexttile(1);
    plot(time,x,'Color',color_selections(i,:),'LineWidth',2);
    hold on
    ylabel('X Position [m]');
    set(gca,'FontSize',17,'LineWidth',1.5);
    ax = nexttile(2);
    plot(time,y,'Color',color_selections(i,:),'LineWidth',2);
    hold on
    ylabel('Y Position [m]');
    set(gca,'FontSize',17,'LineWidth',1.5);
    ax = nexttile(3);
    plot(time,z,'Color',color_selections(i,:),'LineWidth',2);
    hold on
    ylabel('Z Position [m]');
    set(gca,'FontSize',17,'LineWidth',1.5);
        
end
