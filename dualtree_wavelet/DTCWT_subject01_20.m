load("DB2_800ms_sb01_20.mat");

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
    dtcwt_output = strcat('[dtcwt_subject', zero_prefix, num2str(i), 'A, dtcwt_subject', zero_prefix, num2str(i),'D]');
    subject = strcat(dtcwt_output, ' = dualtree(double(emg_800ms_index_sub', zero_prefix, num2str(i), '), ''Level'', J, ''FilterLength'', FilterLength);');
    eval(subject);
    dt_coefs = strcat('dt_coefs', zero_prefix, num2str(i), ' = dtcwt_subject', zero_prefix, num2str(i), 'D{3};');
    eval(dt_coefs);
end

fprintf('finished dual tree transform\n');

file_name = 'dtcwt_subject1-10.mat';

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
dualtree_coefficients = dt_coefs01;
stem(abs(dualtree_coefficients),'markerfacecolor',[0 0 1]);


