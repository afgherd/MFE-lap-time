function [ v_max ] = f_velocity_profile( car,tire,track,i )
% 

% limit radius to motor limitations
% very large radii would result in very large max speeds
% by setting very large radii equal to r_max the maximum
% calculated speed is that imposed by the motor
r_max=car.motor_speed^2/((32.174+car.rho*car.area*car.lift*car.motor_speed^2/(2*car.mass))*tire.ay_max);

if abs(track.r(i))>r_max 
    R=r_max;
else
    R=abs(track.r(i));
end

% get velocity profile
v_max=abs(tire.ay_max*2*car.mass*32.174*R/(2*car.mass-tire.ay_max*car.area*car.lift*car.rho*R))^0.5;