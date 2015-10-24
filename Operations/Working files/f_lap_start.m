function [ track ] = f_lap_start( track,car,accel_eqn,vf_eqn )
% Start lap at v0=0

% initialize v_max at max speed
% (in order to take minimum of velocity and acceleration profile)
v_max(1:size(track.results.v_profile,1),1)=car.motor_speed;

% Start lap, initial velocity=0
v_max(1,1)=0;
i=1;
while v_max(i,1)<=track.results.v_profile(i)
    
    % find max acceleration allowed by motor
    [force,rpm]=f_motor_map(v_max(i,1));
    track.results.accel_motor(i,1)=force/car.mass;
    track.results.rpm(i,1)=rpm;
    % find max acceleration allowed by tires
    accel_traction=accel_eqn(abs(track.r(i+1)),v_max(i,1));
    if isreal(accel_traction)
        track.results.accel_tire(i,1)=accel_traction;
    else
        break
    end
    % find max acceleration
    track.results.accel_max(i,1)=min(track.results.accel_motor(i,1),track.results.accel_tire(i,1));

    vf=vf_eqn(track.results.accel_max(i,1),v_max(i,1),abs(track.r(i+1)));
    v_max(i+1,1)=vf(vf>0);
    i=i+1;
end

% merge velocity and acceleration profile
for i=1:size(track.results.v_profile,1)
    track.results.v_profile(i,1)=min(track.results.v_profile(i,1),v_max(i,1));
end

end

