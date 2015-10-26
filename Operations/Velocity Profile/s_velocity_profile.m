load('Autocross_Nebraska_2013_struct.mat')
load('Simple_tire.mat')
load('MFE2.mat')

% remove all radii =0
% (radius =0 indicates straights, replace with very large number)
for i=1:size(track.r,1)
    if track.r(i)==0
        track.r(i)=50000000;
    end
end

% find velocity profile for max cornering
% this is max velocity assuming tire is used only for lateral acceleration
for i=1:size(track.r,1)
    v_profile(i,1)=f_velocity_profile( car,tire,track,i );
end
track.results.v_profile=v_profile;
clear v_profile i
figure, hold on
% plot velocity vs elapsed distance
%plot(track.d,track.results.v_profile,'.')


% find minimum velocity points for each corner
% these are taken as the desired speed for that corner
track=f_find_peaks(track);