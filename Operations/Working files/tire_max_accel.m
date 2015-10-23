s_velocity_profile;

% get equations for acceleration and final velocity
[accel_eqn,vf_eqn]=f_get_equation(track,car,tire,1);

% calculate max ax/ay starting from rest at d=0
track=f_lap_start(track,car,accel_eqn,vf_eqn);

% calculate max ax/ay starting from each velocity profile peak
% for acceleration
track=f_velocity_profile_acceleration(track,car,accel_eqn,vf_eqn);
clear accel_eqn vf_eqn

% get equations for braking condition
[brake_eqn,vf_eqn]=f_get_equation(track,car,tire,0);

% calculate max ax/ay starting from each velocity profile peak
% for braking
track=f_velocity_profile_braking(track,car,brake_eqn,vf_eqn);
clear brake_eqn vf_eqn

plot(1:7910,track.results.v_profile,'.')
