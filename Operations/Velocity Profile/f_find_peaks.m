function [ track ] = f_find_peaks( track )

count=1;

%check if first point is a peak
i=1;
if track.results.v_profile(i,1)<track.results.v_profile(i+1,1)
    track.results.v_peaks(count,1)=track.results.v_profile(i,1);
    track.results.d_peaks(count,1)=track.d(i,1);
    count=count+1;
end

% find all other peaks
for i=2:size(track.r,1)
    if track.results.v_profile(i,1)<track.results.v_profile(i-1,1) && track.results.v_profile(i,1)<track.results.v_profile(i+1,1)
        track.results.v_peaks(count,1)=track.results.v_profile(i,1);
        track.results.d_peaks(count,1)=track.d(i,1);
        count=count+1;
    end
end
hold on
plot(track.results.d_peaks(:,1)/track.dx,track.results.v_peaks,'.')