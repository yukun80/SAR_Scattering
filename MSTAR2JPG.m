%��ȡԭʼ MSTAR �����ļ�����ȡͼ��ߴ硢Ŀ�귽λ��(TargetAz)�Լ�����(Img)����λ���ݡ�Ȼ����Щ��Ϣ���浽һ�� .mat �ļ� �С�
function MSTAR2JPG(sourcePath, targetPath)
if ~exist(targetPath,'dir')
    mkdir(targetPath);
end
Files = dir(sourcePath);
for i = 1:length(Files)
    if Files(i).isdir == 0
        FID = fopen([sourcePath '\' Files(i).name],'rb','ieee-be');
        while ~feof(FID)                                % ��PhoenixHeader�ҵ�ͼƬ�ߴ��С
            Text = fgetl(FID);
            if ~isempty(strfind(Text,'NumberOfColumns'))
                ImgColumns = str2double(Text(18:end));
                Text = fgetl(FID);
                ImgRows = str2double(Text(15:end));
                
            end            
            if ~isempty(strfind(Text,'TargetAz'))
                TargetAz = str2double(Text(10:end));
                break;
            end
        end
        while ~feof(FID)                                 % ����PhoenixHeader
            Text = fgetl(FID);
            if ~isempty(strfind(Text,'[EndofPhoenixHeader]'))
                break
            end
        end
        %         Mag = fread(FID,2*ImgColumns*ImgRows,'float32','ieee-be');
        %         Img = reshape(Mag(1:ImgColumns*ImgRows),[ImgColumns ImgRows]);
        %         imwrite(uint8(imadjust(Img)*255),[SavePath FileName(1:NameLength-3) 'jpg']); % �����ԱȶȺ󱣴�
        %         phase = reshape(Mag(ImgColumns*ImgRows+1:end),[ImgColumns ImgRows]);
        %         imwrite(uint8(imadjust(phase)*255),[SavePath 'phase' FileName(1:NameLength-3) 'jpg']); % �����ԱȶȺ󱣴�
        %         fclose(FID);
        
        Mag = fread(FID,2*ImgColumns*ImgRows,'float32','ieee-be');
        Img = reshape(Mag(1:ImgColumns*ImgRows),[ImgColumns ImgRows]);
        phase = reshape(Mag(ImgColumns*ImgRows+1:end),[ImgColumns ImgRows]);
%         b=max(max(Img))
%         a=min(min(Img))
        imagesc(Img)
        
        %                 imwrite(uint8(imadjust(Img)*255),[targetPath '\' Files(i).name(1:end-3) 'JPG']); % �����ԱȶȺ󱣴�
        %                 imwrite(uint8(Img/max(max(Img))*255),[targetPath '\' Files(i).name(1:end-3) 'JPG']); % �����ԱȶȺ󱣴�
        save([targetPath '\' Files(i).name(1:end) '.mat'],'Img','phase','TargetAz');
        %              imwrite(Img,[targetPath '\' Files(i).name(1:end-3) 'tiff']); % �����ԱȶȺ󱣴�
        clear ImgColumns ImgRows
        fclose(FID);
    else
        if strcmp(Files(i).name,'.') ~= 1 && strcmp(Files(i).name,'..') ~= 1
            if ~exist([targetPath '\' Files(i).name],'dir')
                mkdir([targetPath '\' Files(i).name]);
            end
            MSTAR2JPG([sourcePath '\' Files(i).name],[targetPath '\' Files(i).name]);
        end
    end
end
end