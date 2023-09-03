% Pr = symbol prob
% BitPr = bit Prob
% mat= matrix
%  'm>>i' in C++ equals 'bitshift(m,-i)' in matlab: shifting 'm' by 'i'
%  bits to the right.
%   Hence:   (m>>i)&1
%    equals:  bitshift(m,-i) & 1

function BitPr  = symbol_to_bit_prob_convertor_siso(N,  bps, Pr)
% Symbol probability convert to bit probability
%   'N'   - number of Symbols
%   'bps' - Bit per symbol
%   'Pr'  - Symbol probability (log domain)

   % array of bit probability 
   % row: numbers of bits = numbers of symbol* (number of bits/symbol)
   % column: prob of 0, prob of 1 
BitPr = zeros(N*bps,2)-10000;
%BitPr = -10000;

M = 2^bps;


for k= 1:N
        for i =1:bps % bps = number of bits/symbol (QPSK: bps=2)
            for m = 0: M-1  % M = number of levels (QPSK: M=4)
                               
                % shift 1,2
                one_or_zero = bitand( bitshift(m,-(i-1)), 1);
                %BitPr(i + (k-1)*bps, one_or_zero + 1 ) = BitPr(i + (k-1)*bps, one_or_zero +1 ) + Pr(k,m+1)*K;
                BitPr(i + (k-1)*bps, one_or_zero + 1 ) = jacolog(BitPr(i + (k-1)*bps, one_or_zero +1 ), Pr(k,m+1)); % Pr(k,m): kth symbol probability
            end
            
            max = BitPr(i + (k-1)*bps, 1);
            if max < BitPr(i + (k-1)*bps, 2)
                max = BitPr(i + (k-1)*bps, 2);
            end
            % normalization
            for m =1 : 2
                BitPr( i + (k-1)*bps,m) = BitPr(i + (k-1)*bps,m) - max;
            end
        end %  bit0/ bit1 prob calculation
end % finish a symbol
