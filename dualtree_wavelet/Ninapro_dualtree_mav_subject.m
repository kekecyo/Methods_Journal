if ~exist('emg_800ms_sample_sub01')
    load("DB2_800ms_sb01_20.mat");
end


% modify the number of subjects here
subject_length = 20;
% the level of dual tree transform
J = 3;
% the length of filter
FilterLength = 14;
for i = 1:subject_length
    if i < 10
        zero_prefix = '0';
    else
        zero_prefix = '';
    end
    %
    dtcwt_output = strcat('[dtcwt_subject', zero_prefix, num2str(i), 'A, dtcwt_subject', zero_prefix, num2str(i),'D]');
    subject = strcat(dtcwt_output, ' = dualtree(double(emg_800ms_sample_sub', zero_prefix, num2str(i), '), ''Level'', J, ''FilterLength'', FilterLength);');
    eval(subject);
    dt_coefs = strcat('dt_coefs', zero_prefix, num2str(i), ' = dtcwt_subject', zero_prefix, num2str(i), 'D{3};');
    eval(dt_coefs);
    %}
    mean_absolute_value = strcat('mav_coefs', zero_prefix, num2str(i), ' = mean(abs(dt_coefs', zero_prefix, num2str(i),'), 2);');
    eval(mean_absolute_value);
end


fprintf('finished dual tree transform\n');


% if you want to save files of different size, modify the file name here
% and subject_length
file_name = 'dtcwt_subject1-20.mat';

save(file_name, 'dtcwt_subject01A', 'dtcwt_subject01D', '-v7.3');
for i = 2:subject_length
    if i < 10
        zero_prefix = '0';
    else
        zero_prefix = '';
    end
    save(file_name, strcat('dtcwt_subject', zero_prefix, num2str(i), 'A'), '-append');
    save(file_name, strcat('dtcwt_subject', zero_prefix, num2str(i), 'D'), '-append');
end

% as one example, you can plot the stem signal graph as indicated in the
% MATLAB help page: 
% https://www.mathworks.com/help/wavelet/ug/dual-tree-complex-wavelet-transforms.html
%fig = stem(mav_coefs01,'markerfacecolor',[0 0 1]);
%hold on; grid on;
%stem(mav_coefs02,'markerfacecolor',[0 0 1]);
hold off;
step_size = 50;
distFromX01 = sqrt((mav_coefs01(1:step_size:end)).^1.5);
distFromX02 = sqrt((mav_coefs02(1:step_size:end)).^1.5);
x01 = 1:step_size:length(mav_coefs01);
x02 = 1:step_size:length(mav_coefs02);
s01 = scatter(x01, mav_coefs01(1:step_size:end), 'filled');
s01.AlphaData = distFromX01;
s01.MarkerFaceAlpha = 'flat';
hold on; grid on;
s02 = scatter(x02, mav_coefs02(1:step_size:end), 'filled');
s02.AlphaData = distFromX02;
s02.MarkerFaceAlpha = 'flat';
legend([s01, s02], 'Subject 01', 'Subject 02', 'fontsize', 32);
legend('boxoff')

