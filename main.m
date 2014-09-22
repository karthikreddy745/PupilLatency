clc;
clear all;
close all;
Ivi=aviread('video001.avi');
cnt=1;
flag=0;
figure;
for i=1:size(Ivi,2)
    subplot(2,1,1);
 I=Ivi(i).cdata;

 rawimg=rgb2gray(I(100:end-100,100:end-100,:));
 
 %tic;
 [accum, circen, cirrad] = pupildetection(rawimg, [25 40],5,25);
 %toc;
 
 imagesc(rawimg); colormap('gray'); axis image; hold on;
 
 if(size(cirrad,1)>0)
     m=zeros(1,size(circen,1));

 for k = 1 : size(circen, 1),
     x1=circen(k,1);
     y1=circen(k,2);
     r1=cirrad(k);
     m(k) = meanDisk(rawimg, x1, y1, r1);
     
 end
 
 if(length(m)>=1)
    [mx inx]=min(m);
    
    if((mx<55)&&(cirrad(inx)<34))
        radi(cnt)=cirrad(inx);
        cnt=cnt+1;
    else
        flag=1;
    end
 end
 
 if(flag~=1)
    plot(circen(inx,1), circen(inx,2), 'r+');
    DrawCircle(circen(inx,1), circen(inx,2), cirrad(inx), 32, 'b-');
 end
 
 flag=0;

 end;
 hold off;
 title(i);
subplot(2,1,2);
plot(radi);
 pause(1/30);
end;