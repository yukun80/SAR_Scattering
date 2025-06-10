%**xulu����
% ��SourceToYang���ļ�����������ȡ��raw�����ݣ���ȡ������ɢ�����ı����ڡ�OutputofYang���ļ��У���������ɢ�������ؽ���Ӱ����Ƭ�����ڡ�ReconstructYang���ļ���
% ��������׼���õ� .raw �ļ������ú�����ȡ����( extrac )��������������ؽ���� ��
clear;
clc;
close all;

root = 'E:\Document\_Mission\2025\250512_��άĿ��ɢ������о���������ȡ�о�\MSTAR���ݼ�\�㷨1_����ʦ\datasourceProcess\Step1_SourceToYang\'; % Specify the root path
files = dir(fullfile(root, '*.raw')); % List all .raw files
outpath = 'E:\Document\_Mission\2025\250512_��άĿ��ɢ������о���������ȡ�о�\MSTAR���ݼ�\�㷨1_����ʦ\datasourceProcess\Step2_OutputofYang\';
comparepath = 'E:\Document\_Mission\2025\250512_��άĿ��ɢ������о���������ȡ�о�\MSTAR���ݼ�\�㷨1_����ʦ\datasourceProcess\Step2_ReconstructYang\';
for i = 1:length(files)
    inputraw_file = fullfile(files(i).folder, files(i).name);
    [fileimage, image_value] = image_read(inputraw_file);
    K=fileimage;
    K_complex=image_value;
    
    % % % %�㷨1��������
    scatter_all=extrac(K,K_complex);
    output_basename = [files(i).name(1:end-12) '_yang.mat'];
    save([outpath output_basename],'scatter_all');%������ȡ������ɢ������&����
        
    % % % %�㷨1����ؽ���
    % s=simulation(scatter_all);%ͼ1���ؽ�ͼ
    % diff = fileimage-s;
    % reconstru_basename = [files(i).name(1:end-12) '_yangRecon.mat'];
    % full_path = fullfile(comparepath, reconstru_basename);
    % save(full_path,'s','diff');%�����ؽ�����Ƭ
    % fclose all;
    % %��ͼ�ã������棬����ֱ�Ӵ�
    % gui_s=max(max(s));
    % fileimage= TargetDetect(fileimage,30 );
    % gui_f=max(max(fileimage));
    % s_gui=s/gui_s;
    % fileimage_gui=fileimage/gui_f;
    % C = normxcorr2(s_gui,fileimage_gui);
    % max(max(C))
    % figure,imshow(C);
    % colormap(jet);colorbar;%ͼ2
    % figure,imshow(fileimage);%ͼ3��ԭͼ
    
end

