function training_data_generator_fading(K, N, E, L, block_number, min_sum, EsN0_start, EsN0_delta, EsN0_end, Kfactor, seed)
% The function use basic polar code and QPSK modulation.It save training
% data in TrainingData folder
% K is information bit number
% N is the polar code encoder input and output bit number
% E is the encoded bit number
% block_number is the training block number.
% L should be a scalar integer. It specifies the list size to use during
% Successive Cancellation List (SCL) decoding.
% min_sum should be a scalar logical. If it is true, then the SCL
% decoding process will be completed using the min-sum approximation.
% Otherwise, the log-sum-product will be used. The log-sum-product gives
% better error correction capability than the min-sum, but it has higher
% complexity.

addpath(genpath('../'))

% Default values
if nargin == 0
    K = 8;
    N = 32;
    E = 32;
    L = 8;
    block_number = 1000;
    min_sum = true;
    EsN0_start = 6;
    EsN0_delta = 0.5;
    EsN0_end = 6;
    Kfactor = 0;
    seed = 0;
end
rng(seed);
% for polar encoder and decoder
Q_N = get_3GPP_sequence_pattern(N);
[rate_matching_pattern, mode] = get_3GPP_rate_matching_pattern(K,N,E);
info_bit_pattern = get_info_bit_pattern(K, Q_N, rate_matching_pattern);

codewords=zeros(block_number,K);
decoded_bits=zeros(block_number,K);
llr=zeros(block_number,E);

for EsN0 = EsN0_start:EsN0_delta:EsN0_end
    filename_a = ['./TrainingData/a_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(seed)'];
    filename_hata = ['./TrainingData/hata_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(seed)'];
    filename_llr = ['./TrainingData/llr_K_',num2str(K),'_N_',num2str(N),'_L_',num2str(L),'_blnum_',num2str(block_number),'_',num2str(EsN0),'_',num2str(Kfactor),'_',num2str(seed)'];
    for m = 1:block_number
        N0 = 1/(10^(EsN0/10));
        % random bits
        a=round(rand(1,K));
        codewords(m,:)=a;
        % encoded bits
        f = polar_encoder(a, info_bit_pattern, rate_matching_pattern);
        f2 = [f,zeros(1,mod(-length(f),2))];
        % transmitted symbols
        tx = sqrt(1/2)*(2*f2(1:2:end)-1)+1i*sqrt(1/2)*(2*f2(2:2:end)-1);
        noise = sqrt(N0/2)*(randn(size(tx))+1i*randn(size(tx)));
        riceA = sqrt(Kfactor*2*((1/sqrt(2))^2));
        channel = (riceA +sqrt(1/2)*(randn(size(tx))+i*randn(size(tx))))/sqrt(riceA^2+1);
        y = channel.*tx + noise;
        rx = conj(channel).*y;
        cfactor = abs(channel).^2;
        f2_tilde = zeros(size(f2));
        f2_tilde(1:2:end) = -4*sqrt(1/2)*real(rx)/N0;
        f2_tilde(2:2:end) = -4*sqrt(1/2)*imag(rx)/N0;

        % consider channel factor 20190322
        f2_tilde(1:2:end) = f2_tilde(1:2:end) .* cfactor;
        f2_tilde(2:2:end) = f2_tilde(2:2:end) .* cfactor;

        f_tilde = f2_tilde(1:length(f));
        llr(m,:)=f_tilde;
        % Perform polar decoding
        a_hat = polar_decoder(f_tilde, info_bit_pattern, rate_matching_pattern, mode, L, min_sum);
        decoded_bits(m,:)=a_hat;
    end
    save(filename_a,'codewords','-ascii');
    save(filename_hata,'decoded_bits','-ascii');
    save(filename_llr,'llr','-ascii');
end
end