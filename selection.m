function  [type,temp_coordinate]=selection(segmented_image);

%%%%%%%%ȷ��ɢ���������ͺ�ģ�ͽ״�%%%%%%%%%%%%%%
%%%%%%%%������һ��ROI���ͼ�񣬼�ֻ�б��Ϊ�ض���ֵ��ͼ��λ���з���ֵ������λ�÷���ֵΪ�㣻�������ɢ�����ĵ����ͺ�ģ�ͽ״�%%%%%%%

[image_x,image_y]=size(segmented_image);

[x,y]=find(segmented_image~=0);   %%%%%�ҵ�ģ���в�Ϊ�����Щ����λ��

size_thresh=2;
size_x=size(x);
size_segmented=size_x(1,1);
if size_segmented<=size_thresh
   type=-1;
   temp_coordinate=[];
else

x_min=min(x);                     %%%%%%%�ҵ������е���Щ��ֵ
x_max=max(x);
y_min=min(y);
y_max=max(y);

[x_size,temp]=size(x);           %%%%%%%%%%x_size�ǲ�Ϊ������ĸ�����temp����1

%%%%%%%%%%%%%%%����������ù�ʽ�Ĺ���%%%%%%%%%%%%%%%%%%
Cx_temp=0;                      
Cy_temp=0;
C_temp=0;

for i=1:x_size
    x_v=x(i)-x_min+1;
    y_v=y(i)-y_min+1;
    Cx_temp=x_v*segmented_image(x(i),y(i))+Cx_temp;
    Cy_temp=y_v*segmented_image(x(i),y(i))+Cy_temp;
    C_temp=segmented_image(x(i),y(i))+C_temp;
end

Cx=Cx_temp/C_temp;
Cy=Cy_temp/C_temp;

I_x=0;
I_y=0;
for i=1:x_size
    x_v=x(i)-x_min+1;
    y_v=y(i)-y_min+1;
    I_x=((x_v-Cx)^2)*segmented_image(x(i),y(i))+I_x;
    I_y=((y_v-Cy)^2)*segmented_image(x(i),y(i))+I_y;
end 
k=I_x/I_y;
% mesh(segmented_image);

%%%%%%%%%%%%%%%%%%%����������õ���kֵ���жϸ������а������Ƿֲ�ɢ�����Ļ��Ǿֲ�ɢ�����ģ�����Ǿֲ�ɢ���������һ���жϸ������о�
%%%%%%%%%%%%%%%%%%%��ɢ�����ĵĸ��������⻹Ҫȷ���ֲ�ɢ�����ĺ;ֲ�ɢ�����ĵ�����λ�á�

temp_coordinate=zeros(x_size,2);
s=1;
number=0;         




   plate=zeros(3,3);
   for i=1:x_size
       plate(1,1)= segmented_image(x(i)-1,y(i)-1);
       plate(1,2)= segmented_image(x(i)-1,y(i));
       plate(1,3)= segmented_image(x(i)-1,y(i)+1);
       plate(2,1)= segmented_image(x(i),y(i)-1);
       plate(2,2)= segmented_image(x(i),y(i));
       plate(2,3)= segmented_image(x(i),y(i)+1);
       plate(3,1)= segmented_image(x(i)+1,y(i)-1);
       plate(3,2)= segmented_image(x(i)+1,y(i));
       plate(3,3)= segmented_image(x(i)+1,y(i)+1);
    
       if plate(2,2)==max(max(plate))
           number=number+1;
           temp_coordinate(s,1)=x(i);
           temp_coordinate(s,2)=y(i);
           s=s+1;
       end
        
   end



 if number<=1
     if k<3
        type=1;
     end
     
     if k>=3
        type=0;
     end
     
     temp_coordinate(1,1)=Cx+x_min-1;
     temp_coordinate(1,2)=Cy+y_min-1;  
 end
 
 if number==2
     if k<=1.5
         type=2;
     end
     if k>1.5
         if abs(temp_coordinate(1,2)-temp_coordinate(2,2))<2
             type=0;
             temp_coordinate=zeros(1,2);
             temp_coordinate(1,1)=Cx+x_min-1;
             temp_coordinate(1,2)=Cy+y_min-1;  
         else
             type=2;
         end
     end
 end
 
if number>2
   type=number; 
end                                                          %%%%%%%%%%%%%%��typeΪ0ʱ����ʾ�ֲ�ɢ�����ģ�
                                                             %%%%%%%%%%%%%%��typeΪ1ʱ����ʾ�ֲ�ɢ������;
      type_order=type;                                                          %%%%%%%%%%%%%%��type����1ʱ��Ѱ�Ҹ������е���ǿɢ�������ȴ���


if type>1
    
   
   if k>1.5
      max_pix=max(max(segmented_image));
      [max_coor(1),max_coor(2)]=find(max_pix==segmented_image);
      for i=1:type_order
          if (temp_coordinate(i,1)~=max_coor(1,1)) | (temp_coordinate(i,1)~=max_coor(1,2)) 
              if abs(max_coor(1,2)-temp_coordinate(2,2))<2
                  type=0;
                  
                  temp_image=zeros(image_x,image_y);
                  
                  temp_xmin=min(max_coor(1,1),temp_coordinate(2,1));
                  temp_xmax=max(max_coor(1,1),temp_coordinate(2,1));
                  temp_ymin=min(max_coor(1,2),temp_coordinate(2,2));
                  temp_ymax=max(max_coor(1,2),temp_coordinate(2,2));
                  
                  temp_image((temp_xmin-1):(temp_xmax+1),(temp_ymin-1):(temp_ymax+1))=1;
                  segmented_image=segmented_image.*temp_image;           %%%%%%�������ֲ�ɢ��������һ����
                  [x,y]=find(segmented_image~=0);                        %%%%%�ҵ�ģ���в�Ϊ�����Щ����λ��

                  size_x=size(x);
                  size_segmented=size_x(1,1);
                  if size_segmented<=size_thresh
                     type=-1;
                  else

                  x_min=min(x);                                         %%%%%%%�ҵ������е���Щ��ֵ
                  x_max=max(x);
                  y_min=min(y);
                  y_max=max(y);

                  [x_size,temp]=size(x);                                %%%%%%%%%%x_size�ǲ�Ϊ������ĸ�����temp����1

                                                                        %%%%%%%%%%%%%%%����������ù�ʽ�Ĺ���%%%%%%%%%%%%%%%%%%
                  Cx_temp=0;                      
                  Cy_temp=0;
                  C_temp=0;

                  for i=1:x_size
                      x_v=x(i)-x_min+1;
                      y_v=y(i)-y_min+1;
                      Cx_temp=x_v*segmented_image(x(i),y(i))+Cx_temp;
                      Cy_temp=y_v*segmented_image(x(i),y(i))+Cy_temp;
                      C_temp=segmented_image(x(i),y(i))+C_temp;
                  end

                  Cx=Cx_temp/C_temp;
                  Cy=Cy_temp/C_temp;
                 
                  temp_coordinate=zeros(1,2);
                  temp_coordinate(1,1)=Cx+x_min-1;
                  temp_coordinate(1,2)=Cy+y_min-1;  
                  break;
                  end
              end
          end
      end
                  
                  
                  if type>1
                      sum=[0,0];
                      
       
                      for i=1:type
                          average=temp_coordinate(i,:)+sum;
                          sum=average;
                      end
      
                      x_average=average(1,1)/type;
                      y_average=average(1,2)/type;
      
                      cor_now=temp_coordinate(1,:);
                      piancha=abs(x_average-temp_coordinate(1,1));
      
                      for i=2:type
                          temp_piancha=abs(x_average-temp_coordinate(i,1));
                          if temp_piancha>piancha
                             cor_now=temp_coordinate(i,:);
                          end
                      end                                                            %%%%%%%%%%%%%%%%�ҵ����з�ֵ���ؾ�����λ����ƽ��ֵƫ�������Ǹ���ֵ����Ϊ�ֲ�ɢ�����Ĵ���
      
                      temp_coordinate=zeros(1,1);
                      temp_coordinate=cor_now;
       
                      type=1;
                      temp_image=zeros(image_x,image_y);
                      
                      temp_xmin=(temp_coordinate(1,1)-1);
                      temp_xmax=(temp_coordinate(1,1)+1);
                      temp_ymin=(temp_coordinate(1,2)-1);
                      temp_ymax=(temp_coordinate(1,2)+1);
                      temp_image(temp_xmin:temp_xmax,temp_ymin:temp_ymax)=1;
                      
                      segmented_image=segmented_image.*temp_image;    %%%%%%%�������ֲ�ɢ�����ĵ���һ����
       
                      [x,y]=find(segmented_image~=0);                        %%%%%�ҵ�ģ���в�Ϊ�����Щ����λ��

                       size_x=size(x);
                       size_segmented=size_x(1,1);
                       if size_segmented<=size_thresh
                          type=-1;
                       else

                           x_min=min(x);                                         %%%%%%%�ҵ������е���Щ��ֵ
                           x_max=max(x);
                           y_min=min(y);
                           y_max=max(y);

                           [x_size,temp]=size(x);                                %%%%%%%%%%x_size�ǲ�Ϊ������ĸ�����temp����1

                                                                        %%%%%%%%%%%%%%%����������ù�ʽ�Ĺ���%%%%%%%%%%%%%%%%%%
                           Cx_temp=0;                      
                           Cy_temp=0;
                           C_temp=0;

                           for i=1:x_size
                               x_v=x(i)-x_min+1;
                               y_v=y(i)-y_min+1;
                               Cx_temp=x_v*segmented_image(x(i),y(i))+Cx_temp;
                               Cy_temp=y_v*segmented_image(x(i),y(i))+Cy_temp;
                               C_temp=segmented_image(x(i),y(i))+C_temp;
                           end

                           Cx=Cx_temp/C_temp;
                           Cy=Cy_temp/C_temp;
                 
                          temp_coordinate=zeros(1,2);
                          temp_coordinate(1,1)=Cx+x_min-1;
                          temp_coordinate(1,2)=Cy+y_min-1;  
                   
                       end
                  end
             end




   if k<=1.5
      
       sum=[0,0];
       
      for i=1:type
           average=temp_coordinate(i,:)+sum;
           sum=average;
      end
      
      x_average=average(1,1)/type;
      y_average=average(1,2)/type;
      
      cor_now=temp_coordinate(1,:)
      piancha=abs(x_average-temp_coordinate(1,1));
      
      for i=2:type_order
          temp_piancha=abs(x_average-temp_coordinate(i,1));
          if temp_piancha>piancha
              cor_now=temp_coordinate(i,:);
          end
      end                                                            %%%%%%%%%%%%%%%%�ҵ����з�ֵ���ؾ�����λ����ƽ��ֵƫ�������Ǹ���ֵ����Ϊ�ֲ�ɢ�����Ĵ���
      
       temp_coordinate=zeros(1,1)
       temp_coordinate=cor_now;
       
       type=1;
       temp_image=zeros(image_x,image_y);
       
       
       temp_xmin=(temp_coordinate(1,1)-1);
       temp_xmax=(temp_coordinate(1,1)+1);
       temp_ymin=(temp_coordinate(1,2)-1);
       temp_ymax=(temp_coordinate(1,2)+1);
       temp_image(temp_xmin:temp_xmax,temp_ymin:temp_ymax)=1;
       
       segmented_image=segmented_image.*temp_image;    %%%%%%%�������ֲ�ɢ�����ĵ���һ����
       
       [x,y]=find(segmented_image~=0);                        %%%%%�ҵ�ģ���в�Ϊ�����Щ����λ��

                  size_x=size(x);
                  size_segmented=size_x(1,1);
                  if size_segmented<=size_thresh
                     type=-1;
                  else

                      x_min=min(x);                                         %%%%%%%�ҵ������е���Щ��ֵ
                      x_max=max(x);
                      y_min=min(y);
                      y_max=max(y);

                     [x_size,temp]=size(x);                                %%%%%%%%%%x_size�ǲ�Ϊ������ĸ�����temp����1

                                                                        %%%%%%%%%%%%%%%����������ù�ʽ�Ĺ���%%%%%%%%%%%%%%%%%%
                     Cx_temp=0;                      
                     Cy_temp=0;
                     C_temp=0;

                      for i=1:x_size
                          x_v=x(i)-x_min+1;
                          y_v=y(i)-y_min+1;
                          Cx_temp=x_v*segmented_image(x(i),y(i))+Cx_temp;
                          Cy_temp=y_v*segmented_image(x(i),y(i))+Cy_temp;
                          C_temp=segmented_image(x(i),y(i))+C_temp;
                      end

                      Cx=Cx_temp/C_temp;
                      Cy=Cy_temp/C_temp;
                 
                      temp_coordinate=zeros(1,2);
                      temp_coordinate(1,1)=Cx+x_min-1;
                      temp_coordinate(1,2)=Cy+y_min-1;  
                  end
        end
   end
end