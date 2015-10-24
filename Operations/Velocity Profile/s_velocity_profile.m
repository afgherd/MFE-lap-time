load('Autocross_Nebraska_2013_struct.mat')
load('Simple_tire.mat')
load('MFE2.mat')

figure
hold on

% remove all radii =0
for i=1:size(track.r,1)
    if track.r(i)==0
        track.r(i)=50000000;
    end
end

% find velocity profile for max cornering
for i=1:size(track.r,1)
    v_profile(i,1)=f_velocity_profile( car,tire,track,i );
end
track.results.v_profile=v_profile;
clear v_profile i
%plot(track.d/track.dx,track.results.v_profile,'.')

% find minimum velocity points
track=f_find_peaks(track);