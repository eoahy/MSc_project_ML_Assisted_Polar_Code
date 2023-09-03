%not use any more
addpath(genpath('../'))
EsN0_range = 0:0.5:10;
K = 8;
N = 32;
E = 32;
L = 8;
block_number = 80000;
Kfactor = 0;
training_seed = 0;

%awgn
accuracy_awgn_1024 = load('results/fixawgn_a_accuracy_K_8_E_32_epoch_1024_blnum_8000');
accuracy_awgn_1024_1 = load('results/fixawgn_a_accuracy_K_8_E_32_epoch_1024_blnum_8000_1');
accuracy_awgn_4096 = load('results/fixawgn_a_accuracy_K_8_E_32_epoch_4096_blnum_8000');
accuracy_awgn_1024_80000 = load('results/fixawgn_a_accuracy_K_8_E_32_epoch_1024_blnum_80000');
accuracy_awgn_1024_80000_6dB = load('results/6dBawgn_a_accuracy_K_8_E_32_epoch_1024_blnum_80000');
accuracy_SCL8 = zeros(1,length(EsN0_range));
for EsN0 = EsN0_range
    training_a_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_a_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
    training_hata_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/awgn_hata_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
    a = load(training_a_filename,'-ascii');
    hata = load(training_hata_filename,'-ascii');
    [m,n] = size(a);
    accuracy_SCL8(2*EsN0+1) = length(find(hata-a==0))/(m*n);
end
figure;
semilogy(EsN0_range,1-accuracy_awgn_1024,'-*')
hold on
semilogy(EsN0_range,1-accuracy_awgn_1024_1,'-p')
hold on
semilogy(EsN0_range,1-accuracy_awgn_4096,'-x')
hold on
semilogy(EsN0_range,1-accuracy_awgn_1024_80000,'-d')
hold on
semilogy(EsN0_range,1-accuracy_awgn_1024_80000_6dB,'-s')
hold on
semilogy(EsN0_range,1-accuracy_SCL8,'-s')
legend('DL,epochs=1024,256-128-64,8000 training block','DL,epochs=1024,512-256-128-64,8000 training block','DL,epochs=4096,256-128-64,8000 training block','DL,epochs=1024,256-128-64,80000 training block','6dB,DL,epochs=1024,256-128-64,80000 training block','SCL,L=8')
title('K=8,E=32,basic polar code, QPSK, AWGN, deep learning decoder vs SCL decoder');
ylabel('BER');
xlabel('E_s/N_0 [dB]');
xlim([0,9])
grid on

%fading
accuracy_fading_1024 = load('results/fix_a_accuracy_K_8_E_32_epoch_1024_blnum_8000');
accuracy_fading_1024_80000 = load('results/fix_a_accuracy_K_8_E_32_epoch_1024_blnum_80000');
accuracy_fading_4096 = load('results/fix_a_accuracy_K_8_E_32_epoch_4096_blnum_8000');
accuracy_SCL8 = zeros(1,length(EsN0_range));
for EsN0 = EsN0_range
    training_a_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/a_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
    training_hata_filename = ['/Users/eoahy/Matlabfile/polar_codes_matlab_fading/TrainingData/hata_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(training_seed)];
    a = load(training_a_filename,'-ascii');
    hata = load(training_hata_filename,'-ascii');
    [m,n] = size(a);
    accuracy_SCL8(2*EsN0+1) = length(find(hata-a==0))/(m*n);
end
figure;
semilogy(EsN0_range,1-accuracy_fading_1024,'-*')
hold on
semilogy(EsN0_range,1-accuracy_fading_4096,'-x')
hold on
semilogy(EsN0_range,1-accuracy_fading_1024_80000,'-p')
hold on
semilogy(EsN0_range,1-accuracy_SCL8,'-s')
legend('DL,epochs=1024,256-128-64,8000 training block','DL,epochs=4096,256-128-64,8000 training block','DL,epochs=1024,256-128-64,80000 training block','SCL,L=8','Location','best')
title('K=8,E=32,basic polar code, QPSK, Rayleigh, deep learning decoder vs SCL decoder');
ylabel('BER');
xlabel('E_s/N_0 [dB]');
xlim([0,9])
grid on
