%not use any more
d1 = load('results/BLER_vs_SNR_PUCCH_84_136_1_1_50_-4_0.txt');
d2 = load('results/BLER_vs_SNR_PUCCH_84_136_2_1_50_-4_0.txt');
d4 = load('results/BLER_vs_SNR_PUCCH_84_136_4_1_50_-4_0.txt');
d8 = load('results/BLER_vs_SNR_PUCCH_84_136_8_1_50_-4_0.txt');
SNR1 = unique(d1(:,1));
SNR2 = unique(d2(:,1));
SNR4 = unique(d4(:,1));
SNR8 = unique(d8(:,1));
l1 = length(SNR1);
l2 = length(SNR2);
l4 = length(SNR4);
l8 = length(SNR8);
d1plot = [];
d2plot = [];
d4plot = [];
d8plot = [];
for i = 1:l1
   temp = find(d1(:,1)==SNR1(i));
   d1plot=[d1plot;d1(temp(end),:)];
end
for i = 1:l2
   temp = find(d2(:,1)==SNR2(i));
   d2plot=[d2plot;d2(temp(end),:)];
end
for i = 1:l4
   temp = find(d4(:,1)==SNR4(i));
   d4plot=[d4plot;d4(temp(end),:)];
end
for i = 1:l8
   temp = find(d8(:,1)==SNR8(i));
   d8plot=[d8plot;d8(temp(end),:)];
end
figure;
semilogy(d1plot(:,1),d1plot(:,2),'*-')
hold on
semilogy(d2plot(:,1),d2plot(:,2),'s-')
hold on
semilogy(d4plot(:,1),d4plot(:,2),'o-')
hold on
semilogy(d8plot(:,1),d8plot(:,2),'p-')
grid on
legend('L=1','L=2','L=4','L=8')
title(' PUCCH SCL polar code, A = 84, minsum = true, errors = 50, QPSK, Rician');
ylabel('BLER');
xlabel('E_s/N_0 [dB]');
ylim([1e-2,1]);