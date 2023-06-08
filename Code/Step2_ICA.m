%%
clc;clear all;close all;

% which os are you using?
% 1 for win, 2 for mac
OS = 1;
%new location
new_loc = [1 4 3 8 9 14 13 18 19 24 23 28 29 25 20 2 5 6 7 12 11 10 15 16 17 22 21 26 27 30];
%set up the directory

dataset_dir = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/New_raw_30';

save_path ='/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/New_ICA/ASR';

num_doc = 52;


for i = 1:num_doc
    temp = [];
    data_name = [int2str(i), '.set']
    EEG = pop_loadset('filename', data_name, 'filepath', dataset_dir);

    for j = 1:30
        temp = [ temp ; EEG.data(new_loc(j), :) ];
    end

    EEG.data = temp;
    
    EEG=pop_chanedit(EEG, 'load',{'/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/ICUNet.ced','filetype','autodetect'});
    %filter
    EEG = pop_eegfiltnew(EEG, 0.5, 50);
    
    %ASR
    EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion','off','Highpass','off','BurstCriterion',20,'WindowCriterion','off','BurstRejection','off','Distance','Euclidian');

    % run ICA
    EEG = pop_runica(EEG, 'icatype', 'runica', 'options', {'extended', 1, 'maxsteps', 1024, 'stop', 1e-7});

    save_name = [int2str(i), '.set']
    EEG = pop_saveset(EEG, 'filename', save_name, 'filepath', save_path);
    
    eeglab redraw;

end