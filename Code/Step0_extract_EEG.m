%%
clc;clear all;close all;

% which os are you using?
% 1 for win, 2 for mac
OS = 2;

%set up the directory
sample_set_dir = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/sample';
sample_set_name ='1_ICA_DLtrain.set';

dataset_dir = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/orignal';
%data_name = 's01.mat'

save_path ='/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/concatenated/Raw_64';


num_doc = 52;
sr_rate = 512;


for i = 1:52

    if i < 10
        data_name = ['s0', int2str(i), '.mat'];
    else
        data_name = ['s', int2str(i) , '.mat'];
    end

    % load data from dataset
    if OS == 1
        data = load([dataset_dir, '\', data_name]);
    else
        data = load([dataset_dir, '/', data_name]);
    end

    % Sample rate of new data


    % 65~68 chs are emg data, which are not needed
    left = data.eeg.movement_left(1:64, :);
    right = data.eeg.movement_right(1:64, :);

    % combine two EEG signal
    conca = [left ,right];

    EEG = pop_loadset('filename', sample_set_name, 'filepath', sample_set_dir);

    EEG.data = conca;
    EEG.srate = 512;
    
    save_name = [int2str(i), '.set']
    % save concatenated result
    EEG = pop_saveset(EEG, 'filename', save_name, 'filepath', save_path);

    eeglab redraw;

end