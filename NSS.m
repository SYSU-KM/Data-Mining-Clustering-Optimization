function [NSS]=NSS(Data,r)
%��������������İ뾶֮�����е�ĺͣ����ں��ں�����������������ƶ�
%��������ΪData�Ͱ뾶
%��������͵ó��ھ����ƶ�ֵ
    [row col]=size(Data);
    
    for i=1:row
        distance=0;
        sum=0;
        cnt=0;
        for j=1:row
            distance=sqrt((Data(i,1)-Data(j,1))*(Data(i,1)-Data(j,1))+(Data(i,2)-Data(j,2))*(Data(i,2)-Data(j,2)));
            if(distance<=r)
                sum=sum+Data(j,1);
                cnt=cnt+1;
            end
        end
        NSS(i,1)=sum;
        sum=0;
    end
end