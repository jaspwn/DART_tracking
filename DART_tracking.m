%% load data

load('IR tracking (04-Nov-2016).mat')

data = snTot

%% Calculate delta in coordinates and work out distance

for i = 1:length(data.Px)
    delta_x{i} = diff(data.Px{i});
    delta_y{i} = diff(data.Py{1});
    dist{i} = hypot(delta_x{i},delta_y{i});
end

%% Calculates average distance travelled per video

nframes_video = data.iMov.iPhase(2);
n_video = length(data.T)/nframes_video;
idx_seq = 0:nframes_video:length(data.T);



for i = 1:length(dist)
    for j = 1:length(idx_seq)
        if j < length(idx_seq)-1
            mean_dist{i}(j) = nanmean(dist{i}(idx_seq(j)+1:idx_seq(j+1)));
        else
            mean_dist{i}(j) = nanmean(dist{i}(idx_seq(j)+1:idx_seq(j-1)));
        end
    end
end

%% Calculate mean across each apparatus for each timepoint

% working

for i = 1:length(mean_dist{1})
    means(i) = nanmean([mean_dist{1}(i) mean_dist{2}(i) mean_dist{3}(i) mean_dist{4}(i) mean_dist{5}(i) mean_dist{6}(i) mean_dist{7}(i) mean_dist{8}(i)])
end

%% Creates time vector

% find data that corresponds to frame rate and inter-movie interval to
% calculate absolute time per video

starttime = datetime(data.TimeInfo.T0)

for i = 1:n_video
    time_vec(i) = starttime + (i-1)*minutes(15);
end

%% Working rubbish 

day_1 = means(1:96)
day_2 = means(97:192)
day_3 = means(193:288)

for i = 1:length(day_1)
    day_means(i) = nanmean([day_1(i) day_2(i) day_3(i)])
end




