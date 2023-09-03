addpath(genpath('../'))
%   information bits number
K=8;
%   number of input and output bits
N=32;
%   encoded bits number
E=32;
%   Q_N will be a row vector comprising N number of unique integers in the
%   range 1 to N. Each successive element of Q_N provides the index of the
%   next most reliable input to the polar encoder kernal, where the first
%   element of Q_N gives the index of the least reliable bit and the last
%   element gives the index of the most reliable bit.
Q_N = get_3GPP_sequence_pattern(N);
[rate_matching_pattern, mode] = get_3GPP_rate_matching_pattern(K,N,E);
info_bit_pattern = get_info_bit_pattern(K, Q_N, rate_matching_pattern);
Kfactor=0;
L=8;
min_sum=1;
seed = 1;

% number of block
block_number = 300000;

codewords=zeros(block_number,K);
decoded_bits=zeros(block_number,K);
llr=zeros(block_number,E);
rng(seed);
for m=1:block_number
    EsN0 = 10*randn;
    N0 = 1/(10^(EsN0/10));
    a=round(rand(1,K));
    %a=de2bi(m-1,K);
    codewords(m,:)=a;
    f = polar_encoder(a, info_bit_pattern, rate_matching_pattern);
    f2 = [f,zeros(1,mod(-length(f),2))];
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
save(['./PredictingData/a',num2str(K),'_',num2str(N),'_',num2str(Kfactor),'_',num2str(block_number),'_',num2str(seed)],'codewords','-ascii');
save(['./PredictingData/llr',num2str(K),'_',num2str(N),'_',num2str(Kfactor),'_',num2str(block_number),'_',num2str(seed)],'llr','-ascii');
save(['./PredictingData/hat_a',num2str(K),'_',num2str(N),'_',num2str(Kfactor),'_',num2str(block_number),'_',num2str(seed)],'decoded_bits','-ascii');
