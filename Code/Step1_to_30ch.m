S%%
clc;clear all;close all;

% which os are you using?
% 1 for win, 2 for mac
OS = 1;

%set up the path

dataset_dir = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/concatenated/Raw_64'
save_path = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/New_raw_30';

% new location path
ch_loc_path = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/loc64.ced';

num_doc = 52;
sr_rate = 512;
num_doc = 52


for i = 1:num_doc
    
    data_name = [int2str(i), '.set']

    EEG = pop_loadset('filename', data_name, 'filepath', dataset_dir);
    
    % load channel location
    EEG=pop_chanedit(EEG, 'lookup', ch_loc_path, 'load',{ch_loc_path, 'filetype','autodetect'});
    
    % select 30 channels
    EEG = pop_select( EEG, 'channel',{'FP1','F3','F7','FT7','FC3','C3','T7','TP7','CP3','P3','PO7','O1','Oz','Pz','CPz','FP2','FZ','F4','F8','FT8','FC4','FCz','Cz','C4','T8','TP8','CP4','P4','PO8','O2'});
    
    % resample
    EEG = pop_resample( EEG, 256);
    
    save_name = [int2str(i), '.set']
    EEG = pop_saveset(EEG, 'filename', save_name, 'filepath', save_path);
  
    eeglab redraw;
end

