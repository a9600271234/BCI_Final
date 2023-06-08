clc;clear all;close all;

% total 幾筆
max_data = 47;
doc_dir = 'G:\共用雲端硬碟\CNElab_專題111_ArtifactRemoval\5.Dataset\Motor-Imagery\1\Dataset\New_ICA\UNet_PP';

log_cal_tab = zeros(max_data, 7, 8);
log_seg_tab = zeros(7, max_data);

for i=1:52
    if i == 2||i == 12||i == 13||i == 17||i == 33
        continue;
    end

    try
        filename = [int2str(i) '.set'];
        EEG = pop_loadset('filename', filename, 'filepath', doc_dir);
        eeglab redraw;
    catch
        %%continue
    end
    
    % ICA weight & ICLabel
    % class 有各個部位的%數，1~7分別為brain... others
    clear data icawinv icaact idx_label
    icaact = (EEG.icaweights*EEG.icasphere)*EEG.data; % ICA result
    icawinv.Original = EEG.icawinv;
    EEG = iclabel(EEG);
    label = strrep((EEG.etc.ic_classification.ICLabel.classes)', ' ', '');
    class = EEG.etc.ic_classification.ICLabel.classifications;
    [M, I] = max(class');
    
    % The number of ICs in different class
    % x-axis: ICs Quantity, Brain, Muscle, Eye, Heart, Line Noise, Channel Noise, Other
    % y-axis: Brain, Muscle, Eye, Heart, Line Noise, Channel Noise, Other
    % cal_table col 1=>個數
    
    cal_table = zeros(7,8);
    for j=1:30
        cal_table(I(j),1) = cal_table(I(j),1)+1;
        cal_table(I(j),2:8) = cal_table(I(j),2:8) + class(j,:);
    end
    for j=1:7
        if cal_table(j,1) ~= 0
            cal_table(j,2:8) = cal_table(j,2:8)/cal_table(j,1);
        end
    end
    log_cal_tab(i,:,:) = cal_table;
    
    % The number of EEG segments in different class
    % y-axis: Brain, B+Muscle, B+Eye, B+Heart, B+Line Noise, B+Channel Noise, B+Other
    % 各有幾個segment的合
    train_set = zeros(7,1);
    train_set(1) = train_set(1) + floor(size(EEG.times,2)/1024)
    for j=2:7
        if cal_table(j,1) ~= 0
            train_set(j) = train_set(j) + train_set(1)
        end
    end
    log_seg_tab(:,i) = train_set;
    
    
end
% Delete bad data
to_delete = [2 12 13 17 33];
log_cal_tab(to_delete, :, :) = [];
log_seg_tab(:,to_delete) = [];


% The result of EEG segment number
tot_seg_tab = zeros(7,1);
for i=1:7
    tot_seg_tab(i) = sum(log_seg_tab(i,:));
end

% The result of ICs number & probability
tot_cal_tab_mean = zeros(7,8);
tot_cal_tab_std = zeros(7,8);
for i=1:7
    tot_cal_tab_mean(i,1) = mean(log_cal_tab(:,i,1));
    tot_cal_tab_std(i,1) = std(log_cal_tab(:,i,1));
    for j=2:8
        tot_cal_tab_mean(i,j) = mean(log_cal_tab(:,i,j));
        tot_cal_tab_std(i,j) = std(log_cal_tab(:,i,j));
    end
end


% write ouput csv 

outfile = append('./step3_tot_cal_tab_mean.csv')
csvwrite(outfile, tot_cal_tab_mean);
save('log_cal_tab_mean.mat', 'tot_cal_tab_mean')

outfile = append('./step3_tot_cal_tab_std.csv')
csvwrite(outfile, tot_cal_tab_std);
save('log_cal_tab_std.mat', 'tot_cal_tab_std')

outfile = append('./total_log.csv')
csvwrite(outfile, log_cal_tab);




