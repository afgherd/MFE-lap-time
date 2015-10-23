% get equations for acceleration and final velocity
[accel_eqn,vf_eqn]=f_get_equation(track,car,tire,1);

track=f_lap_start(track,car,accel_eqn,vf_eqn);

% reinitialize v_max at max speed
v_max(1:size(track.results.v_profile,1),1)=car.motor_speed;

% get acceleration profile for each minimum of velocity profile
for i=1:size(track.results.d_peaks,1)
    
    position=round(track.results.d_peaks(i,1)/track.dx);
    step=0;
    v_max(position,1)=track.results.v_peaks(i);
    
    while v_max(position+step,1)<=track.results.v_profile(position+step) && position+step<size(track.r,1)
        v_initial=v_max(position+step,1);
        
        acceleration=accel_eqn(abs(track.r(position+step+1)),v_initial);
        if isreal(acceleration)
            accel_tire(position+step,1)=acceleration;
        else
            break
        end
        
        vf=vf_eqn(accel_tire(position+step,1),v_max(position+step,1),abs(track.r(position+step+1)));
        v_max(position+step+1,1)=vf(vf>0);
        step=step+1;
    end
    
    % merge velocity and acceleration profile
    %for i=1:size(track.results.v_profile,1)
      %  track.results.v_profile(i,1)=min(track.results.v_profile(i,1),v_max(i,1));
    %end
    
end