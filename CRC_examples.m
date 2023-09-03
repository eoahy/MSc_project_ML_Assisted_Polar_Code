% %%%%%%%%%%% CRC-24 Interleaving with initialize 1  %%%%%%%%%%%%%%%%%%%


crc_polynomial_pattern = [1 1 0 1 1 0 0 1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1];
a=[ 0 1 1 0 0 1 1 1 0 1 1 0] % my information bits 12 býts
A=12;  % the number of bits in the  information bit sequence.
P = length(crc_polynomial_pattern)-1
% Generate the CRC bits.

G_P = get_crc_generator_matrix(A,crc_polynomial_pattern);
a2 = a;
a2((1:A)<=P) = ~a2((1:A)<=P); % Toggle the first P bits to model a CRC that is initialised with all ones
crc_bits = mod(a2*G_P,2)
crc_bits((A+1:A+P) <= P) = ~crc_bits((A+1:A+P) <= P)
crc_scrambling_pattern=fliplr(crc_bits)
% Scramble the CRC bits.
scrambled_crc_bits = xor(crc_bits,[zeros(1,P-length(crc_scrambling_pattern)),crc_scrambling_pattern])
 
% Append the scrambled CRC bits to the information bits.
b = [a, scrambled_crc_bits]
K = ceil(A/1)+P
% 
 crc_interleaver_pattern = get_3GPP_crc_interleaver_pattern(K)%Obtain (CRC) interleaver pattern
% Interleave the information and CRC bits.
 c = b(crc_interleaver_pattern)
 
 
 
%%%%%%%%%CRC examle for CRC-6%%%%%%%%%%%%%%%%%%%%
% crc_polynomial_pattern = [1 1 0 0 0 0 1] % for CRC-6
% a=[0 1 1 0 0 1 1 1 0 1 1 0] % my information bits
% A=12  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern)
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated

%%%%%%%%%CRC examle for CRC-3%%%%%%%%%%%%%%%%%%%%
% crc_polynomial_pattern = [1  0  1 1] % for CRC-3
% a=[1 1 1 0] % my information bits
% A=4  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern)
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated

% %%%%%%%%%CRC examle for CRC-11%%%%%%%%%%%%%%%%%%%%
% crc_polynomial_pattern = [1 1 1 0 0 0 1 0 0 0 0 1] % for CRC-11
% a=[0 1 1 0 0 1 1 1 0 1 1 0 0 1 1 0 0 1 1 1 ] % my information bits
% A=20  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern)
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated


%%%%%%%%%CRC examle for CRC-24%%%%%%%%%%%%%%%%%%%%
% crc_polynomial_pattern = [1 1 0 1 1 0 0 1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1]; % for CRC-24
% a=[0 1 1 0 0 1 1 1 0 1 1 0] % my information bits
% A=12  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern);
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated



%%%%%%%%%%%  CRC INTERLEAVING  %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%CRC-6 Interleaving %%%%%%%%%%%%%%%%%%%
%
% crc_polynomial_pattern = [1 1 0 0 0 0 1] % for CRC-6
% a=[0 1 1 0 0 1 1 1 0 1 1 0] % my information bits
% A=12  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern)
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated
%
%  % Use one segment
%     C = 1;
% % Determine the number of information and CRC bits.
% P = length(crc_polynomial_pattern)-1
% K = ceil(A/C)+P
%
% Pi = get_3GPP_crc_interleaver_pattern(K)


% %%%%%%%%%%%CRC-11 Interleaving %%%%%%%%%%%%%%%%%%%
% 
% crc_polynomial_pattern = [1 1 1 0 0 0 1 0 0 0 0 1] % for CRC-11
% a=[0 1 1 0 0 1 1 1 0 1 1 0] % my information bits
% A=12;  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern);
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated
% 
% % A<19 Use one segment
% C = 1;
% % Determine the number of information and CRC bits.
% P = length(crc_polynomial_pattern)-1
% K = ceil(A/C)+P
% 
% Pi = get_3GPP_crc_interleaver_pattern(K)%Obtain (CRC) interleaver pattern
% 
% %Codeword
% % b=flip(a)
% b=[a crc_bits]
% %Ýmplement Interleaving
% % b_k=[b crc_bits]
% c=b(Pi)

% %%%%%%%%%%%CRC-24 Interleaving %%%%%%%%%%%%%%%%%%%
% 
% crc_polynomial_pattern = [1 1 0 1 1 0 0 1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1];
% a=[0 1 1 0 0 1 1 1 0 1 1 0] % my information bits 12 býts
% A=12;  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern);
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated
% 
% % A<19 Use one segment
% C = 1;
% % Determine the number of information and CRC bits.
% P = length(crc_polynomial_pattern)-1
% K = ceil(A/C)+P
% 
% Pi = get_3GPP_crc_interleaver_pattern(K)%Obtain (CRC) interleaver pattern
% 
% %Codeword
% % b=flip(a)
% b=[a crc_bits]
% %Ýmplement Interleaving
% % b_k=[b crc_bits]
% c=b(Pi)

% %%%%%%%%%%%CRC-24 Interleaving Info bit 16 %%%%%%%%%%%%%%%%%%%
% 
% crc_polynomial_pattern = [1 1 0 1 1 0 0 1 0 1 0 1 1 0 0 0 1 0 0 0 1 0 1 1 1];
% a=[0 1 0 1 0 1 1 0 0 1 1 1 0 1 1 0] % my information bits 16 býts
% A=16;  % the number of bits in the  information bit sequence.
% G_P = get_crc_generator_matrix(A, crc_polynomial_pattern);
% crc_bits=  mod(a*G_P,2) % The CRC bits  generated
% 
% % A<19 Use one segment
% C = 1;
% % Determine the number of information and CRC bits.
% P = length(crc_polynomial_pattern)-1
% K = ceil(A/C)+P
% 
% Pi = get_3GPP_crc_interleaver_pattern(K)%Obtain (CRC) interleaver pattern
% 
% %Codeword
% % b=flip(a)
% b=[a crc_bits]
% %Ýmplement Interleaving
% % b_k=[b crc_bits]
% c=b(Pi)