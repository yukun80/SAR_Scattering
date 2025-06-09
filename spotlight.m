function [Z,s]=spotlight(fc,B,om,x,y,a,r,o_o,L,A); %%%%%%%%%fc������Ƶ�ʣ�B�Ǵ���om�ǹ۲��
 %%%%%%%%%%%%%%���ø�����ģ�ͺ͹��ƵĲ�������,���õ�ģ����ֱ��Ƶ�����µ�ģ�͡������Ƶ��Ӵ�����֮��ľ���%%%%%%%%%%%%%

 om=om*2*pi/360;         %%%%%%%%%%%%%%���ǶȻ�Ϊ����
 b=B/fc;
 fx1=(1-b/2)*fc;
 fx2=(1+b/2)*fc;
 fy1=-fc*sin(om/2);
 fy2=fc*sin(om/2);      %%%%%%%%%%%%%%ֱ������ϵ�������ȡֵ��Χ
 
 p=84;
 q=128;


 
  
 K=zeros(1,p*p);
 i=1;
 s=0;
 for fx=fx1:B/(p-1):fx2
     for fy=fy1:((2*fc*sin(om/2))/(p-1)):fy2
         K(1,i)=model_rightangle(om,fx,fy,fc,x,y,a,r,o_o,L,A);
         s=abs((K(1,i))^2)+s;
         i=i+1;
     end
 end
 s=s/(p*p);      %%%%%%s������
       
 K=reshape(K,p,p);
 K=flipud(K);       %%%%%%%%%%%%%%%%%%%%�õ�ֱ������ϵ�µľ���
 
T=taylorwin(p,3,-35);   



    for j=1:p
        K(:,j)=K(:,j).*T;
    end



    for j=1:p
        K(j,:)=K(j,:).*T';
    end

 %%%%%%%%%%��̩�մ�
 

Z=zeros(q,q);
Z(1:p,1:p)=K;

 
% Z=ifft2(Z);
% Z=ifftshift(Z);
% Z=abs(Z);
% imshow(Z);
% xlabel('������');
% ylabel('��λ��');





%%%%%%%%%%%%%%���㲢����


%m=fx1:B/(p-1):fx2;
%n=fy1:((2*fc*sin(om/2))/(p-1)):fy2;
%figure(2),mesh(m,n,Z);
%xlabel('fx');
%ylabel('fy');
%zlabel('E(fx,fy)');

 