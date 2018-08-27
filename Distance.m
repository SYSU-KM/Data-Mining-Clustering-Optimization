function [dist]=Distance(xx)
    ND=max(xx(:,2)); NL=max(xx(:,1));  
    if (NL>ND)  
      ND=NL;      %ȷ�� DN ȡΪ��һ�������ֵ�еĽϴ��ߣ���������Ϊ���ݵ�����  
    end  
    N=size(xx,1); %xx ��һ��ά�ȵĳ��ȣ��൱���ļ�����������������ܸ�����  

    for i=1:ND  
      for j=1:ND  
        dist(i,j)=0;  
      end  
    end   
    
    for i=1:N  
      ii=xx(i,1);  
      jj=xx(i,2);  
      dist(ii,jj)=xx(i,3);  
      dist(jj,ii)=xx(i,3);  
    end
end