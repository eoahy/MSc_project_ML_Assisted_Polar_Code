function try_LLR_PUCCH(code, A, E, L, min_sum,EsN0)
% try_LLR_PUCCH('PUCCH',12, 34, 1,0,  2)

%   code should be a string. This identifies which encoder and decoder
%   functions to call. For example, if code is 'custom1', then the
%   functions custom1_encoder and custom1_decoder will be called. The
%   encoder function should have a format f = custom1_encoder(a, E). The
%   decoder function should have a format
%   a_hat = custom1_decoder(f_tilde, A, L, min_sum). Refer to these
%   functions for explanations of their inputs and outputs. Suitable values
%   for code include 'PBCH', 'PDCCH, 'PUCCH' and 'custom1'.
%
%   A should be an integer row vector. Each element specifies the number of
%   bits in each set of simulated information bit sequences, before CRC and
%   other redundant bits are included.
%
%   E should be an integer row vector. Each element of E specifies one
%   encoded block length to simulate, where E is the number of bits in each
%   encoded bit sequence.
%
%   L should be a scalar integer. It specifies the list size to use during
%   Successive Cancellation List (SCL) decoding.
%
%   min_sum shoular be a scalar logical. If it is true, then the SCL
%   decoding process will be completed using the min-sum approximation.
%   Otherwise, the log-sum-product will be used. The log-sum-product gives
%   better error correction capability than the min-sum, but it has higher
%   complexity.
%


%
%   EsN0_start should be a real row vector, having the same length as the
%   vector of coding rates. Each value specifies the Es/N0 SNR to begin at
%   for the simulation of the corresponding coding rate.





% Convert from SNR (in dB) to noise power spectral density
N0 = 1/(10^(EsN0/10));

% Generate a random frame of bits
% a = round(rand(1,A(A_index)));

a=[ 0     1     1     0     0     1     1     1     0     1     1     0]
% Perform polar encoding
f = feval([code,'_encoder'], a, E)

% QPSK modulation
f2 = [f,zeros(1,mod(-length(f),2))];
tx = sqrt(1/2)*(2*f2(1:2:end)-1)+1i*sqrt(1/2)*(2*f2(2:2:end)-1);

% Simulate transmission
rx = tx + sqrt(N0/2)*(randn(size(tx))+1i*randn(size(tx)));

% QPSK demodulation
f2_tilde = zeros(size(f2));
f2_tilde(1:2:end) = -4*sqrt(1/2)*real(rx)/N0;
f2_tilde(2:2:end) = -4*sqrt(1/2)*imag(rx)/N0;
f_tilde = f2_tilde(1:length(f))

% Perform polar decoding
a_hat = feval([code, '_decoder'],f_tilde,A,L,min_sum)

if  ~isequal(a,a_hat)
    display('wrong')
end

end
