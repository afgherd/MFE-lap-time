function [ ax_handle,vf_handle ] = f_get_equation( track,car,tire,direction )
% returns equations for acceleration and final velocity as function handles
% ax input is (R,v1)
% vf input is (ax,v1,R)
% if direction~=0 accel, else brake

warning off %#ok<WNOFF>
syms v2 v1 ax ay R
if direction
    ax_max=tire.ac_max;
    %i=1;
else
    ax_max=tire.br_max;
    car.drag=-car.drag;
    %i=2;
end

assume(car.motor_speed>=v2>=0)
assume(car.motor_speed>=v1>=0)
assume(0<=ax<=ax_max)
assume(0<=ay<=tire.ay_max)
assume(R>0)

f0(ax)=tire.ay_max*(1-ax^2/ax_max^2)^0.5;

lateral(ax,v2,R)=f0(ax)*R*(32.174+car.rho*car.area*car.lift*v2^2/2/car.mass)-v2^2;
vf2_eqn(ax,v1,R)=solve(lateral==0,v2);


longitudinal(ax,v2,v1,R)=v1^2+2*track.dx*ax*32.174+track.dx*ax*car.rho*car.area*(car.lift-car.drag/ax)*v2^2/car.mass-v2^2;
vf_eqn(ax,v1,R)=solve(longitudinal==0,v2);


ax_eqn=solve(vf2_eqn(ax,v1,R)==vf_eqn(ax,v1,R),ax);
% only keep positive solutions (1st for accel)
ax_eqn=ax_eqn(1);

% convert symfun to function handle
ax_handle=matlabFunction(ax_eqn);
vf_handle=matlabFunction(vf_eqn);
%end

