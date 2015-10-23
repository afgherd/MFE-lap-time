function [ track ] = f_lap_start( track,car,accel_eqn,vf_eqn )
% Start lap at v0=0

% initialize v_max at max speed
% (take minimum of velocity and acceleration profile)
v_max(1:size(track.results.v_profile,1),1)=car.motor_speed;

% Start lap, initial velocity=0
v_max(1,1)=0;
i=1;
while v_max(i,1)<=track.results.v_profile(i)
    acceleration=accel_eqn(abs(track.r(i+1)),v_max(i,1));
    if isreal(acceleration)
        accel_tire(i,1)=acceleration;
    else
        break
    end
    
    vf=vf_eqn(accel_tire(i,1),v_max(i,1),abs(track.r(i+1)));
    v_max(i+1,1)=vf(vf>0);
    i=i+1;
end

% merge velocity and acceleration profile
for i=1:size(track.results.v_profile,1)
    track.results.v_profile(i,1)=min(track.results.v_profile(i,1),v_max(i,1));
end

end

