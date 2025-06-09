clc;clear
sourcePath = '.\testin_3334'; 
targetPath = 'G:\testout_3334';
fileList = dir(sourcePath);  % 获取文件夹下所有内容

% 过滤掉.和..文件夹
files = fileList(~ismember({fileList.name}, {'.', '..'}));

% 遍历所有文件
for i = 1:length(files)
    orgin = [ sourcePath files(i).name];
    target = [targetPath files(i).name '.mat'];   
    MSTAR2JPG(sourcePath, targetPath);
end
