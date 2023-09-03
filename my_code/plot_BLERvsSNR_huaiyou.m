%plot SCL BLER vs EsN0
addpath(genpath('../'))
load('results/K_8_E_32_L_8_50_-3.mat')
figure;
semilogy(EsN0,block_error_counts./block_counts,'-*')
hold on
load('results/K_16_E_64_L_8_50_-3.mat')
semilogy(EsN0,block_error_counts./block_counts,'-s')
hold on
load('results/K_256_E_1024_L_8_50_-3.mat')
semilogy(EsN0,block_error_counts./block_counts,'-x')
legend('K=8,E=32','K=16,E=64','K=256,E=1024')
title('SCL polar code, A = 8, minsum = true, errors = 50, QPSK, rayleigh');
ylabel('BLER');
xlabel('E_s/N_0 [dB]');
grid on
