function ax = calc_max_accel( X,track,car,tire )
%

v_initial=12;
R=70;

ax_max=tire.ac_max;
ax=(v_initial^2+2*track.dx*(1+car.area*car.lift*car.rho*tire.ay_max*(1-(X/ax_max)^2)^0.5*R/((1-car.area*car.lift*car.rho*tire.ay_max*(1-(X/ax_max)^2)^0.5*R/(2*car.mass))*2*car.mass))*X-tire.ay_max*(1-(X/ax_max)^2)^0.5*R/(1-car.area*car.lift*car.rho*tire.ay_max*(1-(X/ax_max)^2)^0.5*R/(2*car.mass)));

end

