A=512
G=1024
L=8
min_sum=0

EsN0=3;
N0 = 1/(10^(EsN0/10));
% Generate a random block of bits
a = round(rand(1,A));

% Perform polar encoding
f = PUCCH_encoder(a, G);

% QPSK modulation
f2 = [f,zeros(1,mod(-length(f),2))];
tx = sqrt(1/2)*(2*f2(1:2:end)-1)+1i*sqrt(1/2)*(2*f2(2:2:end)-1);

% Simulate transmission
rx = tx + sqrt(N0/2)*(randn(size(tx))+1i*randn(size(tx)));

% QPSK demodulation
f2_tilde = zeros(size(f2));
f2_tilde(1:2:end) = -4*sqrt(1/2)*real(rx)/N0;
f2_tilde(2:2:end) = -4*sqrt(1/2)*imag(rx)/N0;
f_tilde = f2_tilde(1:length(f));

% Perform polar decoding
a_hat = PUCCH_decoder(f_tilde, A, L, min_sum);

if a==a_hat
    display('correct');
else
    display('wrong');
end