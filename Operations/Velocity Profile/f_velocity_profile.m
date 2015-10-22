function [ v_max ] = f_velocity_profile( car,tire,track,i )
% 

% limit radius to motor limitations
r_max=car.motor_speed^2/((1+car.rho*car.area*car.lift*car.motor_speed^2/(2*car.mass))*tire.ay_max);

if abs(track.r(i))>r_max 
    R=r_max;
else
    R=abs(track.r(i));
end

% get velocity profile
v_max=abs(tire.ay_max*2*car.mass*R/(2*car.mass-tire.ay_max*car.area*car.lift*car.rho*R))^0.5;