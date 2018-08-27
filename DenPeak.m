function [idx,flag,rho,ord_rho]=DenPeak(data,xx);
    ND=max(max(xx(:,1:2)));
    N=size(xx,1);                  %������ܸ���
    dist=zeros(ND,ND);
    [dist]=Distance(xx);

    % ȷ�� dc   
    percent=8;                     %Data1 and Data3��8 | Data2��1
    position=round(N*percent/100); %��������  
    ord_dist=sort(xx(:,3));        % �����о���ֵ����������  
    dc=ord_dist(position);

    % ��ÿ�����ݵ�Ħ�ֵ��ʼ��Ϊ��  
    rho=zeros(1,ND); flag=zeros(1,ND);
    
    
    %k�ڽ�
    k=100;
    [threshold,kdist,tmpdist]=Threshold(data,k); %������ֵ���ڱ����Ⱥ��ͷ���Ⱥ��
    %[rho,flag]=Rho(data,dist,dc,xx,threshold);  %�Ż�ǰ
    [rho,flag]=Rho(data,dist,dc,xx,threshold);   %�Ż���

    % ������������ֵ���������ֵ�����õ����о���ֵ�е����ֵ  
    maxd=max(max(dist));   

    % rho ���������У�ordrho����ԭ���е����б��  
    [rho_sorted,ord_rho]=sort(rho,'descend');  

    % ���� rho ֵ�������ݵ�  
    delta(ord_rho(1))=-1.;  
    neighbor(ord_rho(1))=0;                      %��Ϊordrho(1)�ľֲ��ܶ�������neighbor������

    % ���� delta �� neighbor ����  
    for ii=2:ND  
       delta(ord_rho(ii))=maxd;                  %һ��ʼ��ʼ��Ϊȫ�����ֵ
       for jj=1:ii-1                             %rho����˵���ŵı�ii��ǰ�����ֻ��ii-1
         if(dist(ord_rho(ii),ord_rho(jj))<delta(ord_rho(ii)))  
            delta(ord_rho(ii))=dist(ord_rho(ii),ord_rho(jj));  
            neighbor(ord_rho(ii))=ord_rho(jj);   % ��¼ rho ֵ��������ݵ����� ordrho(ii) ��������ĵ�ı�� ordrho(jj)  
            
         end  
       end  
    end  

    % ���� rho ֵ������ݵ�� delta ֵ  
    delta(ord_rho(1))=max(delta(:));  

    % ���� rho �� delta ��������ͼ 
    subplot(1,3,1)  
    plot(rho(:),delta(:),'o'); 
    xlabel('��'); ylabel('��'); hold on
    r1=0.90*max(rho); %Data1��0.76/0.66 | Data2��0.9/0.9 | Data3��0.90/0.67
    d1=0.67*max(delta); 
    
    chosen=find(rho>r1&delta>d1);
    plot(rho(chosen),delta(chosen),'r.','MarkerSize',15)

	%����Decision Graph������ֲ�ͼ
    subplot(1,3,2)
    l=rho.*delta;
    [l_sorted,ordl]=sort(l,'descend');  
    plot((1:ND),l_sorted,'o'); 
    xlabel('n'); ylabel('��'); 
    NCLUST=0; 

    %��ʼ����꣬ȫ����ʼ��Ϊ-1
    idx=zeros(1,ND);
    for i=1:ND  
      idx(i)=-1;  
    end  
    
    %���趨�뾶֮�ڼ�������֮������ƶ�
    r=1;
    NSS_Data=NSS(data,r);
    a=NSS_Data(chosen);
    lastchosen=chosen;
    
    % ͳ�ƾ������ĵĸ���  
    for i=1:ND  
      if ( (rho(i)>r1) && (delta(i)>d1))         %������ֵ�ĵ㱻��Ϊ����
          b=NSS_Data(i);
          if(a>=b)
              tmp=a;
              a=b;
              b=tmp;
          end
          
          %���ƶȹ����������õ㣬����Ѱ�����ĵ�
          if((a/b)>=1)
              i=i+1;
          else
             NCLUST=NCLUST+1;  
             idx(i)=NCLUST; 
          end
      end  
    end  

    fprintf('Cluster Number: %i \n', NCLUST);  

    % ���������ݵ����
    for i=1:ND  
      if (idx(ord_rho(i))==-1)                       %����Ⱥ��
        idx(ord_rho(i))=idx(neighbor(ord_rho(i)));   %��ĳ����鵽�����ֲ��ܶȸ�����Ǹ������ڵ���
      end  
      
%       if (idx(ord_rho(i))==-1 && flag(i)==0)       %����Ⱥ��
%         idx(ord_rho(i))=idx(neighbor(ord_rho(i))); %��ĳ����鵽�����ֲ��ܶȸ�����Ǹ������ڵ���
%       else
%           idx(ord_rho(i))=idx(neighbor(ord_rho(i)));
%       end  
    end   

    %���ƾ�����ͼ
    subplot(1,3,3);
    x=data(:,1); y=data(:,2);

    plot(x(find(idx==1)),y(find(idx==1)),'r.','MarkerSize',12)
    hold on  
    plot(x(find(idx==2)),y(find(idx==2)),'g.','MarkerSize',12)  
    plot(x(find(idx==3)),y(find(idx==3)),'b.','MarkerSize',12) 
    plot(x(find(idx==4)),y(find(idx==4)),'y.','MarkerSize',12)  
    plot(x(find(idx==5)),y(find(idx==5)),'m.','MarkerSize',12)  
    plot(x(find(idx==6)),y(find(idx==6)),'k.','MarkerSize',12)  
    plot(x(find(idx==7)),y(find(idx==7)),'c.','MarkerSize',12)  
end
  