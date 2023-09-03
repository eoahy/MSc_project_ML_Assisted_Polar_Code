%SCL decoder BLER vs EsN0
addpath(genpath('../'))
%   information bits number
K=256;
%   number of input and output bits
N=1024;
%   encoded bits number
E=1024;
Kfactor=0;
L=8;
min_sum=1;
seed = 0;
EsN0_start = -5;
EsN0_delta = 0.5;
target_block_errors = 50;
target_BLER = 1e-3;
BLER = [1];
BER = [1];
%   Q_N will be a row vector comprising N number of unique integers in the
%   range 1 to N. Each successive element of Q_N provides the index of the
%   next most reliable input to the polar encoder kernal, where the first
%   element of Q_N gives the index of the least reliable bit and the last
%   element gives the index of the most reliable bit.
Q_N = get_3GPP_sequence_pattern(N);
[rate_matching_pattern, mode] = get_3GPP_rate_matching_pattern(K,N,E);
info_bit_pattern = get_info_bit_pattern(K, Q_N, rate_matching_pattern);
rng(seed);
block_counts = [0];
block_error_counts = [0];
error_counts = [0];
% Initialise the BLER and SNR
EsN0 = EsN0_start;
Flag = 1;
while Flag && block_error_counts(end) < target_block_errors
    a = round(rand(1,K));
    f = polar_encoder(a, info_bit_pattern, rate_matching_pattern);
    f2 = [f,zeros(1,mod(-length(f),2))];
    tx = sqrt(1/2)*(2*f2(1:2:end)-1)+1i*sqrt(1/2)*(2*f2(2:2:end)-1);
    N0 = 1/(10^(EsN0(end)/10));
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
    a_hat = polar_decoder(f_tilde, info_bit_pattern, rate_matching_pattern, mode, L, min_sum);
    if ~isequal(a,a_hat)
        block_error_counts(end) = block_error_counts(end) + 1;
    end
    block_counts(end) = block_counts(end) + 1;
    BLER = block_error_counts(end)/block_counts(end);
    error_counts(end) = error_counts(end)+length(find(a-a_hat~=0));

    if BLER < target_BLER && block_error_counts(end) >= target_block_errors
        Flag = 0;
    else
        Flag = 1;
    end
    if block_error_counts(end) >= target_block_errors && Flag == 1
        block_error_counts(end+1) = 0;
        block_counts(end+1) = 0;
        error_counts(end+1) = 0;
        EsN0(end+1) = EsN0_delta+EsN0(end);
    end
    if (mod(block_counts(end),10)==0)
        fprintf('%f\t%e\t%i\t%i\n',EsN0(end),BLER,block_counts(end),block_error_counts(end)); 
    end
end
filename = ['./results/K_',num2str(K),'_E_',num2str(E),'_L_',num2str(L),'_',num2str(target_block_errors),'_',num2str(log10(target_BLER))];
save(filename,'EsN0','block_counts','block_error_counts','error_counts');