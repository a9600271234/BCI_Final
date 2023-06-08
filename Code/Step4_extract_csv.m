clc;
clear all;
close all;

% change to your path
doc_dir = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/New_raw_30';
num_doc = 52;

for i = 1:num_doc
    filename = [int2str(i), '.set'];
    EEG = pop_loadset('filename', filename, 'filepath', doc_dir);
    outfile = [doc_dir, '/', int2str(i),'.csv'];
    csvwrite(outfile, EEG.data);
end