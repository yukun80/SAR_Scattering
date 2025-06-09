clear;
root = '.\SN_132'; % Specify the root path
files = dir(fullfile(root, '*.mat')); % List all .mat files
for i = 1:length(files)
    inputmat_file = fullfile(files(i).folder, files(i).name);
    output_basename = [files(i).name(1:end-4) '.015']; % e.g., R1_T1 for T1.mat
    create_R1_for_image_read(inputmat_file, ['SourceToYang\' output_basename]);
    rawname = ['SourceToYang\' output_basename '.128x128.raw'];
    [fileimage, image_value] = image_read(rawname);
%     imagesc(fileimage);
    imwrite(uint8(imadjust(fileimage)*255),['JPGofSN_132\' output_basename '_v1.JPG']); % 调整对比度后保存
    imwrite(uint8(fileimage/max(max(fileimage))*255),['JPGofSN_132\' output_basename '_v2.JPG']); % 调整对比度后保存
end


MSTAR2JPG('E:\Document\_Mission\2025\250512_三维目标散射机理研究与特征提取研究\MSTAR数据集\算法1_杨老师\datasourceProcess\testin_3334','E:\Document\_Mission\2025\250512_三维目标散射机理研究与特征提取研究\MSTAR数据集\算法1_杨老师\datasourceProcess\testout');