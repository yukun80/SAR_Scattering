function image_interest=ROI(matrix_image,R);             %%%%%%%%%%%%%matrix_image��ʾ�÷�ˮ��ָ�õ���ģ�壬R��ʾ��ģ����ĳ������Ȥ����ı��
%%%%%%%%%%%%%%%�ú����о��ǽ�ģ�����ض���ǵĸ���Ȥ������ȡ����,Ȼ�󽫸�ģ���еı�Ƕ���Ϊ1��������Ƕ�Ϊ0%%%%%%%%%%%55



image_interest=matrix_image-matrix_image;
  

[x,y]=find(matrix_image==R);                        %%%%%%%%%%%�ҵ�ĳ������µ��������ص������λ�õļ���
% [x,y]=find(matrix_image~=0); 
[width,height]=size(x);                         %%%%%%%%%%%x,y�ľ����С��һ���ģ��������x��size������������y�ġ�height����1



for i=1:width
    image_interest(x(i,1),y(i,1))=1;
end

    