import utils

if __name__ == '__main__':
    num_doc = 52
    for i in range(26, 53):
        # parameter setting
        print(str(i) + " is processing")
        input_path = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/New_raw_30/'
        input_name = str(i) + '.csv'
        sample_rate = 256
        modelname = 'ICUNet' # or 'UNetpp' 'ICUNet'
        output_path = '/Volumes/GoogleDrive/共用雲端硬碟/CNElab_專題111_ArtifactRemoval/5.Dataset/Motor-Imagery/1/Dataset/AI_CSV/ICUNet/'
        output_name = str(i) + '.csv'


        # step1: Data preprocessing
        total_file_num = utils.preprocessing(input_path+input_name, sample_rate)

        # step2: Signal reconstruction
        utils.reconstruct(modelname, total_file_num, output_path+output_name)