function  [y1 y2 R1 R2]=label(magnitude)

max_cell = max(max(magnitude));
[max_i,max_j]=find(magnitude==max_cell);    %�ҵ����ֵ�Լ����������ֵ

threshold_3db=max_cell/(10^(3/20));
threshold_20db=max_cell/(2);

[i_3db,j_3db]=find(magnitude>=threshold_3db);                        %��ֵ����3db�����е㼯�ϣ�i_3db����Щ�������ļ��ϣ�j_3db����Щ��������ļ���
[i_20db,j_20db]=find((threshold_3db>=magnitude)&(magnitude>=threshold_20db));      %��ֵ����3db��20db�����е㼯��


[width_i_3db,height_i_3db]=size(i_3db);         %width_i_3db��ʾ��ֵ����3db�ĵ�ĸ�����height_i_3db=1
%[width_j_3db,height_j_3db]=size(j_3db);        %��Ϊ������ͺ�������һһ��Ӧ�ģ���˴����������ʡȥ%width_i_3db

[width_i_20db,height_i_20db]=size(i_20db);
%[width_j_20db,height_i_20db]=size(j_20db);           %ͬ��
   

[magnitude_i,magnitude_j]=size(magnitude);    %����magnitude����(ԭ����)�Ĵ�С

y1=zeros(magnitude_i,magnitude_j);             %%%%y1�����������ֵ������3db���������ص㱻�ָ������
y2=zeros(magnitude_i,magnitude_j);             %%%%y2�����������ֵ��3db������ֵ��20db���������ص㱻�ָ������

for i=1:width_i_3db
    y1(i_3db(i,1),j_3db(i,1))=1;                  %���3db��������ģ��
end
for i=1:width_i_20db
    y2(i_20db(i,1),j_20db(i,1))=1;                 %���20db��������ģ��
end    
[y1,R1]=bwlabel(y1,8);
[y2,R2]=bwlabel(y2,8);

