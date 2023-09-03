% fid=fopen('FAR_PUCCH_8_1_100_0.txt')
% s=textscan(fid,'%d %d %d')
% fclose(fid)
% x=s{1}
% y=s{2}
% z=s{3}
close all;
s=load ('FAR_PUCCH_16_1_100_0.txt')
x=s(:,1)
y=s(:,2)
z=s(:,3)


figure
h1 = scatter(x(1:8),z(1:8),'o');
hold on
h11 = scatter(16,0.1250,'o','red');
hold on
h2 = scatter(x(9:43),z(9:43),'x');
hold on
h11 = scatter(32,0.0039,'x','red');
hold on
h11 = scatter(64,0.0039,'x','red');
hold on
set(gca, 'YScale', 'log')

 
xtick_vector=zeros(log2(1024)+1,1);
ytick_vector=zeros(log2(1024)+1,1);

for i=1:length(xtick_vector)
    xtick_vector(i)=2^(i-1);
    
end


xticks(xtick_vector)

% To remove some of x and y label form axis(change starting point)


xlim([0 70])

title('Fig');
    ylabel('FAR');
    xlabel('A:Information Block Length');