clc;
%% open data
data = readtable('/Users/XXX.csv');

dat_matrix = table2array(data);  
% dat_index = table2array(data_index); 

clear data data_index

% segmentation: check how many cell can be segmentated
sample_size = 1600;
num_samples = floor(size(dat_matrix,1) / sample_size);

sagment_matrix_check = cell(num_samples,1);
for i = 1:num_samples
    sample_start = (i-1)*sample_size + 1;
    sample_end = i*sample_size;
    sagment_matrix_check{i} = dat_matrix(sample_start:sample_end,:);
end

% delete the remaining rows
delete_data1 = dat_matrix(1:num_samples*sample_size,:);

clear i sample_size sample_start sample_end num_samples delete_data1

%% segmentation: previous100 + 1600 + next100

sample_size = 1600;
num_samples = floor(size(dat_matrix,1) / sample_size);

segmented_dda = cell(num_samples,1);
for i = 1:num_samples
    sample_start = (i-1)*sample_size + 1;
    sample_end = i*sample_size;
    
    % Check if it is the first sample
    if i == 1
        % Only add the next 100 rows
        current_sample = dat_matrix(sample_start:sample_end,:);
        next_sample_start = sample_end + 1;
        next_sample_end = sample_end + 200;
        next_sample = dat_matrix(next_sample_start:next_sample_end,:);
        current_sample = [current_sample; next_sample];
    % Check if it is the last sample
    elseif i == num_samples
        % Only add the previous 100 rows
        prev_sample_start = sample_start - 200;
        prev_sample_end = sample_start - 1;
        prev_sample = dat_matrix(prev_sample_start:prev_sample_end,:);
        current_sample = dat_matrix(sample_start:sample_end,:);
        current_sample = [prev_sample; current_sample];
    else
        % Add previous 100 rows and next 100 rows
        prev_sample_start = sample_start - 100;
        prev_sample_end = sample_start - 1;
        prev_sample = dat_matrix(prev_sample_start:prev_sample_end,:);
        current_sample = dat_matrix(sample_start:sample_end,:);
        next_sample_start = sample_end + 1;
        next_sample_end = sample_end + 100;
        next_sample = dat_matrix(next_sample_start:next_sample_end,:);
        current_sample = [prev_sample; current_sample; next_sample];
    end
    
    % Add current sample to the segmented data cell array
    segmented_dda{i} = current_sample;
end

clear i sample_size sample_start sample_end num_samples next_sample_start next_sample_end next_sample current_sample prev_sample_start prev_sample_end prev_sample

%  check if each cell contains 0. and number of 0 data 
num_samples = length(segmented_dda);
zero_counts = zeros(num_samples, 1);

for i = 1:num_samples
    zero_counts(i) = numel(segmented_dda{i}) - nnz(segmented_dda{i});
end

% disp(zero_counts);

clear i num_samples sagment_matrix_check

%  check numbers for each column of each cell 
% initialize zero_counts cell array
zero_colum_each = cell(size(segmented_dda));

% loop through each cell in segmented_dda
for i = 1:numel(segmented_dda)
    % get current cell
    current_cell = segmented_dda{i};
    
    % count number of zeros in each column
    num_zeros = sum(current_cell == 0);
    
    % store results in zero_counts cell array
    zero_colum_each{i} = num_zeros;
end

clear i num_zeros current_cell

%%  if zero_counts > 10%, delete and check

nozero_segmented_dda = segmented_dda;

for i = 1:length(nozero_segmented_dda) % iterate through each double
    curr_double = nozero_segmented_dda{i};
    num_zeros = sum(curr_double == 0); % count number of zeros in each column
    for j = 1:size(curr_double, 2) % iterate through each column
        if num_zeros(j) > 180 % if number of zeros is greater than 180
            nozero_segmented_dda{i} = []; % delete the entire double
            break % move to the next double
        else
            % fill the zero values with the average of the same position column of the next double
            if any(curr_double(:, j) == 0)
                next_idx = i + 1;
                while next_idx <= length(nozero_segmented_dda) && all(nozero_segmented_dda{next_idx}(:, j) == 0)
                    next_idx = next_idx + 1; % find the next non-zero column
                end
                if next_idx > length(nozero_segmented_dda) % if all remaining doubles contain zeros in the current column
                    prev_idx = i - 1;
                    while prev_idx >= 1 && all(nozero_segmented_dda{prev_idx}(:, j) == 0)
                        prev_idx = prev_idx - 1; % find the previous non-zero column
                    end
                    if prev_idx >= 1 % if previous non-zero column is found
                        nozero_segmented_dda{i}(:, j) = mean(nozero_segmented_dda{prev_idx}(:, j)); % fill with average of previous non-zero column
                    end
                else % if non-zero column is found in the next doubles
                    nozero_segmented_dda{i}(curr_double(:, j) == 0, j) = mean(nozero_segmented_dda{next_idx}(nozero_segmented_dda{next_idx}(:, j) ~= 0, j)); % fill with average of next non-zero column
                end
            end
        end
    end
end


nozero_segmented_dat = nozero_segmented_dda;
idx = cellfun(@isempty, nozero_segmented_dat);
nozero_segmented_dat(idx) = [];

%  check numbers for each column of each cell 
% initialize zero_counts cell array
nozero_counts = cell(size(nozero_segmented_dda));

% loop through each cell in segmented_dda
for i = 1:numel(nozero_segmented_dda)
    % get current cell
    current_cell = nozero_segmented_dda{i};
    
    % count number of zeros in each column
    num_zeros = sum(current_cell == 0);
    
    % store results in zero_counts cell array
    nozero_counts{i} = num_zeros;
end

clear i idx j curr_double next_idx num_zeros i num_zeros current_cell segmented_dda zero_counts zero_colum_each nozero_segmented_dda nozero_counts prev_idx

%% generation index and save !!!!! According to the sample size to set

% Create a cell array
nozero_segmented_dat_new = cell(127, 2);   % According to the sample size to set

% Copy the data from the first column of the original cell array to the first column of the new cell array
nozero_segmented_dat_new(:, 1) = nozero_segmented_dat;

% Set the second column of the new cell array to 1
nozero_segmented_dat_new(:, 2) = num2cell(ones(127, 1));  % According to the sample size to set

nozero_segmented_index = nozero_segmented_dat_new(:,2);

for i = 1:numel(nozero_segmented_index)
     if nozero_segmented_index{i} == 1
         nozero_segmented_index{i} = 4;
     end
 end

clear nozero_segmented_dat_new dat_matrix i ample_size data

%% %%Sample generation_each_subject
segment_emg_all = [XXX; XXX;];

segment_index_all = [XXX; XXX;];


%% 
csvwrite(['/Users/XXX.csv'], segment_index_all);

%% filter

for i = 1:2174
     for j = 1:1800
         EMG{i}(j,:) = filter(Hd_5_500, emg_Fen{i}(j,:));
     end
end


% 1*1763 - 1763*1
EMG_t = transpose(EMG); 

clear i j EMG

%% 
filter_emg_all = [XXX; XXX;];

%% 1800*8 - 8*1800

num_cells = size(filter_emg_all, 1); 

for i = 1:num_cells 
    filter_emg_all{i} = filter_emg_all{i}.'; 
end

 clear i num_cells

%% %% dualtree

for i = 1:32973
    for j = 1:8
        [AwavenorestA{i}(j,:),AwavenorestD{i}(j,:)] = dualtree(filter_emg_all{i}(j,:), 'Level', 3);
    end
end 
% for i =1:100
% [dtcwt_subject20AAA(:,i), dtcwt_subject20DDD(:,i)] = dualtree(aatest(:,i), 'Level', 3);
% end
for i = 1:32973
    AwavenorestD_level_1{i}(:,:) = AwavenorestD{i}{1}(:,:);
    AwavenorestD_level_2{i}(:,:) = AwavenorestD{i}{2}(:,:);
    AwavenorestD_level_3{i}(:,:) = AwavenorestD{i}{3}(:,:);
end

clear i j AwavenorestD_level_3 AwavenorestD_level_2 AwavenorestD_level_1 AwavenorestD transpose_matrix

%% %% %% 18 & 15 & 12 & 8 & 5

for i = 1:32973
   AwaveMAV{i}(:,:) = mean(abs(AwavenorestA{i}));
   AwaveSD{i}(:,:) = std(AwavenorestA{i});
   AwaveSew{i}(:,:) = skewness(AwavenorestA{i});
   AwaveKurto{i}(:,:) = kurtosis(AwavenorestA{i});

    for ii = 1:8
    %%Zero crossing
        %AwaveZC{i}(:,ii) = jNewZeroCrossing(AwavenorestA{i}(ii,:));
    %%%Average energy
        %AwaveAE{i}(:,ii) = jAverageEnergy(AwavenorestA{i}(:,ii));
    %%Waveform length
        AwaveWaveform{i}(:,ii) = jWaveformLength(AwavenorestA{i}(ii,:));
    %%Maximum Fractal Length
        AwaveFractal{i}(:,ii) = jMaximumFractalLength(AwavenorestA{i}(ii,:));
    %%%% here for new methods
        %AwaveMAV{i}(:,ii) = jMeanAbsoluteValue(AwavenorestA{i}(:,ii));
        AwaveIENG{i}(:,ii) = jIntegratedEMG(AwavenorestA{i}(ii,:));
        %AwaveRMS{i}(:,ii) = jRootMeanSquare(AwavenorestA{i}(:,ii));
        %AwaveLOGD{i}(:,ii) = jLogDetector(AwavenorestA{i}(:,ii));
        %complex numbers
        %AwaveLOGCVAR{i}(:,ii) = jLogCoefficientOfVariation(AwavenorestA{i}(:,ii));
        AwaveLOGDABS{i}(:,ii) = jLogDifferenceAbsoluteMeanValue(AwavenorestA{i}(ii,:));
        %AwaveCVAR{i}(:,ii) = jCoefficientOfVariation(AwavenorestA{i}(:,ii));
        %AwaveDABS{i}(:,ii) = jDifferenceAbsoluteMeanValue(AwavenorestA{i}(:,ii));
        %AwaveDABSD{i}(:,ii) = jDifferenceAbsoluteStandardDeviationValue(AwavenorestA{i}(:,ii));
        %AwaveDVAR{i}(:,ii) = jDifferenceVarianceValue(AwavenorestA{i}(:,ii));
        AwaveEMAV{i}(:,ii) = jEnhancedMeanAbsoluteValue(AwavenorestA{i}(ii,:));
        %AwaveSSI{i}(:,ii) = jSimpleSquareIntegral(AwavenorestA{i}(:,ii));

    end
end

clear i ii AwavenorestA

%% %% 

for i = 1:32973
    for ii = 1:8
        Feature_vec{i}(ii,:) = [AwaveWaveform{i}(ii); AwaveFractal{i}(ii); 
            AwaveIENG{i}(ii); AwaveLOGDABS{i}(ii); AwaveEMAV{i}(ii)];
    end
end

clear i ii j


%% 
%