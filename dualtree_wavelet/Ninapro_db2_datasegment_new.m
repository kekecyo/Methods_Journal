clc;
%%%% Find the starting point of each sample %%%%%
for i = 1:12
    EMG(:,i) = filter(Hd_5_500, emg(:,i));
end

startPoint = diff(restimulus);
startlabel = find(startPoint ~= 0);
startIndex = [0;startlabel];

%%% Segment the EMG dsegment_emg_sub01ata and the labe

for i = 1:length(startIndex)
    if i == length(startIndex)
        %%% for the last segmentation, we need read the data and label to
        %%% the end
        segment_index{i}(:,:) = restimulus(startIndex(i)+1 : end);
        segment_emg{i}(:,:) = EMG(startIndex(i)+1 : end, :);
    else
        %%% segment the label and data from the last one +1 to the next
        segment_index{i}(:,:) = restimulus(startIndex(i)+1 : startIndex(i+1));
        segment_emg{i}(:,:) = EMG(startIndex(i)+1 : startIndex(i+1), :);
    end

end

%%tranpose the cell
segment_index = segment_index';
segment_emg = segment_emg';

clear startIndex startlabel startPoint i EMG restimulus emg


%% Sample generation based on moving window
segment_emg_all = [segment_emg_sub01; segment_emg_sub02; segment_emg_sub03;
    segment_emg_sub04; segment_emg_sub05; segment_emg_sub06; segment_emg_sub07;
    segment_emg_sub08; segment_emg_sub09; segment_emg_sub10; segment_emg_sub11;
    segment_emg_sub12; segment_emg_sub13; segment_emg_sub14; segment_emg_sub15;
    segment_emg_sub16; segment_emg_sub17; segment_emg_sub18; segment_emg_sub19;
    segment_emg_sub20; segment_emg_sub21; segment_emg_sub22; segment_emg_sub23;
    segment_emg_sub24; segment_emg_sub25; segment_emg_sub26; segment_emg_sub27;
    segment_emg_sub28; segment_emg_sub29; segment_emg_sub30; segment_emg_sub31;
    segment_emg_sub32; segment_emg_sub33; segment_emg_sub34; segment_emg_sub35;
    segment_emg_sub36; segment_emg_sub37; segment_emg_sub38; segment_emg_sub39;
    segment_emg_sub40;];

segment_index_all = [segment_index_sub01; segment_index_sub02; segment_index_sub03;
    segment_index_sub04; segment_index_sub05; segment_index_sub06; segment_index_sub07;
    segment_index_sub08; segment_index_sub09; segment_index_sub10; segment_index_sub11;
    segment_index_sub12; segment_index_sub13; segment_index_sub14; segment_index_sub15;
    segment_index_sub16; segment_index_sub17; segment_index_sub18; segment_index_sub19;
    segment_index_sub20; segment_index_sub21; segment_index_sub22; segment_index_sub23;
    segment_index_sub24; segment_index_sub25; segment_index_sub26; segment_index_sub27;
    segment_index_sub28; segment_index_sub29; segment_index_sub30; segment_index_sub31;
    segment_index_sub32; segment_index_sub33; segment_index_sub34; segment_index_sub35;
    segment_index_sub36; segment_index_sub37; segment_index_sub38; segment_index_sub39;
    segment_index_sub40;];

%%
emg_800ms_sample = []; %%%sample rate is 2000, so 200ms is a 1*400 vector
emg_800ms_index = [];

for i = 1:length(segment_emg_all)

    len = fix(length(segment_emg_all{i}(:,:))/800);

    %%% 800 point (400ms), half overlapping
    for movw = 1:len-1
        %%segment emg signal
        temp = segment_emg_all{i}(movw*400-399 : movw*400+400, :);
        emg_800ms_sample = [emg_800ms_sample; temp];

        %%segment index signal
        temp_index = segment_index_all{i}(movw*400-399 : movw*400+400, :);
        emg_800ms_index = [emg_800ms_index; temp_index];
    end
end
%%

emg_200ms_sample = []; %%%sample rate is 2000, so 200ms is a 1*400 vector
emg_200ms_index = [];

for i = 1:length(segment_index_all)
    len = fix(length(segment_index_all{i})/200);
    %%% 400 point (200ms), half overlapping
    for movw = 1:len-1
        %%segment emg signal
        temp = segment_emg_all{i}(movw*200-199 : movw*200+200);
        emg_200ms_sample = [emg_200ms_sample ; temp];
        
        %%segment index signal
        temp_index = segment_index_all{i}(movw*200-199 : movw*200+200);
        emg_200ms_index = [emg_200ms_index ; temp_index];
    end
end
 %% 
 %% Sample generation based on moving window
segment_emg_all = [emg_800ms_sample_sub01; emg_800ms_sample_sub02; emg_800ms_sample_sub03;
    emg_800ms_sample_sub04; emg_800ms_sample_sub05; emg_800ms_sample_sub06; emg_800ms_sample_sub07;
    emg_800ms_sample_sub08; emg_800ms_sample_sub09; emg_800ms_sample_sub10; emg_800ms_sample_sub11;
    emg_800ms_sample_sub12; emg_800ms_sample_sub13; emg_800ms_sample_sub14; emg_800ms_sample_sub15;
    emg_800ms_sample_sub16; emg_800ms_sample_sub17; emg_800ms_sample_sub18; emg_800ms_sample_sub19;
    emg_800ms_sample_sub20; emg_800ms_sample_sub21; emg_800ms_sample_sub22; emg_800ms_sample_sub23;
    emg_800ms_sample_sub24; emg_800ms_sample_sub25; emg_800ms_sample_sub26; emg_800ms_sample_sub27;
    emg_800ms_sample_sub28; emg_800ms_sample_sub29; emg_800ms_sample_sub30; emg_800ms_sample_sub31;
    emg_800ms_sample_sub32; emg_800ms_sample_sub33; emg_800ms_sample_sub34; emg_800ms_sample_sub35;
    emg_800ms_sample_sub36; emg_800ms_sample_sub37; emg_800ms_sample_sub38; emg_800ms_sample_sub39;
    emg_800ms_sample_sub40;];

segment_index_all = [emg_800ms_index_sub01; emg_800ms_index_sub02; emg_800ms_index_sub03;
    emg_800ms_index_sub04; emg_800ms_index_sub05; emg_800ms_index_sub06; emg_800ms_index_sub07;
    emg_800ms_index_sub08; emg_800ms_index_sub09; emg_800ms_index_sub10; emg_800ms_index_sub11;
    emg_800ms_index_sub12; emg_800ms_index_sub13; emg_800ms_index_sub14; emg_800ms_index_sub15;
    emg_800ms_index_sub16; emg_800ms_index_sub17; emg_800ms_index_sub18; emg_800ms_index_sub19;
    emg_800ms_index_sub20; emg_800ms_index_sub21; emg_800ms_index_sub22; emg_800ms_index_sub23;
    emg_800ms_index_sub24; emg_800ms_index_sub25; emg_800ms_index_sub26; emg_800ms_index_sub27;
    emg_800ms_index_sub28; emg_800ms_index_sub29; emg_800ms_index_sub30; emg_800ms_index_sub31;
    emg_800ms_index_sub32; emg_800ms_index_sub33; emg_800ms_index_sub34; emg_800ms_index_sub35;
    emg_800ms_index_sub36; emg_800ms_index_sub37; emg_800ms_index_sub38; emg_800ms_index_sub39;
    emg_800ms_index_sub40;];

segment_index_all_new = [emg_800ms_index_sub01, emg_800ms_index_sub02, emg_800ms_index_sub03,
    emg_800ms_index_sub04, emg_800ms_index_sub05, emg_800ms_index_sub06, emg_800ms_index_sub07,
    emg_800ms_index_sub08, emg_800ms_index_sub09, emg_800ms_index_sub10, emg_800ms_index_sub11,
    emg_800ms_index_sub12, emg_800ms_index_sub13, emg_800ms_index_sub14, emg_800ms_index_sub15,
    emg_800ms_index_sub16, emg_800ms_index_sub17, emg_800ms_index_sub18, emg_800ms_index_sub19,
    emg_800ms_index_sub20, emg_800ms_index_sub21, emg_800ms_index_sub22, emg_800ms_index_sub23,
    emg_800ms_index_sub24, emg_800ms_index_sub25, emg_800ms_index_sub26, emg_800ms_index_sub27,
    emg_800ms_index_sub28, emg_800ms_index_sub29, emg_800ms_index_sub30, emg_800ms_index_sub31,
    emg_800ms_index_sub32, emg_800ms_index_sub33, emg_800ms_index_sub34, emg_800ms_index_sub35,
    emg_800ms_index_sub36, emg_800ms_index_sub37, emg_800ms_index_sub38, emg_800ms_index_sub39,
    emg_800ms_index_sub40];
 %% 
aa(:,:) = segment_emg_all(find(segment_index_all > 0),:);
bb(:,:) = segment_index_all(find(segment_index_all > 0),:);
 
csvwrite('Ninapro_DB2_emg.csv',segment_emg_all);

bb(:,:) = segment_index_all(find(segment_index_all > 0),:);
csvwrite('Ninapro_DB2_emg_norest_label.csv',bb);
bbb = reshape(bb,[800,40866]);
bbbb = mean(bbb);
csvwrite('Ninapro_DB2_emg_norest_label.csv',bbbb);


%% 

