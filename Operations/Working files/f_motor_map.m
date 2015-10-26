function [ force,rpm ] = f_motor_map(car_speed)
% get motor speed in rpm from car speed
% from rpm find max force applied at wheels
% gear ratio=3.5

% convert car speed to motor rpm
rpm=car_speed*60*3.5/(2*pi*0.75);

% get motor max torque at specifieed speed
% from motor data
if rpm<=2000
    torque=177;
elseif rpm<5000
    torque=0.73756214837*(-1.75*10^-6*rpm^2+0.00435*rpm+238.2);
else
    torque=159.3;
end

% convert motor torque to longitudinal force at wheels
tire_radius=0.75; %ft

force=torque*3.5/tire_radius;

end