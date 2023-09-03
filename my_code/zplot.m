% plot the result in section 4.2.2
EsN0_range = 0:0.5:10;

r_10000_1024_awgn_a = load('./results/fixawgn_a_accuracy_epoch_1024_blnum_10000');
r_50000_1024_awgn_a = load('./results/fixawgn_a_accuracy_epoch_1024_blnum_50000');
r_100000_1024_awgn_a = load('./results/fixawgn_a_accuracy_epoch_1024_blnum_100000');
r_200000_1024_awgn_a = load('./results/fixawgn_a_accuracy_epoch_1024_blnum_200000');

r_10000_1024_awgn_hata = load('./results/fixawgn_hata_accuracy_epoch_1024_blnum_10000');
r_50000_1024_awgn_hata = load('./results/fixawgn_hata_accuracy_epoch_1024_blnum_50000');
r_100000_1024_awgn_hata = load('./results/fixawgn_hata_accuracy_epoch_1024_blnum_100000');
r_200000_1024_awgn_hata = load('./results/fixawgn_hata_accuracy_epoch_1024_blnum_200000');

figure;
semilogy(EsN0_range,1-r_10000_1024_awgn_hata,'-b+')
hold on
%semilogy(EsN0_range,1-r_10000_1024_awgn_a,'--k+')
%hold on
semilogy(EsN0_range,1-r_50000_1024_awgn_hata,'-bo')
hold on
%semilogy(EsN0_range,1-r_50000_1024_awgn_a,'--ko')
%hold on
semilogy(EsN0_range,1-r_100000_1024_awgn_hata,'-bd')
hold on
%semilogy(EsN0_range,1-r_100000_1024_awgn_a,'--kd')
%hold on
semilogy(EsN0_range,1-r_200000_1024_awgn_hata,'-bs')
hold on
%semilogy(EsN0_range,1-r_200000_1024_awgn_a,'--ks')
%hold on

load('/Users/eoahy/iridis_only/awgn_SCL_K_8_E_32_L_1_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-r*')
hold on
load('/Users/eoahy/iridis_only/awgn_SCL_K_8_E_32_L_2_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-k^')
%hold on
%load('/Users/eoahy/iridis_only/awgn_SCL_K_8_E_32_L_4_75_-5.mat')
%semilogy(EsN0,error_counts./(block_counts*8),'-p')
%hold on
%load('/Users/eoahy/iridis_only/awgn_SCL_K_8_E_32_L_8_75_-5.mat')
%semilogy(EsN0,error_counts./(block_counts*8),'-<')
%hold on
legend('DL,epochs=1024,256-128-64,10000 training block','DL,epochs=1024,256-128-64,50000 training block','DL,epochs=1024,256-128-64,100000 training block','DL,epochs=1024,256-128-64,200000 training block','SCL,L=1','SCL,L=2')
title('K=8,E=32,basic polar code, QPSK, AWGN, deep learning decoder vs SCL decoder');
ylabel('BER');
xlabel('E_s/N_0 [dB]');
grid on
xlim([0,10])

figure;
semilogy(EsN0_range,1-r_10000_1024_awgn_a,'--b+')
hold on
semilogy(EsN0_range,1-r_50000_1024_awgn_a,'--bo')
hold on
semilogy(EsN0_range,1-r_100000_1024_awgn_a,'--bd')
hold on
semilogy(EsN0_range,1-r_200000_1024_awgn_a,'--bs')
hold on
load('/Users/eoahy/iridis_only/awgn_SCL_K_8_E_32_L_1_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-r*')
hold on
load('/Users/eoahy/iridis_only/awgn_SCL_K_8_E_32_L_2_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-k^')
legend('DL,epochs=1024,256-128-64,10000 training block','DL,epochs=1024,256-128-64,50000 training block','DL,epochs=1024,256-128-64,100000 training block','DL,epochs=1024,256-128-64,200000 training block','SCL,L=1','SCL,L=2')
title('K=8,E=32,basic polar code, QPSK, AWGN, deep learning decoder vs SCL decoder');
ylabel('BER');
xlabel('E_s/N_0 [dB]');
grid on
xlim([0,10])




r_10000_1024_fading_a = load('./results/fix_a_accuracy_epoch_1024_blnum_10000');
r_50000_1024_fading_a = load('./results/fix_a_accuracy_epoch_1024_blnum_50000');
r_100000_1024_fading_a = load('./results/fix_a_accuracy_epoch_1024_blnum_100000');
r_200000_1024_fading_a = load('./results/fix_a_accuracy_epoch_1024_blnum_200000');

r_10000_1024_fading_hata = load('./results/fix_hata_accuracy_epoch_1024_blnum_10000');
r_50000_1024_fading_hata = load('./results/fix_hata_accuracy_epoch_1024_blnum_50000');
r_100000_1024_fading_hata = load('./results/fix_hata_accuracy_epoch_1024_blnum_100000');
r_200000_1024_fading_hata = load('./results/fix_hata_accuracy_epoch_1024_blnum_200000');

figure;
semilogy(EsN0_range,1-r_10000_1024_fading_hata,'-b+')
hold on
%semilogy(EsN0_range,1-r_10000_1024_fading_a,'--k+')
%hold on
semilogy(EsN0_range,1-r_50000_1024_fading_hata,'-bo')
hold on
%semilogy(EsN0_range,1-r_50000_1024_fading_a,'--ko')
%hold on
semilogy(EsN0_range,1-r_100000_1024_fading_hata,'-bd')
hold on
%semilogy(EsN0_range,1-r_100000_1024_fading_a,'--kd')
%hold on
semilogy(EsN0_range,1-r_200000_1024_fading_hata,'-bs')
hold on
%semilogy(EsN0_range,1-r_200000_1024_fading_a,'--ks')
%hold on

load('/Users/eoahy/iridis_only/fading_SCL_K_8_E_32_L_1_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-r*')
hold on
load('/Users/eoahy/iridis_only/fading_SCL_K_8_E_32_L_2_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-k^')
%hold on
%load('/Users/eoahy/iridis_only/fading_SCL_K_8_E_32_L_4_75_-5.mat')
%semilogy(EsN0,error_counts./(block_counts*8),'-p')
%hold on
%load('/Users/eoahy/iridis_only/fading_SCL_K_8_E_32_L_8_75_-5.mat')
%semilogy(EsN0,error_counts./(block_counts*8),'-<')
%hold on
legend('DL,epochs=1024,256-128-64,10000 training block','DL,epochs=1024,256-128-64,50000 training block','DL,epochs=1024,256-128-64,100000 training block','DL,epochs=1024,256-128-64,200000 training block','SCL,L=1','SCL,L=2','Location','southwest')
title('K=8,E=32,basic polar code, QPSK, Rayleigh, deep learning decoder vs SCL decoder');
ylabel('BER');
xlabel('E_s/N_0 [dB]');
grid on
xlim([0,9])

figure;
semilogy(EsN0_range,1-r_10000_1024_fading_a,'--b+')
hold on
semilogy(EsN0_range,1-r_50000_1024_fading_a,'--bo')
hold on
semilogy(EsN0_range,1-r_100000_1024_fading_a,'--bd')
hold on
semilogy(EsN0_range,1-r_200000_1024_fading_a,'--bs')
hold on
load('/Users/eoahy/iridis_only/fading_SCL_K_8_E_32_L_1_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-r*')
hold on
load('/Users/eoahy/iridis_only/fading_SCL_K_8_E_32_L_2_75_-5.mat')
semilogy(EsN0,error_counts./(block_counts*8),'-k^')
legend('DL,epochs=1024,256-128-64,10000 training block','DL,epochs=1024,256-128-64,50000 training block','DL,epochs=1024,256-128-64,100000 training block','DL,epochs=1024,256-128-64,200000 training block','SCL,L=1','SCL,L=2','Location','southwest')
title('K=8,E=32,basic polar code, QPSK, Rayleigh, deep learning decoder vs SCL decoder');
ylabel('BER');
xlabel('E_s/N_0 [dB]');
grid on
xlim([0,9])