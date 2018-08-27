function [rho,flag]=Rho(data,dist,dc,xx,threshold)
%���ظõ���ܶȣ��Լ����Ƿ�������Ⱥ�㣬flagΪ1������������Ⱥ��
    rho=1;
    kNNdist=0; 
    ND=max(max(xx(:,1:2)));
    N=size(xx,1);      %������ܸ���
    rho=zeros(1,ND);
    flag=zeros(1,ND);
    
%�ֲ��ܶȼ��㴫ͳ����
%     for i=1:ND-1  
%       for j=i+1:ND  
%          rho(i)=rho(i)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc));  
%          rho(j)=rho(j)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc));  
%       end  
%     end 
%     
    
	%�ֲ��ܶȼ���Ľ�����
    %����ÿһ��������
    for i=1:ND
        distance=zeros(ND,1);
        for k=1:ND
            distance(k)=10000;
        end
        
        %ɨ���Ը������㿪ͷ�ľ���
        for m=1:N
            if(data(i,1)==data(xx(m,1),1)&xx(m,1)~=xx(m,2))
                distance(m)=xx(m,3);
            end
        end
        
        tmp=sort(distance,'ascend');
        k=200;%k�ڽ�
        kNNdist=tmp(k+1);
        tmprho=0;
        for n=1:k
            tmprho=tmprho+exp(-tmp(n));
        end
        
        rho(i)=tmprho;
        
        if(kNNdist>threshold)
            flag(i)=1;
        else
            flag(i)=0;
        end
    end
end