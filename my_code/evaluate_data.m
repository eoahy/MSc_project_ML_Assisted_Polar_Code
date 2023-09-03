%not use any more
addpath(genpath('../'))
encoded_bits = load('PredictingData/a8_32_6_0_0');
decoded_bits_SCL = load('PredictingData/hat_a8_32_6_0_0');
%encoded_bits = load('TrainingData/train_a8_32_6_0_0');
%decoded_bits_SCL = load('TrainingData/train_hat_a8_32_6_0_0');
decoded_bits_DeepLearning = load('/Users/eoahy/pythonfile/PolarTest/2.txt');
[m,n] = size(encoded_bits);
for i = 1:m
    for j = 1:n
if decoded_bits_DeepLearning(i,j) <0.5
    decoded_bits_DeepLearning(i,j) = 0;
else
    decoded_bits_DeepLearning(i,j) = 1;
end
    end
end
ber_SCL = length(find(decoded_bits_SCL-encoded_bits)~=0)/(m*n);
ber_DeepLearning = length(find(decoded_bits_DeepLearning-encoded_bits)~=0)/(m*n);