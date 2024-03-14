unzip('results.zip','.');

file_name = '2024_03_14_06_18';
% file_name = 'lane_keeping_29';
source = readmatrix(['./results/',file_name,'.csv']);
   
time = source(:,1);
x = source(:,2);
y = source(:,3);
psi = source(:,4);
vx = source(:,5);
vy = source(:,6);
r = source(:,7);
twist_collective = source(:,8);
phi = source(:,9);
beta = source(:,10);
phi_dot = source(:,11);
omega = source(:,12);
s = source(:,13);
d = source(:,14);
delta_phi = source(:,15);
kappa_ref = source(:,16);
v_ref = source(:,17);
phi_ref = source(:,18);
x_ref = source(:,19);
y_ref = source(:,20);
phi_dot_ref = source(:,21);
beta_ref = source(:,22);
beta_dot_ref = source(:,23);
r_dot_ref = source(:,24);
drift_sign = source(:,25);
stop_sign = source(:,26);
delta_des = source(:,27);
tau_des = source(:,28);

vehicle_param.m = 1.322;
vehicle_param.g = 9.81;
vehicle_param.mu = 0.25;
vehicle_param.l_f = 0.126;
vehicle_param.l_r = 0.131;
vehicle_param.l = 0.257;
vehicle_param.c_alpha_f = 17;
vehicle_param.c_alpha_r = 17;
vehicle_param.vl_f = (vehicle_param.m*vehicle_param.g*vehicle_param.l_r/vehicle_param.l_f)/(1+vehicle_param.l_r/vehicle_param.l_f)/2;
vehicle_param.vl_r = (vehicle_param.m*vehicle_param.g*vehicle_param.l_f/vehicle_param.l_r)/(1+vehicle_param.l_f/vehicle_param.l_r)/2;
vehicle_param.f_drag = 0.08;
vehicle_param.tire_r = 0.0334;

param.kp_v = 0.2;
param.k_ff = vehicle_param.vl_f/vehicle_param.c_alpha_f - vehicle_param.vl_r/vehicle_param.c_alpha_r;
param.x_la = 0.1;
param.kp_delta_lane = 8.0;
param.kp_delta_damping = 0.04;
param.fx_r_safety_factor = 0.1;

tau_des_cal = min(((v_ref-twist_collective)*param.kp_v*vehicle_param.m+vehicle_param.f_drag),vehicle_param.vl_r*vehicle_param.mu*param.fx_r_safety_factor)*vehicle_param.tire_r/2;

delta_ff = kappa_ref.*(vehicle_param.l + twist_collective.*twist_collective*param.k_ff/vehicle_param.g);

e_la = (d + (vehicle_param.l_f+param.x_la)*sin(delta_phi));

delta_lanekeeping = -2*param.kp_delta_lane/vehicle_param.c_alpha_f*e_la;

delta_phi_dot = r - twist_collective.*kappa_ref.*(cos(delta_phi)-tan(beta).*sin(delta_phi));
delta_damping = -param.kp_delta_damping*delta_phi_dot;

figure
plot(x,y);
hold on
plot(x_ref,y_ref);
axis equal

figure
plot(time,twist_collective);
hold on
plot(time,v_ref);
twist_collective_filtered = movmean(twist_collective,10);
plot(time,twist_collective_filtered);
xlim([0 17]);

figure
plot(time,delta_des)
hold on
plot(time,delta_ff)
plot(time,delta_lanekeeping)
plot(time,delta_damping)
legend('delta des','delta ff','delta lanekeeping','delta damping');
xlim([0 17]);
