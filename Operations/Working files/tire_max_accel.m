s_velocity_profile;

% get equations for acceleration and final velocity
[accel_eqn,vf_eqn_accel]=f_get_equation(track,car,tire,1);

% calculate max ax/ay starting from rest at d=0
track=f_lap_start(track,car,accel_eqn,vf_eqn_accel);

% calculate max ax/ay starting from each velocity profile peak
% for acceleration
track=f_velocity_profile_acceleration(track,car,accel_eqn,vf_eqn_accel);


% get equations for braking condition
[brake_eqn,vf_eqn_brake]=f_get_equation(track,car,tire,0);

% calculate max ax/ay starting from each velocity profile peak
% for braking
track=f_velocity_profile_braking(track,car,brake_eqn,vf_eqn_brake);


plot(track.d,track.results.v_profile,'.')
title(sprintf('%s speed around %s',car.name,track.name))
xlabel('distance (ft)')
ylabel('speed (ft/s)')