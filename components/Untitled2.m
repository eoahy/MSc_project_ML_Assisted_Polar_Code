% The CRC polynomial used in 3GPP PBCH and PDCCH channel is
% D^24 + D^23 + D^21 + D^20 + D^17 + D^15 + D^13 + D^12 + D^8 + D^4 + D^2 + D + 1
a=round(rand(1,32))
crc_polynomial_pattern = [1 1 0 1 1 0 0 1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1];
P = length(crc_polynomial_pattern)-1;
A=32;
% Determine the number of information and CRC bits.
K = A+P; 

% Get the 3GPP CRC interleaver pattern.
crc_interleaver_pattern = get_3GPP_crc_interleaver_pattern(K);

% Generate the CRC bits and append them to the information bits.
G_P = get_crc_generator_matrix(A,crc_polynomial_pattern);
crc_bits=  mod(a*G_P,2) % The CRC bits  generated
b = [a, mod(a*G_P,2)]