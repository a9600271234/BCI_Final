%%
clc;clear all;close all;

% which os are you using?
% 1 for win, 2 for mac
OS = 1;

%set up the directory
% ICUNet
% UNet_pp

dataset_dir = 'H:\共用雲端硬碟\CNElab_專題111_ArtifactRemoval\5.Dataset\Motor-Imagery\1\Dataset\New_ICA\Raw';

% need changed
csv_dir = 'H:\共用雲端硬碟\CNElab_專題111_ArtifactRemoval\5.Dataset\Motor-Imagery\1\Dataset\AI_CSV\ICUNet'

% need changed
save_path ='H:\共用雲端硬碟\CNElab_專題111_ArtifactRemoval\5.Dataset\Motor-Imagery\1\Dataset\New_ICA\ICUNet';

num_doc = 52;

for i = 1:num_doc
    
    data_name = [int2str(i), '.set']
    EEG = pop_loadset('filename', data_name, 'filepath', dataset_dir);
    
    new_data = csvread([csv_dir '\' int2str(i) '.csv']);
    
    EEG.data = new_data;
    
    %filter
    %EEG = pop_eegfiltnew(EEG, 0.5, 50);
    
    %ASR
    %EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion','off','Highpass','off','BurstCriterion',20,'WindowCriterion','off','BurstRejection','off','Distance','Euclidian');

    % run ICA
    EEG = pop_runica(EEG, 'icatype', 'runica', 'options', {'extended', 1, 'maxsteps', 1024, 'stop', 1e-7});

    save_name = [int2str(i), '.set']
    EEG = pop_saveset(EEG, 'filename', save_name, 'filepath', save_path);
    
    eeglab redraw;

end