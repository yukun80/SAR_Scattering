function [fileimage image_value] = image_read(image_file)
%��ȡ�����ļ��е�������Ϣ
%image_fileΪҪ��ȡ�������ļ�����(��ʽ�̶�) ����:'hb03333.015.128x128.raw'
%
image_filename_inver = fliplr(image_file);
index_dot = findstr(fliplr(image_file),'.');
if (size(index_dot) < 2)
    disp('file can not open')
    return;
end
image_Nsize = fliplr(image_filename_inver((index_dot(1) + 1):(index_dot(2) - 1)));
index_multi = findstr(image_Nsize, 'x');
image_width = str2num(image_Nsize(1: (index_multi(1) - 1)));
image_heigh =  str2num(image_Nsize((index_multi(1) + 1):end));

%��ȡ�����ļ� ����magnitude  ��λphase
[f_id,message] = fopen(image_file, 'r', 's');%ע���ʱ���ļ���ʽieee��ʽ��
if(f_id == -1)
    errordlg(message)
    return;
end
image = linspace(0,0,image_width*image_heigh*2);
[image, count_cell] = fread(f_id,image_width*image_heigh*2,'float');
fclose(f_id);
magnitude =  image(1:count_cell/2) ;%ǿ��,����Ϊcount_cell/2��
%magnitude = reshape(magnitude,image_width,image_heigh );
%imshow(magnitude)
phase = image(count_cell/2 + 1 : end);%��λ,����Ϊcount_cell/2��

%ͼ����ʾ
%min_cell = min(magnitude)
%max_cell = max(magnitude)
%b = magnitude(1:10)
real = zeros(1,image_width*image_heigh);% ʵ��real
imag = zeros(1,image_width*image_heigh);% �鲿 imag
image_magnitude = zeros(1,image_width*image_heigh);%ǿ��
image_value = zeros(1,image_width*image_heigh);%����ֵ ��Ÿ���.
for i = 1:(image_width*image_heigh);%ѭ���еõ�ÿ������ֵ
    temp_mag = magnitude(i);
    temp_phs = phase(i);
    real = temp_mag * cos( phase(i) );
    imag = temp_mag*sin( phase(i) );
%image_magnitude(i)  = log10(real*real + imag*imag);
 image_magnitude(i)  = sqrt(real*real + imag*imag);
 image_value(i) = real + sqrt(-1)* imag;
end
%image_magnitude, image_value, image_head
fileimage = reshape(image_magnitude, image_width, image_heigh);%ͼ��ǿ�� fileimage 128*128
%fileimage = reshape(log(image_magnitude + 0.001), image_width, image_heigh);
image_value = reshape(image_value, image_width, image_heigh);%����ͼ�� image_value 128*128




